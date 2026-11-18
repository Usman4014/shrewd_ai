
import type { Env } from '../types/env.types';

import type {
  AnalysisReportResponse,
  AnalysisReportPayload,
  ProductAnalysisInput,
  ProductImageInput,
} from '../types/analysis.types';

import { getEnvConfig } from '../config/env.config';
import { AppError } from '../utils/error.util';

interface GeminiResponse {
  candidates?: Array<{
    content?: {
      parts?: Array<{
        text?: string;
      }>;
    };
    finishReason?: string;
  }>;
  error?: {
    message?: string;
    code?: number;
    status?: string;
  };
}

function arrayBufferToBase64(buffer: ArrayBuffer): string {
  const bytes = new Uint8Array(buffer);
  const chunkSize = 0x8000;
  let binary = '';

  for (let i = 0; i < bytes.length; i += chunkSize) {
    const chunk = bytes.subarray(i, i + chunkSize);
    binary += String.fromCharCode(...chunk);
  }

  return btoa(binary);
}

function buildPrompt(product: ProductAnalysisInput): string {
  return `
You are SHREWD AI, an expert second-hand product inspection assistant.

Your purpose is to help buyers make informed decisions before purchasing
pre-owned or second-hand products.

Carefully analyze the provided product information and images.

PRODUCT DETAILS:
Category: ${product.category}
Subcategory: ${product.subcategory}
Product Name: ${product.productName}
Model: ${product.model ?? 'Not provided'}
Asking Price: ${product.askingPrice} ${product.currency}
Seller Condition: ${product.condition}
Seller Description: ${product.sellerDescription ?? 'Not provided'}

ANALYSIS REQUIREMENTS:

1. Describe visible physical condition using image evidence.
2. Highlight positive aspects supported by visible evidence.
3. Identify potential red flags and visible damage.
4. Identify important missing information.
5. Suggest relevant questions to ask the seller.
6. Provide a practical physical inspection checklist.
7. Discuss price considerations using available reliable information.
8. Provide an overall deal assessment.
9. Give a balanced and actionable recommendation.

STRICT EVIDENCE RULES:

- Never invent product specifications, model numbers, release years,
  defects, repairs, or seller claims.
- Never guess the exact product model from its appearance.
- Identify a brand only if its logo or name is clearly readable.
- Do not infer product age, market segment, performance, quality,
  or original price from camera count, port type, design, or appearance.
- Do not assume that a product is outdated, entry-level, or premium
  without verified information.
- Describe physical features only as visible observations.
- Do not interpret the absence of something in an image as proof
  that the product does not have that feature.
- Clearly distinguish visible evidence from unverified information.
- If an observation cannot be confirmed, state that it cannot
  be verified from the provided images.
- Never claim to detect hidden internal defects.
- If a product is not shown powered on, state that functionality
  remains unverified.

PRICE ACCURACY RULES:

- Consider the asking price provided by the user.
- Never invent current market prices or valuations.
- Never label a product overpriced, underpriced, or fairly priced
  without sufficient product identification and reliable comparison data.
- If exact model, specifications, or reliable market comparisons
  are unavailable, explicitly state that price fairness cannot
  be determined.
- Do not estimate resale value or market demand without evidence.
- Mention the asking price accurately using the supplied currency.

RECOMMENDATION RULES:

- If important product details are missing, explain what must
  be verified before purchasing.
- If functionality is unverified, recommend testing the product
  before making a purchase decision.
- Avoid unconditional purchase recommendations when critical
  information is unavailable.
- Give practical next steps instead of unsupported conclusions.

GENERAL RULES:

- Never guarantee authenticity, safety, or product quality.
- Never present assumptions as facts.
- Keep observations concise, useful, and buyer-friendly.
- Avoid repeating the same information across report sections.
- Return valid JSON only.
- Do not include Markdown fences or additional text.

REQUIRED JSON STRUCTURE:

{
  "overallDealAssessment": "string",
  "visibleConditionObservations": ["string"],
  "positiveAspects": ["string"],
  "potentialRedFlags": ["string"],
  "missingInformation": ["string"],
  "questionsToAskSeller": ["string"],
  "inspectionChecklist": ["string"],
  "priceConsiderations": ["string"],
  "aiRecommendation": "string"
}
`;
}

function validateReport(
  value: unknown,
): AnalysisReportPayload {
  if (
    typeof value !== 'object' ||
    value === null ||
    Array.isArray(value)
  ) {
    throw new AppError(
      'AI returned an invalid report.',
      'INVALID_AI_RESPONSE',
      502,
    );
  }

  const report = value as Record<string, unknown>;

  const requiredStrings = [
    'overallDealAssessment',
    'aiRecommendation',
  ];

  const requiredArrays = [
    'visibleConditionObservations',
    'positiveAspects',
    'potentialRedFlags',
    'missingInformation',
    'questionsToAskSeller',
    'inspectionChecklist',
    'priceConsiderations',
  ];

  for (const field of requiredStrings) {
    if (
      typeof report[field] !== 'string' ||
      !report[field].trim()
    ) {
      throw new AppError(
        'AI returned an incomplete report.',
        'INVALID_AI_RESPONSE',
        502,
      );
    }
  }

  for (const field of requiredArrays) {
    if (
      !Array.isArray(report[field]) ||
      !report[field].every(
        (item) =>
          typeof item === 'string' &&
          item.trim().length > 0,
      )
    ) {
      throw new AppError(
        'AI returned an invalid report structure.',
        'INVALID_AI_RESPONSE',
        502,
      );
    }
  }

  return {
    overallDealAssessment:
      report.overallDealAssessment as string,
    visibleConditionObservations:
      report.visibleConditionObservations as string[],
    positiveAspects:
      report.positiveAspects as string[],
    potentialRedFlags:
      report.potentialRedFlags as string[],
    missingInformation:
      report.missingInformation as string[],
    questionsToAskSeller:
      report.questionsToAskSeller as string[],
    inspectionChecklist:
      report.inspectionChecklist as string[],
    priceConsiderations:
      report.priceConsiderations as string[],
    aiRecommendation:
      report.aiRecommendation as string,
  };
}

export async function analyzeProductWithGemini(
  env: Env,
  product: ProductAnalysisInput,
  images: ProductImageInput[],
): Promise<AnalysisReportResponse> {
  const config = getEnvConfig(env);

  const model = config.geminiModel.replace(/^models\//, '');

  const endpoint =
    `https://generativelanguage.googleapis.com/v1beta/models/` +
    `${encodeURIComponent(model)}:generateContent`;

  const parts = [
    {
      text: buildPrompt(product),
    },
    ...images.map((image) => ({
      inlineData: {
        mimeType: image.mimeType,
        data: arrayBufferToBase64(image.data),
      },
    })),
  ];

  const requestBody = JSON.stringify({
    contents: [
      {
        role: 'user',
        parts,
      },
    ],
    generationConfig: {
      responseMimeType: 'application/json',
    },
  });

  // Retry configuration.
  const maxAttempts = 3;
  const requestTimeoutMs = 45_000;

  const retryableStatuses = new Set([
    408,
    500,
    502,
    503,
    504,
    524,
  ]);

  let response: Response | undefined;
  let connectionError: unknown;

  for (let attempt = 1; attempt <= maxAttempts; attempt++) {
    const controller = new AbortController();

    const timeoutId = setTimeout(
      () => controller.abort(),
      requestTimeoutMs,
    );

    try {
      response = await fetch(endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': config.geminiApiKey,
        },
        body: requestBody,
        signal: controller.signal,
      });
    } catch (error: unknown) {
      if (controller.signal.aborted) {
        throw new AppError(
          'The analysis is taking longer than expected. Please try again later.',
          'AI_TIMEOUT',
          524,
        );
      }

      connectionError = error;
      response = undefined;

      if (attempt === maxAttempts) {
        break;
      }

      const exponentialDelayMs =
        2000 * Math.pow(2, attempt - 1);

      const jitterMs = Math.floor(
        Math.random() * 1000,
      );

      const delayMs = exponentialDelayMs + jitterMs;

      console.warn(
        `Gemini connection failed. Retrying (${attempt}/${maxAttempts - 1}) in ${delayMs}ms.`,
      );

      await new Promise<void>((resolve) => {
        setTimeout(resolve, delayMs);
      });

      continue;
    } finally {
      clearTimeout(timeoutId);
    }

    if (
      response.ok ||
      !retryableStatuses.has(response.status) ||
      attempt === maxAttempts
    ) {
      break;
    }

    const retryAfter = Number(
      response.headers.get('Retry-After'),
    );

    const retryAfterMs =
      Number.isFinite(retryAfter) && retryAfter > 0
        ? retryAfter * 1000
        : 0;

    await response.body?.cancel();

    const exponentialDelayMs =
      2000 * Math.pow(2, attempt - 1);

    const jitterMs = Math.floor(
      Math.random() * 1000,
    );

    const delayMs = Math.max(
      exponentialDelayMs + jitterMs,
      retryAfterMs,
    );

    console.warn(
      `Gemini returned ${response.status}. Retrying (${attempt}/${maxAttempts - 1}) in ${delayMs}ms.`,
    );

    await new Promise<void>((resolve) => {
      setTimeout(resolve, delayMs);
    });
  }

  if (!response) {
    console.error(
      'Gemini Connection Error:',
      connectionError instanceof Error
        ? connectionError.message
        : String(connectionError),
    );

    throw new AppError(
      'Unable to connect to the AI service. Please try again.',
      'AI_CONNECTION_ERROR',
      502,
    );
  }

  if (!response.ok) {
    const errorBody = await response.text();

    console.error('Gemini API Error:', {
      status: response.status,
      statusText: response.statusText,
      response: errorBody,
    });

    let geminiError: {
      error?: {
        code?: number;
        message?: string;
        status?: string;
      };
    } = {};

    try {
      geminiError = JSON.parse(errorBody);
    } catch {
      // Keep the original HTTP status if the response is not valid JSON.
    }

    const errorCode = geminiError.error?.code ?? response.status;
    const errorStatus = geminiError.error?.status ?? '';

    if (
      errorCode === 429 ||
      errorStatus === 'RESOURCE_EXHAUSTED'
    ) {
      throw new AppError(
        "You've reached today's free AI analysis limit. Please try again tomorrow.",
        'AI_QUOTA_EXCEEDED',
        429,
      );
    }

    if (
      errorCode === 503 ||
      errorStatus === 'UNAVAILABLE'
    ) {
      throw new AppError(
        'The AI service is temporarily unavailable. Please try again later.',
        'AI_SERVICE_UNAVAILABLE',
        503,
      );
    }

    if (errorCode === 524) {
      throw new AppError(
        'The analysis is taking longer than expected. Please try again later.',
        'AI_TIMEOUT',
        524,
      );
    }

    throw new AppError(
      'The AI service could not complete the analysis.',
      'AI_SERVICE_ERROR',
      502,
    );
  }

  let geminiResponse: GeminiResponse;

  try {
    geminiResponse = await response.json() as GeminiResponse;
  } catch {
    throw new AppError(
      'The AI service returned an invalid response.',
      'INVALID_AI_RESPONSE',
      502,
    );
  }

  const candidate = geminiResponse.candidates?.[0];

  if (candidate?.finishReason === 'MAX_TOKENS') {
    throw new AppError(
      'The AI analysis was incomplete. Please try again.',
      'INCOMPLETE_AI_RESPONSE',
      502,
    );
  }

  const generatedText =
    candidate?.content?.parts
      ?.map((part) => part.text ?? '')
      .join('')
      .trim();

  if (!generatedText) {
    throw new AppError(
      'The AI service returned an empty analysis.',
      'EMPTY_AI_RESPONSE',
      502,
    );
  }

  let parsedReport: unknown;

  try {
    parsedReport = JSON.parse(generatedText);
  } catch {
    throw new AppError(
      'The AI service returned invalid JSON.',
      'INVALID_AI_JSON',
      502,
    );
  }

  return {
    ...validateReport(parsedReport),
    analyzedAt: new Date().toISOString(),
  };
}
