<script setup lang="ts">
import { useI18n } from "vue-i18n";
import { setLocale } from "../i18n";

const { locale } = useI18n();

const langs = [
  { code: "en", label: "EN", flag: "🇬🇧" },
  { code: "fr", label: "FR", flag: "🇫🇷" },
  { code: "ar", label: "AR", flag: "🇲🇦" },
] as const;

function change(code: "en" | "fr" | "ar") {
  setLocale(code);
}
</script>

<template>
  <div class="lang">
    <button
      v-for="l in langs"
      :key="l.code"
      :class="{ active: locale === l.code }"
      @click="change(l.code)"
      :title="l.label"
    >
      <span>{{ l.flag }}</span>
      <span class="code">{{ l.label }}</span>
    </button>
  </div>
</template>

<style scoped>
.lang {
  display: flex;
  gap: 2px;
  background: #f3f4f6;
  padding: 3px;
  border-radius: 8px;
}
.lang button {
  display: flex;
  align-items: center;
  gap: 5px;
  padding: 5px 10px;
  border: none;
  background: transparent;
  border-radius: 6px;
  font-size: 13px;
  font-weight: 500;
  color: var(--text-muted);
  cursor: pointer;
}
.lang button.active {
  background: white;
  color: var(--text);
  box-shadow: 0 1px 2px rgba(0,0,0,.06);
}
.code { font-size: 12px; }
</style>