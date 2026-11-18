import 'package:hive_ce/hive.dart';
import 'package:shrewd_ai/core/constants/storage_constants.dart';

class LocalStorageProvider {
  late Box<dynamic> _analysisBox;
  late Box<dynamic> _settingsBox;

  Future<void> init() async {
    _analysisBox = await Hive.openBox<dynamic>(
      StorageConstants.analysisBox,
    );

    _settingsBox = await Hive.openBox<dynamic>(
      StorageConstants.settingsBox,
    );
  }

  // ANALYSIS HISTORY

  Future<void> saveAnalysis({
    required String key,
    required Map<String, dynamic> data,
  }) async {
    await _analysisBox.put(key, data);
  }

  Map<String, dynamic>? getAnalysis(String key) {
    final data = _analysisBox.get(key);

    if (data == null) return null;

    return Map<String, dynamic>.from(data as Map);
  }

  List<Map<String, dynamic>> getAllAnalyses() {
    return _analysisBox.values
        .map((data) => Map<String, dynamic>.from(data as Map))
        .toList();
  }

  Future<void> deleteAnalysis(String key) async {
    await _analysisBox.delete(key);
  }

  Future<void> clearAnalysisHistory() async {
    await _analysisBox.clear();
  }

  // APP SETTINGS

  Future<void> saveSetting({
    required String key,
    required dynamic value,
  }) async {
    await _settingsBox.put(key, value);
  }

  dynamic getSetting(String key) {
    return _settingsBox.get(key);
  }

  Future<void> deleteSetting(String key) async {
    await _settingsBox.delete(key);
  }

  // STORAGE STATUS

  bool get isInitialized =>
      _analysisBox.isOpen && _settingsBox.isOpen;

  Future<void> close() async {
    await _analysisBox.close();
    await _settingsBox.close();
  }
}