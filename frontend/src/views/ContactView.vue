<script setup lang="ts">
import { ref } from "vue";
import { useI18n } from "vue-i18n";

const { t } = useI18n();

const name = ref("");
const email = ref("");
const message = ref("");
const sent = ref(false);
const error = ref("");

function submit() {
  error.value = "";
  if (!name.value || !email.value || !message.value) {
    error.value = "Please fill in all fields.";
    return;
  }
  // TODO : brancher sur un endpoint Serverpod (ContactEndpoint.send)
  console.log({ name: name.value, email: email.value, message: message.value });
  sent.value = true;
  name.value = email.value = message.value = "";
}
</script>

<template>
  <section class="hero">
    <h1>{{ t("contact.title") }}</h1>
    <p>{{ t("contact.subtitle") }}</p>
  </section>

  <form class="card form" @submit.prevent="submit">
    <label>
      <span>{{ t("contact.name") }}</span>
      <input v-model="name" type="text" required />
    </label>
    <label>
      <span>{{ t("contact.email") }}</span>
      <input v-model="email" type="email" required />
    </label>
    <label>
      <span>{{ t("contact.message") }}</span>
      <textarea v-model="message" rows="6" required></textarea>
    </label>
    <p v-if="error" class="error">{{ error }}</p>
    <p v-if="sent" class="success">{{ t("contact.sent") }}</p>
    <button class="primary" type="submit">{{ t("contact.send") }}</button>
  </form>
</template>

<style scoped>
.hero { padding: 24px 0 16px; }
.form { display: flex; flex-direction: column; gap: 14px; max-width: 560px; }
label { display: flex; flex-direction: column; gap: 6px; font-size: 13px; color: var(--text-muted); }
.error { color: var(--danger); }
.success { color: var(--success); }
button.primary { align-self: flex-start; }
</style>