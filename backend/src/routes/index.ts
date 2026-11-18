
import type { Env } from '../types/env.types';

import { analysisRoutes } from './analysis.routes';
import {
  errorResponse,
  successResponse,
} from '../utils/response.util';

const API_PREFIX = '/api/v1';

export async function handleRoutes(
  request: Request,
  env: Env,
): Promise<Response> {
  const url = new URL(request.url);
  const path = url.pathname;

  // Health Check
  if (path === `${API_PREFIX}/health`) {
    if (request.method !== 'GET') {
      return errorResponse(
        'Method not allowed. Please use GET.',
        'METHOD_NOT_ALLOWED',
        405,
      );
    }

    return successResponse(
      {
        status: 'healthy',
        service: 'SHREWD AI Backend',
        timestamp: new Date().toISOString(),
      },
      'Backend is running successfully.',
    );
  }

  // Product Analysis
  if (path === `${API_PREFIX}/analyze`) {
    return analysisRoutes(request, env);
  }

  return errorResponse(
    'The requested API endpoint was not found.',
    'ROUTE_NOT_FOUND',
    404,
  );
}
