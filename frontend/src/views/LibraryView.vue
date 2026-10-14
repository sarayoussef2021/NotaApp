<script setup lang="ts">
import { ref, watch, onMounted } from "vue";
import { useRouter } from "vue-router";
import { useI18n } from "vue-i18n";
import { listScores } from "../services/scoreService";
import type { Score } from "../types";
import ScoreCard from "../components/ScoreCard.vue";
import Pagination from "../components/Pagination.vue";

const { t } = useI18n();
const router = useRouter();

const query = ref("");
const page = ref(1);
const pageSize = 9;
const items = ref<Score[]>([]);
const total = ref(0);
const loading = ref(false);

let debounce: number | undefined;

async function load() {
  loading.value = true;
  try {
    const res = await listScores({
      query: query.value,
      page: page.value,
      pageSize,
    });
    items.value = res.items;
    total.value = res.total;
  } catch (e) {
    console.error("Failed to load library:", e);
  } finally {
    loading.value = false;
  }
}

watch(query, () => {
  clearTimeout(debounce);
  debounce = window.setTimeout(() => {
    page.value = 1;
    load();
  }, 250);
});

watch(page, load);
onMounted(load);

function onPageChange(p: number) {
  page.value = p;
  window.scrollTo({ top: 0, behavior: "smooth" });
}

function openScore(id: number | string) {
  router.push(`/score/${id}`);
}
</script>

<template>
  <section class="hero">
    <h1>{{ t("library.title") }}</h1>
    <p>{{ t("library.subtitle") }}</p>
  </section>

  <div class="toolbar">
    <input
      v-model="query"
      :placeholder="t('library.searchPlaceholder')"
      class="search"
    />
  </div>

  <p v-if="loading" class="status">{{ t("common.loading") }}</p>

  <div v-else-if="items.length === 0" class="empty">
    <p>{{ t("library.empty") }}</p>
  </div>

  <div v-else class="grid">
    <div
      v-for="s in items"
      :key="s.id"
      class="grid-item"
      @click="openScore(s.id)"
    >
      <ScoreCard :score="s" />
    </div>
  </div>

  <Pagination
    v-if="total > pageSize"
    :page="page"
    :page-size="pageSize"
    :total="total"
    @change="onPageChange"
  />
</template>

<style scoped>
.hero { padding: 24px 0 16px; }
.hero h1 { font-size: 28px; margin: 0 0 6px; }
.toolbar { margin-bottom: 20px; }
.search { max-width: 420px; }
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 16px;
}
.grid-item {
  cursor: pointer;
  transition: transform var(--t-fast);
}
.grid-item:hover {
  transform: translateY(-2px);
}
.empty {
  text-align: center;
  padding: 60px 20px;
  color: var(--text-muted);
  background: var(--surface);
  border: 1px dashed var(--border);
  border-radius: 12px;
}
.status { color: var(--text-muted); font-size: 14px; }
</style>