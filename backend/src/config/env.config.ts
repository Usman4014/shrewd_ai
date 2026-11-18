
import type { Env } from '../types/env.types';

export interface AppConfig {
  geminiApiKey: string;
  geminiModel: string;
  allowedOrigin: string;
}

export function getEnvConfig(env: Env): AppConfig {
  const geminiApiKey = env.GEMINI_API_KEY?.trim();
  const geminiModel = env.GEMINI_MODEL?.trim();
  const allowedOrigin = env.ALLOWED_ORIGIN?.trim();

  if (!geminiApiKey) {
    throw new Error('GEMINI_API_KEY is not configured.');
  }

  if (!geminiModel) {
    throw new Error('GEMINI_MODEL is not configured.');
  }

  if (!allowedOrigin) {
    throw new Error('ALLOWED_ORIGIN is not configured.');
  }

  return {
    geminiApiKey,
    geminiModel,
    allowedOrigin,
  };
}
