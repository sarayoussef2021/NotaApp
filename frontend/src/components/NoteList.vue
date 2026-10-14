<script setup lang="ts">
import { computed } from "vue";

const props = defineProps<{
  notes: any[];
  language: string;
}>();

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
  if (!note) return "—";
  const pitch = (note.pitch || "").trim().toUpperCase();
  if (!pitch) return "—";
  const base = NOTE_MAP[pitch]?.[lang] || pitch;
  const acc = note.accidental || "";
  const accSym = acc === "#" ? "♯" : acc === "b" ? "♭" : "";
  return base + accSym;
}

const measures = computed(() => {
  const map = new Map<number, any[]>();
  for (const n of props.notes || []) {
    const m = typeof n === "object" && n?.measure ? n.measure : 1;
    if (!map.has(m)) map.set(m, []);
    map.get(m)!.push(n);
  }
  return Array.from(map.entries())
    .sort((a, b) => a[0] - b[0])
    .map(([measure, notes]) => ({ measure, notes }));
});

function copyAll() {
  const text = measures.value
    .map((m) => `Mesure ${m.measure}\t${m.notes.map(labelFor).join("\t")}`)
    .join("\n");
  navigator.clipboard.writeText(text);
}
</script>

<template>
  <div class="note-list" v-if="measures.length">
    <div class="list-header">
      <h3>Notes détectées ({{ props.notes.length }} · {{ measures.length }} mesures)</h3>
      <button class="copy-btn" @click="copyAll" title="Copier tout">📋 Copier</button>
    </div>

    <div class="compact-list">
      <div v-for="m in measures" :key="m.measure" class="measure-line">
        <span class="measure-num">M{{ m.measure }}</span>
        <span class="measure-notes">
          <span
            v-for="(n, i) in m.notes"
            :key="i"
            class="note-badge"
            :class="{ bass: n?.staff === 'bass' }"
          >{{ labelFor(n) }}</span>
        </span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.note-list {
  margin-top: 24px;
  padding: 16px;
  background: #f9fafb;
  border: 1px solid var(--border);
  border-radius: 8px;
}
.list-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
  gap: 12px;
}
h3 {
  font-size: 13px;
  color: var(--text-muted);
  margin: 0;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  font-weight: 600;
}
.copy-btn {
  font-size: 12px;
  padding: 4px 10px;
  border-radius: 6px;
  border: 1px solid var(--border);
  background: white;
  color: var(--text);
  cursor: pointer;
  transition: all .15s;
}
.copy-btn:hover {
  border-color: var(--primary);
  color: var(--primary);
}

/* Layout compact : chaque mesure sur une seule ligne */
.compact-list {
  display: flex;
  flex-direction: column;
  gap: 2px;
  font-family: system-ui, -apple-system, sans-serif;
}
.measure-line {
  display: flex;
  align-items: baseline;
  gap: 12px;
  padding: 4px 6px;
  border-bottom: 1px solid #f3f4f6;
  line-height: 1.4;
}
.measure-line:last-child {
  border-bottom: none;
}
.measure-line:hover {
  background: #f0f9ff;
  border-radius: 4px;
}
.measure-num {
  font-size: 11px;
  color: #9ca3af;
  font-weight: 600;
  min-width: 32px;
  text-align: right;
  flex-shrink: 0;
  font-variant-numeric: tabular-nums;
}
.measure-notes {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  align-items: baseline;
}
.note-badge {
  display: inline-block;
  min-width: 24px;
  text-align: center;
  padding: 2px 6px;
  background: white;
  border: 1px solid #e5e7eb;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 600;
  color: #2563eb;
}
.note-badge.bass {
  color: #9333ea;
  border-color: #e9d5ff;
  background: #faf5ff;
}
</style>