<script setup lang="ts">
import { computed } from "vue";
import { useI18n } from "vue-i18n";

const props = defineProps<{
  page: number;
  pageSize: number;
  total: number;
}>();
const emit = defineEmits<{ (e: "change", page: number): void }>();

const { t } = useI18n();

const totalPages = computed(() =>
  Math.max(1, Math.ceil(props.total / props.pageSize)),
);

function go(p: number) {
  if (p < 1 || p > totalPages.value || p === props.page) return;
  emit("change", p);
}
</script>

<template>
  <div class="pagination">
    <button :disabled="page <= 1" @click="go(page - 1)">
      ← {{ t("library.previous") }}
    </button>
    <span class="info">
      {{ t("library.page", { current: page, total: totalPages }) }}
    </span>
    <button :disabled="page >= totalPages" @click="go(page + 1)">
      {{ t("library.next") }} →
    </button>
  </div>
</template>

<style scoped>
.pagination {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  margin-top: 28px;
}
.info { font-size: 13px; color: var(--text-muted); }
</style>