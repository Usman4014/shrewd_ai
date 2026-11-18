
import type { Env } from '../types/env.types';
import type { ProductImageInput } from '../types/analysis.types';

import { validateAnalysisForm } from '../validators/analysis.validator';
import { analyzeProductWithGemini } from '../services/gemini.service';
import { successResponse } from '../utils/response.util';
import { AppError } from '../utils/error.util';
import { errorMiddleware } from '../middleware/error.middleware';

export async function analysisController(
  request: Request,
  env: Env,
): Promise<Response> {
  try {
    const contentType = request.headers.get('Content-Type') ?? '';

    if (!contentType.toLowerCase().includes('multipart/form-data')) {
      throw new AppError(
        'Request must use multipart/form-data.',
        'INVALID_CONTENT_TYPE',
        415,
      );
    }

    let formData: FormData;

    try {
      formData = await request.formData();
    } catch {
      throw new AppError(
        'Unable to read the submitted form data.',
        'INVALID_FORM_DATA',
        400,
      );
    }

    const { product, images } = validateAnalysisForm(formData);

    const productImages: ProductImageInput[] = await Promise.all(
      images.map(async (image) => ({
        data: await image.arrayBuffer(),
        mimeType: image.type,
      })),
    );

    const report = await analyzeProductWithGemini(
      env,
      product,
      productImages,
    );

    return successResponse(
      report,
      'Product analysis completed successfully.',
    );
  } catch (error: unknown) {
    return errorMiddleware(error);
  }
}
