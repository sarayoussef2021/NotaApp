import { createI18n } from "vue-i18n";
import en from "./locales/en.json";
import fr from "./locales/fr.json";
import ar from "./locales/ar.json";

const saved = localStorage.getItem("notara.locale") || "en";

const i18n = createI18n({
  legacy: false,
  locale: saved,
  fallbackLocale: "en",
  messages: { en, fr, ar },
});

// Gestion du RTL pour l'arabe
function applyDirection(locale: string) {
  document.documentElement.lang = locale;
  document.documentElement.dir = locale === "ar" ? "rtl" : "ltr";
}
applyDirection(saved);
i18n.global.locale.value = saved;
export function setLocale(locale: "en" | "fr" | "ar") {
  i18n.global.locale.value = locale;
  localStorage.setItem("notara.locale", locale);
  applyDirection(locale);
}

export default i18n;