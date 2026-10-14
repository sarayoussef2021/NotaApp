<script setup lang="ts">
import { ref } from "vue";
import { useI18n } from "vue-i18n";
import UploadZone from "../components/UploadZone.vue";
import ScoreViewer from "../components/ScoreViewer.vue";
import { uploadScore } from "../services/scoreService";
import type { Score } from "../types";
import { exportElementToPdf } from "../services/pdfExport";

const { t, locale } = useI18n();

const loading = ref(false);
const error = ref("");
const score = ref<Score | null>(null);
const title = ref("");
const scoreWrapperRef = ref<HTMLElement | null>(null);

async function handleFile(file: File) {
  error.value = "";
  loading.value = true;
  score.value = null;
  try {
    score.value = await uploadScore(file, title.value, locale.value);
  } catch (e: any) {
    error.value =
      e?.response?.data?.error ||
      e?.message ||
      t("home.error.generic");
  } finally {
    loading.value = false;
  }
}

function reset() {
  score.value = null;
  error.value = "";
  title.value = "";
}

async function downloadPdf() {
  if (!scoreWrapperRef.value || !score.value) return;
  await exportElementToPdf(scoreWrapperRef.value, score.value.title);
}
</script>

<template>
  <section class="hero">
    <h1>{{ t("home.title") }}</h1>
    <p>{{ t("home.subtitle") }}</p>
  </section>

  <section v-if="!score" class="card upload-card">
    <label class="field-label">Title (optional)</label>
    <input
      v-model="title"
      placeholder="Ex: La Vie En Rose"
      class="title-input"
    />
    <UploadZone @file="handleFile" @error="(m) => (error = m)" />
    <p v-if="loading" class="status">
      <span class="spinner"></span>
      {{ t("home.analyzing") }}
    </p>
    <p v-if="error" class="error">{{ error }}</p>
  </section>

  <section v-else class="result">
    <div class="actions">
      <button class="primary" @click="downloadPdf">
        ⬇ {{ t("home.download") }}
      </button>
      <button @click="reset">{{ t("home.newUpload") }}</button>
    </div>
    <div ref="scoreWrapperRef">
      <ScoreViewer
        :musicxml="score.rawMusicXml || ''"
        :language="locale"
        :title="score.title"
        :notes="score.notes"
      />
    </div>
  </section>
</template>

<style scoped>
.hero { text-align: center; padding: 32px 0 24px; }
.hero h1 { font-size: 34px; }
.hero p { max-width: 620px; margin: 0 auto; }
.upload-card { display: flex; flex-direction: column; gap: 12px; }
.field-label { font-size: 13px; color: var(--text-muted); }
.title-input { max-width: 420px; }
.status {
  color: var(--primary);
  font-size: 14px;
  display: flex;
  align-items: center;
  gap: 10px;
}
.spinner {
  display: inline-block;
  width: 14px;
  height: 14px;
  border: 2px solid #bfdbfe;
  border-top-color: var(--primary);
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}
@keyframes spin { to { transform: rotate(360deg); } }
.error { color: var(--danger); font-size: 14px; }
.result { display: flex; flex-direction: column; gap: 16px; }
.actions { display: flex; gap: 10px; }
</style>