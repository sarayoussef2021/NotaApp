<script setup lang="ts">
import { ref, computed } from "vue";
import { useI18n } from "vue-i18n";
import { ALLOWED_TYPES, MAX_FILE_SIZE } from "../services/mockScoreService";

const emit = defineEmits<{
  (e: "file", file: File): void;
  (e: "error", msg: string): void;
}>();

const { t } = useI18n();
const dragging = ref(false);
const inputRef = ref<HTMLInputElement | null>(null);

const accept = computed(() => ALLOWED_TYPES.join(","));

function onPick() {
  inputRef.value?.click();
}

function onInput(e: Event) {
  const file = (e.target as HTMLInputElement).files?.[0];
  if (file) validateAndEmit(file);
  if (inputRef.value) inputRef.value.value = "";
}

function onDrop(e: DragEvent) {
  dragging.value = false;
  const file = e.dataTransfer?.files?.[0];
  if (file) validateAndEmit(file);
}

function validateAndEmit(file: File) {
  if (!ALLOWED_TYPES.includes(file.type)) {
    emit("error", t("home.error.type"));
    return;
  }
  if (file.size > MAX_FILE_SIZE) {
    emit("error", t("home.error.size"));
    return;
  }
  emit("file", file);
}
</script>

<template>
  <div
    class="dropzone"
    :class="{ dragging }"
    @click="onPick"
    @dragover.prevent="dragging = true"
    @dragleave.prevent="dragging = false"
    @drop.prevent="onDrop"
  >
    <input
      ref="inputRef"
      type="file"
      :accept="accept"
      hidden
      @change="onInput"
    />
    <div class="icon">🎼</div>
    <h3>{{ t("home.uploadTitle") }}</h3>
    <p class="hint">{{ t("home.uploadHint") }}</p>
    <button class="primary" @click.stop="onPick">
      {{ t("home.uploadButton") }}
    </button>
  </div>
</template>

<style scoped>
.dropzone {
  border: 2px dashed var(--border);
  border-radius: var(--radius);
  background: var(--surface);
  padding: 48px 24px;
  text-align: center;
  cursor: pointer;
  transition: all .18s ease;
}
.dropzone:hover, .dropzone.dragging {
  border-color: var(--primary);
  background: #f8faff;
}
.icon { font-size: 42px; margin-bottom: 8px; }
.hint { color: var(--text-muted); font-size: 13px; margin-bottom: 16px; }
</style>