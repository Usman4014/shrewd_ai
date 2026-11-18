import 'package:shrewd_ai/data/models/analysis_report_model.dart';
import 'package:shrewd_ai/data/providers/local_storage_provider.dart';

class HistoryRepository {
  final LocalStorageProvider _storageProvider;

  HistoryRepository({
    required this._storageProvider,
  });

  Future<String> saveReport(AnalysisReportModel report) async {
    final key = report.id ??
        DateTime.now().microsecondsSinceEpoch.toString();

    final data = report.toMap();
    data['id'] = key;

    await _storageProvider.saveAnalysis(
      key: key,
      data: data,
    );

    return key;
  }

  Future<void> saveAnalysis({
    required String key,
    required Map<String, dynamic> data,
  }) {
    return _storageProvider.saveAnalysis(
      key: key,
      data: data,
    );
  }

  Map<String, dynamic>? getAnalysis(String key) {
    return _storageProvider.getAnalysis(key);
  }

  List<Map<String, dynamic>> getAllAnalyses() {
    return _storageProvider.getAllAnalyses();
  }

  Future<void> deleteAnalysis(String key) {
    return _storageProvider.deleteAnalysis(key);
  }

  Future<void> clearHistory() {
    return _storageProvider.clearAnalysisHistory();
  }
}