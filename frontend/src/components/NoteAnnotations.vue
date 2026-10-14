<script setup lang="ts">
import { computed } from "vue";
import type { DetectedNote } from "../types";

const props = defineProps<{
  notes: DetectedNote[];
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

function labelFor(n: DetectedNote): string {
  const lang = props.language in { en: 1, fr: 1, ar: 1 } ? props.language : "en";
  if (n.type === "rest") {
    return lang === "fr" ? "Silence" : lang === "ar" ? "سكوت" : "Silence";
  }
  const base = NOTE_MAP[n.pitch || "C"]?.[lang] || n.pitch || "";
  return base + (n.accidental || "");
}

const items = computed(() => props.notes);
</script>

<template>
  <svg
    class="overlay"
    viewBox="0 0 1 1"
    preserveAspectRatio="none"
    xmlns="http://www.w3.org/2000/svg"
  >
    <g v-for="n in items" :key="n.id">
      <!-- Pastille de fond -->
      <rect
        :x="n.x - 0.028"
        :y="n.y + 0.005"
        width="0.056"
        height="0.022"
        rx="0.005"
        :fill="n.type === 'rest' ? '#eff6ff' : '#ffffff'"
        :stroke="n.type === 'rest' ? '#2563eb' : '#e5e7eb'"
        stroke-width="0.001"
      />
      <text
        :x="n.x"
        :y="n.y + 0.021"
        text-anchor="middle"
        font-size="0.017"
        font-weight="600"
        :fill="n.type === 'rest' ? '#2563eb' : '#111827'"
        style="font-family: -apple-system, system-ui, sans-serif;"
      >
        {{ labelFor(n) }}
      </text>
    </g>
  </svg>
</template>

<style scoped>
.overlay {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
}
</style>