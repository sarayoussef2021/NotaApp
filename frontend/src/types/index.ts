export type NoteName = "C" | "D" | "E" | "F" | "G" | "A" | "B";

export interface DetectedNote {
  id: string;
  type: "note" | "rest";
  pitch?: NoteName;
  octave?: number;
  accidental?: "#" | "b" | "";
  x: number;
  y: number;
  measure: number;
  staff: "treble" | "bass";
}

export interface Score {
  id: string | number;
  title: string;
  composer?: string;
  arrangedBy?: string;
  imageUrl: string;
  rawMusicXml?: string;
  engine: string;
  confidence?: number;
  notes: DetectedNote[];
  createdAt: string;
  ownerId?: string;
}