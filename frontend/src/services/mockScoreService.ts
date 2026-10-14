import type { Score, DetectedNote } from "../types";

const STORAGE_KEY = "appnota.scores";

/** Charge toutes les partitions (mock : localStorage) */
function loadAll(): Score[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    return raw ? (JSON.parse(raw) as Score[]) : seedScores();
  } catch {
    return seedScores();
  }
}

function saveAll(scores: Score[]) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(scores));
}

/** Donne un échantillon de données au premier lancement */
function seedScores(): Score[] {
  const demo: Score[] = [
    {
      id: "demo-1",
      title: "Love Story",
      composer: "Taylor Swift",
      arrangedBy: "Emily T.",
      imageUrl: "/demo/love-story.png", // placez votre image dans /public/demo/
      engine: "oemer",
      createdAt: new Date().toISOString(),
      notes: buildLoveStoryNotes(),
    },
  ];
  saveAll(demo);
  return demo;
}

/**
 * Construit les annotations correspondant à l'exemple "Love Story".
 * Coordonnées normalisées (x, y) entre 0 et 1.
 */
function buildLoveStoryNotes(): DetectedNote[] {
  const out: DetectedNote[] = [];
  const trebleNotes = ["C", "D", "E", "F", "G", "A", "B"] as const;

  // Ligne 1 (clef de sol) : 4 silences — affichés en bleu
  // On simule 4 silences dans la 1re mesure.
  for (let m = 0; m < 4; m++) {
    out.push({
      id: `r-${m}`,
      type: "rest",
      x: 0.16 + m * 0.18,
      y: 0.17,
      measure: m + 1,
      staff: "treble",
    });
  }

  // Ligne 2 (clef de fa) : première mesure Do, Mi (x2)
  const bassPattern: ("C" | "E")[] = ["C", "E", "C", "E"];
  bassPattern.forEach((pitch, i) => {
    out.push({
      id: `b-${i}`,
      type: "note",
      pitch,
      octave: 3,
      accidental: "",
      x: 0.14 + i * 0.055,
      y: 0.245,
      measure: 1,
      staff: "bass",
    });
  });

  // Quelques notes aiguës pour l'exemple
  trebleNotes.slice(0, 4).forEach((pitch, i) => {
    out.push({
      id: `t-${i}`,
      type: "note",
      pitch,
      octave: 4,
      accidental: "",
      x: 0.14 + i * 0.07,
      y: 0.205,
      measure: 1,
      staff: "treble",
    });
  });

  return out;
}

/**
 * Simule l'upload + l'analyse OMR.
 * En production : POST /score/upload → { musicxml, notes[] }
 */
export async function analyzeScore(
  file: File,
  title: string,
): Promise<Score> {
  // Simulation d'un délai d'analyse
  await new Promise((r) => setTimeout(r, 1400));

  // Convertit le fichier en data URL pour l'afficher immédiatement
  const imageUrl = await fileToDataUrl(file);

  const score: Score = {
    id: `local-${Date.now()}`,
    title: title || file.name.replace(/\.[^.]+$/, ""),
    composer: "",
    arrangedBy: "",
    imageUrl,
    engine: "oemer",
    createdAt: new Date().toISOString(),
    notes: buildLoveStoryNotes(),
  };

  const all = loadAll();
  all.unshift(score);
  saveAll(all);

  return score;
}

export async function listScores(params: {
  query?: string;
  page?: number;
  pageSize?: number;
}): Promise<{ items: Score[]; total: number }> {
  const { query = "", page = 1, pageSize = 9 } = params;
  const all = loadAll();

  const filtered = query
    ? all.filter((s) =>
        s.title.toLowerCase().includes(query.toLowerCase()),
      )
    : all;

  const start = (page - 1) * pageSize;
  const items = filtered.slice(start, start + pageSize);

  return { items, total: filtered.length };
}

function fileToDataUrl(file: File): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => resolve(reader.result as string);
    reader.onerror = reject;
    reader.readAsDataURL(file);
  });
}

export const ALLOWED_TYPES = [
  "image/png",
  "image/jpeg",
  "image/jpg",
  "application/pdf",
];

export const MAX_FILE_SIZE = 20 * 1024 * 1024; // 20 MB