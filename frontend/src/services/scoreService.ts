import api from "./api";
import type { Score } from "../types";

function fileToBase64(file: File): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => {
      const result = reader.result as string;
      // Remove the "data:image/png;base64," prefix
      resolve(result.split(",")[1]);
    };
    reader.onerror = reject;
    reader.readAsDataURL(file);
  });
}

export async function uploadScore(
  file: File,
  title: string,
  locale: string,
): Promise<Score> {
  const fileBase64 = await fileToBase64(file);

  const { data } = await api.post(
    "/score/upload",
    {
      fileName: file.name,
      fileType: file.type,
      fileBase64,
      title,
      locale,
    },
    {
      timeout: 900000, // 15 minutes — oemer is slow
    },
  );

  return data;
}

export async function listScores(params: {
  query?: string;
  page?: number;
  pageSize?: number;
}): Promise<{ items: Score[]; total: number }> {
  const { data } = await api.post("/score/list", {
    query: params.query ?? "",
    page: params.page ?? 1,
    pageSize: params.pageSize ?? 12,
  });
  return data;
}

// ⭐ NEW — used by ScoreDetailView
export async function getScoreById(id: number): Promise<Score | null> {
  const { data } = await api.post("/score/getById", { id });
  return data;
}

export async function sendContact(payload: {
  name: string;
  email: string;
  message: string;
  locale: string;
}): Promise<boolean> {
  const { data } = await api.post("/contact/send", payload);
  return data;
}