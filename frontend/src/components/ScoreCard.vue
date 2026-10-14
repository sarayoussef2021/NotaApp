<script setup lang="ts">
import type { Score } from "../types";

defineProps<{ score: Score }>();
</script>

<template>
  <article class="card-item">
    <div class="thumb">
      <img :src="score.imageUrl" :alt="score.title" />
    </div>
    <div class="meta">
      <h3>{{ score.title }}</h3>
      <p class="sub">
        <span v-if="score.composer">{{ score.composer }}</span>
        <span v-if="score.arrangedBy"> · {{ score.arrangedBy }}</span>
      </p>
      <div class="footer">
        <span class="badge">{{ score.engine }}</span>
        <span class="notes-count">{{ score.notes?.length || 0 }} notes</span>
      </div>
    </div>
  </article>
</template>

<style scoped>
.card-item {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  overflow: hidden;
  box-shadow: var(--shadow-xs);
  transition: transform var(--t), box-shadow var(--t);
}
.card-item:hover {
  transform: translateY(-3px);
  box-shadow: var(--shadow-lg);
}
.thumb {
  aspect-ratio: 4 / 3;
  background: #f8fafc;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  border-bottom: 1px solid var(--border);
}
.thumb img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: top;
}
.meta { padding: 14px 16px; }
h3 {
  font-size: 15px;
  margin: 0 0 4px;
  font-weight: 600;
}
.sub {
  font-size: 12px;
  margin: 0 0 10px;
  color: var(--text-muted);
}
.footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.badge {
  display: inline-block;
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 999px;
  background: var(--primary-soft);
  color: var(--primary);
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.03em;
}
.notes-count {
  font-size: 11px;
  color: var(--text-muted);
}
</style>