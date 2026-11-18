
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shrewd_ai/app/routes/app_routes.dart';
import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';
import 'package:shrewd_ai/data/repositories/history_repository.dart';
import 'package:shrewd_ai/shared/widgets/app_snackbar.dart';

class HistoryController extends GetxController {
  final HistoryRepository _historyRepository = Get.find<HistoryRepository>();

  final TextEditingController searchTextController =
      TextEditingController();

  final RxList<AnalysisReportModel> analyses =
      <AnalysisReportModel>[].obs;

  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategory =
      AppConstants.historyAllFilter.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  List<String> get availableCategories {
    final categories = analyses
        .map((report) => report.product.category)
        .whereType<String>()
        .where((category) => category.trim().isNotEmpty)
        .toSet()
        .toList();

    categories.sort();

    return [
      AppConstants.historyAllFilter,
      ...categories,
    ];
  }

  List<AnalysisReportModel> get filteredAnalyses {
    final query = searchQuery.value.trim().toLowerCase();

    return analyses.where((report) {
      final product = report.product;

      final matchesSearch =
          query.isEmpty ||
          (product.productName ?? '').toLowerCase().contains(query) ||
          (product.model ?? '').toLowerCase().contains(query) ||
          (product.category ?? '').toLowerCase().contains(query) ||
          (product.subcategory ?? '').toLowerCase().contains(query);

      final matchesCategory =
          selectedCategory.value == AppConstants.historyAllFilter ||
          product.category == selectedCategory.value;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  bool get hasHistory => analyses.isNotEmpty;

  bool get hasFilteredResults => filteredAnalyses.isNotEmpty;

  void loadHistory() {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final savedAnalyses = _historyRepository.getAllAnalyses();

      final reports = savedAnalyses
          .map((data) => AnalysisReportModel.fromMap(data))
          .toList();

      reports.sort((first, second) {
        final firstDate = first.analyzedAt;
        final secondDate = second.analyzedAt;

        if (firstDate == null && secondDate == null) return 0;
        if (firstDate == null) return 1;
        if (secondDate == null) return -1;

        return secondDate.compareTo(firstDate);
      });

      analyses.assignAll(reports);

      if (!availableCategories.contains(selectedCategory.value)) {
        selectedCategory.value = AppConstants.historyAllFilter;
      }
    } catch (_) {
      errorMessage.value = AppConstants.historyLoadError;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshHistory() async {
    loadHistory();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void clearSearch() {
    searchTextController.clear();
    searchQuery.value = '';
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void openAnalysis(AnalysisReportModel report) {
    Get.toNamed(AppRoutes.analysisResult, arguments: report);
  }

  Future<void> deleteAnalysis(AnalysisReportModel report) async {
    final id = report.id;

    if (id == null || id.isEmpty) return;

    try {
      await _historyRepository.deleteAnalysis(id);
      analyses.removeWhere((item) => item.id == id);

      AppSnackbar.success(
        AppConstants.historyDeletedMessage,
      );
    } catch (_) {
      AppSnackbar.error(
        AppConstants.historyDeleteError,
      );
    }
  }

  Future<void> clearHistory() async {
    try {
      await _historyRepository.clearHistory();
      analyses.clear();
      clearSearch();
      selectedCategory.value = AppConstants.historyAllFilter;

      AppSnackbar.success(
        AppConstants.historyClearedMessage,
      );
    } catch (_) {
      AppSnackbar.error(
        AppConstants.historyLoadError,
      );
    }
  }
}
