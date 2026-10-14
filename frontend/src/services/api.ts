import axios from "axios";

export const API_BASE =
  import.meta.env.VITE_API_BASE || "http://localhost:8080";

const api = axios.create({
  baseURL: API_BASE,
  timeout: 900000,
});

api.interceptors.request.use((config) => {
  const token = localStorage.getItem("appnota.token");
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

export default api;