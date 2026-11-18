
import { normalizeError } from '../utils/error.util';
import { errorResponse } from '../utils/response.util';

export function errorMiddleware(error: unknown): Response {
  const appError = normalizeError(error);

  return errorResponse(
    appError.message,
    appError.code,
    appError.statusCode,
    appError.details,
  );
}
