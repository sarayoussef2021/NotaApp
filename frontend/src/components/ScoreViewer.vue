<script setup lang="ts">
import { onMounted, ref, watch, nextTick } from "vue";
import { OpenSheetMusicDisplay } from "opensheetmusicdisplay";

const props = defineProps<{
  musicxml: string;
  language: string;
  title?: string;
  notes?: any[];
}>();

const container = ref<HTMLDivElement | null>(null);
const error = ref("");

const NOTE_MAP: Record<string, Record<string, string>> = {
  C: { en: "C", fr: "Do", ar: "دو" },
  D: { en: "D", fr: "Ré", ar: "ري" },
  E: { en: "E", fr: "Mi", ar: "مي" },
  F: { en: "F", fr: "Fa", ar: "فا" },
  G: { en: "G", fr: "Sol", ar: "صول" },
  A: { en: "A", fr: "La", ar: "لا" },
  B: { en: "B", fr: "Si", ar: "سي" },
};

function labelFor(note: any): string {
  const lang = ["en", "fr", "ar"].includes(props.language)
    ? props.language
    : "en";
  if (!note) return "";
  const pitch = (note.pitch || "").toUpperCase();
  if (!pitch) return "";
  const base = NOTE_MAP[pitch]?.[lang] || pitch;
  const acc = note.accidental || "";
  const accSym =
    acc === "#" ? "♯" : acc === "b" ? "♭" : acc === "natural" ? "♮" : "";
  return base + accSym;
}

async function renderScore() {
  if (!container.value || !props.musicxml) return;
  container.value.innerHTML = "";
  error.value = "";

  try {
    const osmd = new OpenSheetMusicDisplay(container.value, {
      autoResize: true,
      backend: "svg",
      drawTitle: false,
      drawingParameters: "compacttight",
    });
    await osmd.load(props.musicxml);
    osmd.render();

    // Attendre le rendu complet du SVG puis annoter
    setTimeout(() => {
      annotateFromDOM();
    }, 500);
  } catch (e: any) {
    console.error("OSMD render failed:", e);
    error.value = e?.message || "Erreur de rendu";
  }
}

/**
 * Approche DOM directe : on récupère tous les .vf-notehead du SVG,
 * on les trie en ordre de lecture (haut→bas, gauche→droite),
 * et on place le nom de chaque note du backend sous le notehead correspondant.
 */
function annotateFromDOM() {
  const containerEl = container.value;
  if (!containerEl) return;

  const svg = containerEl.querySelector("svg");
  if (!svg) {
    console.warn("SVG introuvable");
    return;
  }

  const noteheads = Array.from(svg.querySelectorAll(".vf-notehead"));
  console.log(`Noteheads dans le SVG : ${noteheads.length}`);

  const notes = props.notes || [];
  console.log(`Notes du backend : ${notes.length}`);

  if (noteheads.length === 0 || notes.length === 0) {
    console.warn("Rien à annoter");
    return;
  }

  // === 1. Récupérer la position écran de chaque notehead ===
  const containerRect = containerEl.getBoundingClientRect();
  const items = noteheads.map((nh) => {
    const r = nh.getBoundingClientRect();
    return {
      x: r.left + r.width / 2 - containerRect.left,
      y: r.top + r.height - containerRect.top,
    };
  });

  // === 2. Trier en ordre de lecture ===
  // On trie d'abord par Y (haut → bas), puis on regroupe par "lignes"
  // avec une tolérance, et on trie chaque ligne par X (gauche → droite).
  const sortedByY = [...items].sort((a, b) => a.y - b.y);

  const rows: { y: number; items: typeof items }[] = [];
  const ROW_TOLERANCE = 40; // pixels

  for (const it of sortedByY) {
    let placed = false;
    for (const row of rows) {
      if (Math.abs(row.y - it.y) < ROW_TOLERANCE) {
        row.items.push(it);
        placed = true;
        break;
      }
    }
    if (!placed) {
      rows.push({ y: it.y, items: [it] });
    }
  }

  for (const row of rows) {
    row.items.sort((a, b) => a.x - b.x);
  }

  const orderedNoteheads = rows.flatMap((r) => r.items);
  console.log(`Noteheads ordonnés : ${orderedNoteheads.length}`);

  // === 3. Créer l'overlay et placer les labels ===
  // Supprimer un éventuel overlay existant (cas de re-render)
  const oldOverlay = containerEl.querySelector(".note-overlay");
  if (oldOverlay) oldOverlay.remove();

  // S'assurer que le container est en position relative
  if (getComputedStyle(containerEl).position === "static") {
    containerEl.style.position = "relative";
  }

  const overlay = document.createElement("div");
  overlay.className = "note-overlay";
  overlay.style.position = "absolute";
  overlay.style.inset = "0";
  overlay.style.pointerEvents = "none";
  overlay.style.zIndex = "10";

  const total = Math.min(orderedNoteheads.length, notes.length);
  console.log(`Appariement : ${total} labels à placer`);

  for (let i = 0; i < total; i++) {
    const pos = orderedNoteheads[i];
    const note = notes[i];
    const label = labelFor(note);

    if (!label) continue;

    const span = document.createElement("span");
    span.textContent = label;
    span.style.position = "absolute";
    span.style.left = `${pos.x}px`;
    span.style.top = `${pos.y + 2}px`;
    span.style.transform = "translateX(-50%)";
    span.style.fontSize = "11px";
    span.style.fontWeight = "700";
    span.style.color = "#e63946";
    span.style.fontFamily = "system-ui, -apple-system, sans-serif";
    span.style.whiteSpace = "nowrap";
    span.style.pointerEvents = "none";
    span.style.textShadow = "0 0 3px white, 0 0 3px white";
    overlay.appendChild(span);
  }

  containerEl.appendChild(overlay);
  console.log(`✅ ${overlay.children.length} labels ajoutés`);
}

onMounted(renderScore);
watch(() => props.musicxml, renderScore);
watch(() => props.language, renderScore);
watch(
  () => props.notes,
  () => {
    nextTick(() => annotateFromDOM());
  },
);
</script>

<template>
  <div class="score-wrapper" dir="ltr">
    <h2 v-if="title" class="score-title">{{ title }}</h2>
    <div ref="container" class="score-container"></div>
    <p v-if="error" class="error">{{ error }}</p>
  </div>
</template>

<style scoped>
.score-wrapper {
  background: white;
  padding: 24px;
  border-radius: 12px;
  border: 1px solid var(--border);
  box-shadow: var(--shadow);
}
.score-title {
  text-align: center;
  font-size: 22px;
  font-weight: 600;
  margin: 0 0 20px;
  color: var(--text);
}
.score-container {
  overflow-x: auto;
  position: relative;
}
.score-container :deep(svg) {
  max-width: 100%;
  height: auto;
}
.error {
  color: #ef4444;
  font-size: 13px;
  margin-top: 8px;
}
</style>