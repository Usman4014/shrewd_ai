
export class AppError extends Error {
  public readonly statusCode: number;
  public readonly code: string;
  public readonly details?: string;

  constructor(
    message: string,
    code: string,
    statusCode = 500,
    details?: string,
  ) {
    super(message);

    this.name = 'AppError';
    this.statusCode = statusCode;
    this.code = code;
    this.details = details;

    Object.setPrototypeOf(this, AppError.prototype);
  }
}

export function normalizeError(error: unknown): AppError {
  if (error instanceof AppError) {
    return error;
  }

  if (error instanceof Error) {
    return new AppError(
      'An unexpected server error occurred.',
      'INTERNAL_SERVER_ERROR',
      500,
    );
  }

  return new AppError(
    'An unexpected server error occurred.',
    'INTERNAL_SERVER_ERROR',
    500,
  );
}
