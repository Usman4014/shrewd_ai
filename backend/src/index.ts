
import type { Env } from './types/env.types';

import { handleRoutes } from './routes';
import {
  corsMiddleware,
  handleCorsPreflight,
} from './middleware/cors.middleware';
import { errorMiddleware } from './middleware/error.middleware';

const worker = {
  async fetch(
    request: Request,
    env: Env,
  ): Promise<Response> {
    const allowedOrigin = env.ALLOWED_ORIGIN?.trim() || '*';

    try {
      // Handle CORS preflight requests.
      const preflightResponse = handleCorsPreflight(
        request,
        allowedOrigin,
      );

      if (preflightResponse) {
        return preflightResponse;
      }

      // Handle API routes.
      const response = await handleRoutes(request, env);

      // Add CORS headers to the response.
      return corsMiddleware(
        request,
        response,
        allowedOrigin,
      );
    } catch (error: unknown) {
      // Handle unexpected errors.
      const response = errorMiddleware(error);

      return corsMiddleware(
        request,
        response,
        allowedOrigin,
      );
    }
  },
};

export default worker;
