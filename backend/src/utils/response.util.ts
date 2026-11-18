
import type {
  ApiErrorResponse,
  ApiSuccessResponse,
} from '../types/api.types';

export function successResponse<T>(
  data: T,
  message: string,
  status = 200,
): Response {
  const response: ApiSuccessResponse<T> = {
    success: true,
    message,
    data,
  };

  return Response.json(response, {
    status,
    headers: {
      'Cache-Control': 'no-store',
    },
  });
}

export function errorResponse(
  message: string,
  code: string,
  status = 500,
  details?: string,
): Response {
  const response: ApiErrorResponse = {
    success: false,
    message,
    error: {
      code,
      ...(details ? { details } : {}),
    },
  };

  return Response.json(response, {
    status,
    headers: {
      'Cache-Control': 'no-store',
    },
  });
}
