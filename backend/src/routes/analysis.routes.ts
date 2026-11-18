
import type { Env } from '../types/env.types';

import { analysisController } from '../controllers/analysis.controller';
import { errorResponse } from '../utils/response.util';

export async function analysisRoutes(
  request: Request,
  env: Env,
): Promise<Response> {
  if (request.method !== 'POST') {
    return errorResponse(
      'Method not allowed. Please use POST.',
      'METHOD_NOT_ALLOWED',
      405,
    );
  }

  return analysisController(request, env);
}
