
function getCorsHeaders(
  request: Request,
  allowedOrigin: string,
): Headers {
  const requestOrigin = request.headers.get('Origin');

  const origin =
    allowedOrigin === '*'
      ? '*'
      : requestOrigin === allowedOrigin
        ? allowedOrigin
        : 'null';

  return new Headers({
    'Access-Control-Allow-Origin': origin,
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Max-Age': '86400',
    'Vary': 'Origin',
  });
}

export function corsMiddleware(
  request: Request,
  response: Response,
  allowedOrigin: string,
): Response {
  const headers = new Headers(response.headers);
  const corsHeaders = getCorsHeaders(request, allowedOrigin);

  corsHeaders.forEach((value, key) => {
    headers.set(key, value);
  });

  return new Response(response.body, {
    status: response.status,
    statusText: response.statusText,
    headers,
  });
}

export function handleCorsPreflight(
  request: Request,
  allowedOrigin: string,
): Response | null {
  if (request.method !== 'OPTIONS') {
    return null;
  }

  return new Response(null, {
    status: 204,
    headers: getCorsHeaders(request, allowedOrigin),
  });
}
