
import 'package:dio/dio.dart';
import 'package:shrewd_ai/data/providers/analysis_provider.dart';

class AnalysisRepository {
  final AnalysisProvider _analysisProvider;

  AnalysisRepository({
    required this._analysisProvider,
  });

  Future<Response<dynamic>> submitAnalysis({
    required String endpoint,
    required FormData data,
    ProgressCallback? onSendProgress,
  }) {
    return _analysisProvider.submitAnalysis(
      endpoint: endpoint,
      data: data,
      onSendProgress: onSendProgress,
    );
  }
}
