<script setup lang="ts">
import { ref, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import { useI18n } from "vue-i18n";
import ScoreViewer from "../components/ScoreViewer.vue";
import { getScoreById } from "../services/scoreService";
import { exportElementToPdf } from "../services/pdfExport";
import type { Score } from "../types";

const route = useRoute();
const router = useRouter();
const { t, locale } = useI18n();

const score = ref<Score | null>(null);
const loading = ref(true);
const error = ref("");
const scoreWrapperRef = ref<HTMLElement | null>(null);

async function load() {
  loading.value = true;
  error.value = "";
  try {
    const id = Number(route.params.id);
    score.value = await getScoreById(id);
    if (!score.value) {
      error.value = "Score not found";
    }
  } catch (e: any) {
    error.value = e?.message || "Failed to load score";
  } finally {
    loading.value = false;
  }
}

async function downloadPdf() {
  if (!scoreWrapperRef.value || !score.value) return;
  await exportElementToPdf(scoreWrapperRef.value, score.value.title);
}

function back() {
  router.push("/library");
}

onMounted(load);
</script>

<template>
  <section class="detail">
    <div class="header">
      <button class="back-btn" @click="back">← Back to library</button>
      <div v-if="score" class="actions">
        <button class="primary" @click="downloadPdf">
          ⬇ Download as PDF
        </button>
      </div>
    </div>

    <p v-if="loading" class="status">{{ t("common.loading") }}</p>
    <p v-else-if="error" class="error">{{ error }}</p>

    <template v-else-if="score">
      <div ref="scoreWrapperRef" class="score-wrapper">
        <ScoreViewer
          :musicxml="score.rawMusicXml || ''"
          :language="locale"
          :title="score.title"
          :notes="score.notes"
        />
      </div>
    </template>
  </section>
</template>

<style scoped>
.detail {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
}
.back-btn {
  background: transparent;
  border: none;
  color: var(--text-muted);
  font-weight: 500;
  padding: 6px 10px;
  cursor: pointer;
  border-radius: var(--radius-sm);
}
.back-btn:hover {
  background: #f3f4f6;
  color: var(--text);
}
.actions {
  display: flex;
  gap: 8px;
}
.status {
  color: var(--text-muted);
}
.error {
  color: var(--danger);
}
.score-wrapper {
  background: white;
  border-radius: var(--radius-lg);
  border: 1px solid var(--border);
  box-shadow: var(--shadow);
}
</style>