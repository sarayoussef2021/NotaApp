AppNota — Read music, note by note
AppNota is a music-learning tool for solfège students. Upload any sheet music image, and AppNota automatically writes the name of every note under it — correctly mapped to the clef (treble, bass, alto) and available in English, French, and Arabic.

It combines a deep-learning Optical Music Recognition (OMR) pipeline with a Serverpod backend and both web (Vue 3) and mobile (Flutter) clients.

✨ Features
📤 Upload any score — PNG, JPG, or PDF

🎼 Automatic note detection — deep-learning OMR via oemer (PyTorch)

📝 Annotated rendering — every note gets its name displayed under it, on the correct staff line

🌍 Multilingual — English (C, D, E), French (Do, Ré, Mi), Arabic (دو, ري, مي) with RTL support

📚 Personal library — paginated, searchable, persistent

📄 PDF export — download the annotated score for print

📱 Flutter mobile client — native UI, same backend, type-safe SDK

🏗️ Architecture

┌─────────────────┐         ┌──────────────────┐
│  Vue 3 Web App  │         │  Flutter Mobile  │
│  (port 5173)    │         │  (Edge / Desktop)│
└────────┬────────┘         └────────┬─────────┘
         │                           │
         │       Serverpod SDK       │
         │      (auto-generated)     │
         └───────────┬───────────────┘
                     │
         ┌───────────▼───────────────┐
         │   Serverpod 4 Backend     │
         │   (Dart, port 8080)       │
         │   ┌─────────────────────┐ │
         │   │  PostgreSQL 16      │ │
         │   │  (port 5433)        │ │
         │   └─────────────────────┘ │
         └───────────┬───────────────┘
                     │  HTTP
         ┌───────────▼───────────────┐
         │   Python FastAPI Service  │
         │   (port 8001)             │
         │   ┌─────────────────────┐ │
         │   │  oemer (PyTorch)    │ │
         │   │  OMR engine         │ │
         │   └─────────────────────┘ │
         └───────────────────────────┘
Flow:

User uploads an image from web or mobile

Serverpod receives it and calls the Python OMR service

oemer detects every note, returns MusicXML

Serverpod parses the MusicXML into typed DetectedNote objects

Everything is persisted in PostgreSQL

The client receives the score with structured note data

OpenSheetMusicDisplay renders the score + note labels are overlaid

🛠️ Tech Stack
Layer	Technology
Backend	Serverpod 4 (Dart) + PostgreSQL 16
OMR microservice	Python 3.11 + FastAPI + oemer (PyTorch)
Web client	Vue 3 + TypeScript + Vite
Mobile client	Flutter (Material 3)
Score rendering	OpenSheetMusicDisplay (SVG)
Audio (planned)	Tone.js
🚀 Quick Start
Prerequisites
Dart 3.5+ and Serverpod CLI 4.0.4

Python 3.11 (oemer has no wheels for 3.12+ yet)

Node.js 18+

Flutter 3.x

Docker (for PostgreSQL)

1. PostgreSQL

docker run -d --name appnota-pg \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=appnota \
  -p 5433:5432 postgres:16
⚠️ Port 5433 (not 5432) to avoid conflicts with an existing PostgreSQL instance.

2. OMR microservice

cd omr-service
python -m venv .venv
# Windows
.\.venv\Scripts\Activate.ps1
# Linux / macOS
source .venv/bin/activate

pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port 8001 --reload
First run downloads ~230 MB of model weights (oemer checkpoints). This is a one-time cost.

3. Serverpod backend

cd backend/backend_server
serverpod generate
dart run bin/main.dart --apply-migrations
The server starts on http://localhost:8080.

4. Web frontend

cd frontend
npm install
npm run dev
Open http://localhost:5173.

5. Flutter mobile client

cd backend/backend_flutter
flutter pub get

# Windows desktop (requires Developer Mode)
flutter run -d windows

# Or run in Edge (no Visual Studio needed)
flutter run -d edge --dart-define=API_HOST=http://localhost:8080
📁 Project Structure

appnota/
├── backend/
│   ├── backend_client/       # Serverpod auto-generated Dart client
│   ├── backend_flutter/      # Flutter mobile app
│   └── backend_server/       # Serverpod server (Dart)
│       ├── lib/src/
│       │   ├── endpoints/    # score_endpoint, contact_endpoint
│       │   ├── models/       # .spy.yaml definitions
│       │   └── generated/    # Auto-generated (do not edit)
│       └── migrations/
├── frontend/                 # Vue 3 + TypeScript web app
│   ├── src/
│   │   ├── components/       # ScoreViewer, NoteList, NavBar, ...
│   │   ├── views/            # HomeView, LibraryView, ScoreDetailView
│   │   ├── services/         # api, scoreService, pdfExport
│   │   ├── locales/          # en.json, fr.json, ar.json
│   │   └── router/
│   └── package.json
├── omr-service/              # Python FastAPI + oemer
│   ├── main.py
│   └── requirements.txt
└── README.md
🔌 Serverpod Endpoints
Endpoint	Method	Description
score.upload	POST	Upload a file, run OMR, persist the score
score.list	POST	Paginated, searchable list of scores
score.getById	POST	Fetch a single score with full MusicXML
score.delete	POST	Remove a score from the library
contact.send	POST	Store a contact message
All endpoints are typed and consumed by both the web and mobile clients through Serverpod's auto-generated SDK.

📊 Data Models
Score (table score)

title, fileName, fileType

imageUrl (oemer teaser or original image, base64)

engine, confidence

rawMusicXml (full MusicXML string)

notes: List<DetectedNote> (JSONB)

createdAt, updatedAt

DetectedNote (embedded, JSONB)

noteId, type (note | rest)

pitch (C, D, E, F, G, A, B)

octave, accidental (# | b | "")

measure, staff (treble | bass)

x, y, duration

ContactMessage (table contact_message)

name, email, message, locale, handled, createdAt

⚠️ Known Limitations
oemer processing time: 2–5 minutes per score on CPU. GPU support (CUDA) can reduce this to ~30 seconds.

High-density scores: very dense polyphonic scores with many ledger lines may reduce detection accuracy.

Preprocessing: oemer works best on raw images. Applying binarization or erosion reduces accuracy.

🤝 Contributing
This project was built as a demonstration of Serverpod + Flutter for OMR. Pull requests are welcome — especially around:

GPU acceleration for oemer

Additional language support

Improved score segmentation for multi-page inputs

🙏 Acknowledgements
oemer — Optical Music Recognition engine (MIT)

Serverpod — Dart backend framework

OpenSheetMusicDisplay — MusicXML renderer

Flutter — Mobile UI toolkit

Built with ♪ by Sara YOUSSEF..

## Copyright

© 2026 Sara YOUSSEF. All rights reserved.
