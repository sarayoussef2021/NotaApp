"""
Notara OMR Service — oemer (deep learning) without preprocessing.
oemer works best on raw, unprocessed images.
"""
import base64
import io
import os
import subprocess
import tempfile
import time
import xml.etree.ElementTree as ET
from typing import List

from PIL import Image
from fastapi import FastAPI, UploadFile, File, Form
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="Notara OMR Service")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], allow_methods=["*"], allow_headers=["*"],
)


# -----------------------------------------------------------------------------
# LIGHT RESIZE (only for very large images)
# -----------------------------------------------------------------------------
def resize_for_speed(image: Image.Image, max_width: int = 2000) -> Image.Image:
    """
    Downscale only very large images to speed up OMR.
    No other preprocessing is applied — oemer performs best on raw images.
    """
    w, h = image.size
    if w <= max_width:
        return image
    scale = max_width / w
    new_size = (max_width, int(h * scale))
    return image.resize(new_size, Image.LANCZOS)


# -----------------------------------------------------------------------------
# OEMER RUNNER
# -----------------------------------------------------------------------------
def run_oemer(image: Image.Image) -> tuple[str, str]:
    """Run oemer. Returns (musicxml, teaser_png_base64)."""
    with tempfile.TemporaryDirectory() as tmp:
        out_dir = os.path.join(tmp, "out")
        os.makedirs(out_dir, exist_ok=True)

        img_path = os.path.join(tmp, "in.png")
        if image.mode != "RGB":
            image = image.convert("RGB")
        image.save(img_path, "PNG")

        result = subprocess.run(
            ["oemer", img_path, "-o", out_dir],
            capture_output=True,
            text=True,
            timeout=900,
        )

        mxl_files = [f for f in os.listdir(out_dir) if f.endswith(".musicxml")]
        if not mxl_files:
            raise RuntimeError(
                f"oemer: no MusicXML. stderr tail: {result.stderr[-800:]}"
            )

        chosen = next(
            (f for f in mxl_files if "quarter" in f.lower()),
            mxl_files[0],
        )
        with open(os.path.join(out_dir, chosen), "r", encoding="utf-8") as fh:
            musicxml = fh.read()

        teaser_b64 = ""
        teaser = [f for f in os.listdir(out_dir) if "teaser" in f.lower()]
        if teaser:
            with open(os.path.join(out_dir, teaser[0]), "rb") as fh:
                teaser_b64 = base64.b64encode(fh.read()).decode("ascii")

        return musicxml, teaser_b64


# -----------------------------------------------------------------------------
# MUSICXML PARSING
# -----------------------------------------------------------------------------
def parse_musicxml_notes(musicxml: str) -> List[dict]:
    """Extract notes from MusicXML."""
    root = ET.fromstring(musicxml)
    notes: List[dict] = []
    note_id = 0
    measure_idx = 0

    for elem in root.iter():
        tag = elem.tag.split('}')[-1]

        if tag == "measure":
            measure_idx += 1
            continue

        if tag != "note":
            continue

        # Skip rests and grace notes
        if any(c.tag.split('}')[-1] == "rest" for c in elem):
            continue
        if any(c.tag.split('}')[-1] == "grace" for c in elem):
            continue

        pitch_el = next(
            (c for c in elem if c.tag.split('}')[-1] == "pitch"),
            None,
        )
        if pitch_el is None:
            continue

        step = octave = alter = None
        for c in pitch_el:
            t = c.tag.split('}')[-1]
            if t == "step":
                step = c.text
            elif t == "octave":
                octave = int(c.text)
            elif t == "alter":
                alter = int(c.text)

        if not step or octave is None:
            continue

        accidental = ""
        if alter == 1:
            accidental = "#"
        elif alter == -1:
            accidental = "b"

        dur_el = next(
            (c for c in elem if c.tag.split('}')[-1] == "duration"),
            None,
        )
        duration = int(dur_el.text) if dur_el is not None else 1

        staff_el = next(
            (c for c in elem if c.tag.split('}')[-1] == "staff"),
            None,
        )
        staff_num = int(staff_el.text) if staff_el is not None else 1
        staff_name = "treble" if staff_num == 1 else "bass"

        is_chord = any(c.tag.split('}')[-1] == "chord" for c in elem)

        notes.append({
            "id": f"n-{note_id}",
            "type": "note",
            "pitch": step,
            "octave": octave,
            "accidental": accidental,
            "x": 0.5,
            "y": 0.5,
            "measure": measure_idx,
            "staff": staff_name,
            "duration": duration,
            "isChord": is_chord,
        })
        note_id += 1

    return notes


# -----------------------------------------------------------------------------
# ENDPOINTS
# -----------------------------------------------------------------------------
@app.post("/process")
async def process(file: UploadFile = File(...), locale: str = Form("en")):
    t0 = time.time()

    data = await file.read()
    image = Image.open(io.BytesIO(data))
    original_size = image.size

    # Only resize very large images — no binarization, no erosion, no contrast boost
    image = resize_for_speed(image, max_width=2000)
    resized_size = image.size

    try:
        musicxml, teaser_b64 = run_oemer(image)
        notes = parse_musicxml_notes(musicxml)
        elapsed = round(time.time() - t0, 1)

        return JSONResponse({
            "musicxml": musicxml,
            "engine": "oemer",
            "confidence": 0.9,
            "notes": notes,
            "teaser_png_base64": teaser_b64,
            "debug": {
                "original_size": list(original_size),
                "processed_size": list(resized_size),
                "total_notes": len(notes),
                "musicxml_bytes": len(musicxml),
                "elapsed_seconds": elapsed,
            },
        })
    except Exception as e:
        import traceback
        traceback.print_exc()
        return JSONResponse({
            "musicxml": "",
            "engine": "error",
            "confidence": 0.0,
            "notes": [],
            "debug": {"error": str(e)},
        }, status_code=500)


@app.get("/health")
def health():
    return {"status": "ok", "service": "notara-omr", "engine": "oemer"}