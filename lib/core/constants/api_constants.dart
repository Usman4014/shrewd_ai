
class ApiConstants {
  ApiConstants._();

  // BACKEND CONFIGURATION

  static const String backendProvider = 'Cloudflare Workers';

  static const String baseUrl =
    'https://shrewd-ai-backend.shinestarusmanshabbir4014.workers.dev';

  // REQUEST CONFIGURATION

  static const int connectTimeout = 30000;

  static const int receiveTimeout = 180000;

  static const int sendTimeout = 60000;

  // REQUEST HEADERS

  static const String contentType = 'application/json';

  static const String accept = 'application/json';

  // API ENDPOINTS

  static const String analyzeEndpoint = '/api/v1/analyze';

  // AI PROVIDER

  static const String aiProvider = 'Gemini API';
}
