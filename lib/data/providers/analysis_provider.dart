
import 'package:dio/dio.dart';

class AnalysisProvider {
  final Dio _dio;

  AnalysisProvider({required this._dio});

  Future<Response<dynamic>> submitAnalysis({
    required String endpoint,
    required FormData data,
    ProgressCallback? onSendProgress,
  }) async {
    return _dio.post<dynamic>(
      endpoint,
      data: data,
      onSendProgress: onSendProgress,
      options: Options(
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 180),
      ),
    );
  }
}
