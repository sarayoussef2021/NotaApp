<script setup lang="ts">
import { RouterLink, useRoute } from "vue-router";
import { useI18n } from "vue-i18n";
import LanguageSwitcher from "./LanguageSwitcher.vue";

const { t } = useI18n();
const route = useRoute();
</script>

<template>
  <header class="nav">
    <div class="nav-inner container">
      <RouterLink to="/" class="brand">
        <span class="brand-mark">♪</span>
        <span class="brand-name">AppNota</span>
      </RouterLink>

      <nav class="links">
        <RouterLink to="/" :class="{ active: route.name === 'home' }">
          <span class="icon">🎼</span>
          {{ t("nav.home") }}
        </RouterLink>
        <RouterLink to="/library" :class="{ active: route.name === 'library' }">
          <span class="icon">📚</span>
          {{ t("nav.library") }}
        </RouterLink>
        <RouterLink to="/contact" :class="{ active: route.name === 'contact' }">
          <span class="icon">✉️</span>
          {{ t("nav.contact") }}
        </RouterLink>
      </nav>

      <LanguageSwitcher />
    </div>
  </header>
</template>

<style scoped>
.nav {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: saturate(180%) blur(12px);
  -webkit-backdrop-filter: saturate(180%) blur(12px);
  border-bottom: 1px solid var(--border);
  position: sticky;
  top: 0;
  z-index: 50;
}
.nav-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
  padding-top: 12px;
  padding-bottom: 12px;
}
.brand {
  display: flex;
  align-items: center;
  gap: 10px;
  text-decoration: none;
  color: var(--text);
  font-weight: 700;
  font-size: 18px;
  letter-spacing: -0.02em;
}
.brand-mark {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  background: linear-gradient(135deg, var(--primary), var(--accent));
  color: white;
  border-radius: 9px;
  font-size: 18px;
  box-shadow: var(--shadow-xs);
}
.links {
  display: flex;
  gap: 4px;
  flex: 1;
  justify-content: center;
}
.links a {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  text-decoration: none;
  color: var(--text-muted);
  padding: 8px 14px;
  border-radius: var(--radius-sm);
  font-size: 14px;
  font-weight: 500;
  transition: all var(--t-fast);
}
.links a .icon {
  font-size: 14px;
  opacity: 0.8;
}
.links a:hover {
  color: var(--text);
  background: #f3f4f6;
}
.links a.active {
  color: var(--primary);
  background: var(--primary-soft);
}

@media (max-width: 640px) {
  .nav-inner { flex-wrap: wrap; }
  .links { order: 3; width: 100%; justify-content: flex-start; }
  .links a { padding: 6px 10px; font-size: 13px; }
  .links a .icon { display: none; }
}
</style>