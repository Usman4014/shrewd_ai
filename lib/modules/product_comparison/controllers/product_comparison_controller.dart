
import 'package:get/get.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';
import 'package:shrewd_ai/data/repositories/history_repository.dart';
import 'package:shrewd_ai/shared/widgets/app_snackbar.dart';

class ProductComparisonController extends GetxController {
  final HistoryRepository _historyRepository;

  ProductComparisonController({
    required this._historyRepository,
  });

  final RxList<AnalysisReportModel> savedReports =
      <AnalysisReportModel>[].obs;

  final RxList<String> selectedReportIds = <String>[].obs;

  final RxBool isLoading = false.obs;

  AnalysisReportModel? get firstSelectedReport {
    if (selectedReportIds.isEmpty) return null;

    return _findReport(selectedReportIds[0]);
  }

  AnalysisReportModel? get secondSelectedReport {
    if (selectedReportIds.length < 2) return null;

    return _findReport(selectedReportIds[1]);
  }

  bool get canCompare => selectedReportIds.length == 2;

  bool get hasReports => savedReports.isNotEmpty;

  bool get hasSelection => selectedReportIds.isNotEmpty;

  bool get isComparisonReady => canCompare &&
      firstSelectedReport != null &&
      secondSelectedReport != null;

  @override
  void onInit() {
    super.onInit();
    loadSavedReports();
  }

  void loadSavedReports() {
    try {
      isLoading.value = true;

      final reports = _historyRepository
          .getAllAnalyses()
          .map(AnalysisReportModel.fromMap)
          .where((report) => report.id != null)
          .toList();

      reports.sort((a, b) {
        final firstDate = a.analyzedAt;
        final secondDate = b.analyzedAt;

        if (firstDate == null && secondDate == null) return 0;
        if (firstDate == null) return 1;
        if (secondDate == null) return -1;

        return secondDate.compareTo(firstDate);
      });

      savedReports.assignAll(reports);
      selectedReportIds.clear();
    } catch (e) {
      AppSnackbar.error(
        'Please try again later.',
        //title: 'Unable to load history',
      );
    } finally {
      isLoading.value = false;
    }
  }

  AnalysisReportModel? _findReport(String id) {
    for (final report in savedReports) {
      if (report.id == id) return report;
    }

    return null;
  }

  bool isSelected(String? id) {
    if (id == null) return false;
    return selectedReportIds.contains(id);
  }

  void toggleSelection(AnalysisReportModel report) {
    final id = report.id;

    if (id == null) return;

    if (selectedReportIds.contains(id)) {
      selectedReportIds.remove(id);
      return;
    }

    if (selectedReportIds.length >= 2) {
      AppSnackbar.warning(
        'Please select only two products to compare.',
       // title: 'Selection limit reached',
      );
      return;
    }

    selectedReportIds.add(id);
  }

  void clearSelection() {
    selectedReportIds.clear();
  }

  void compareProducts() {
    if (!isComparisonReady) {
      AppSnackbar.warning(
        'Choose two saved analyses to continue.',
       // title: 'Select two products',
      );
      return;
    }

    Get.focusScope?.unfocus();
  }

  String getProductName(AnalysisReportModel report) {
    final name = report.product.productName?.trim();

    if (name != null && name.isNotEmpty) {
      return name;
    }

    return report.product.category ?? 'Unnamed Product';
  }

  String getProductPrice(AnalysisReportModel report) {
    final price = report.product.askingPrice;

    if (price == null) return 'Not provided';

    final currency = report.product.currency?.trim();

    final formattedPrice = price.toStringAsFixed(
      price.truncateToDouble() == price ? 0 : 2,
    );

    if (currency == null || currency.isEmpty) {
      return formattedPrice;
    }

    return '$currency $formattedPrice';
  }

  String getProductCategory(AnalysisReportModel report) {
    final category = report.product.category;
    final subcategory = report.product.subcategory;

    if (category == null || category.isEmpty) {
      return 'Not provided';
    }

    if (subcategory == null || subcategory.isEmpty) {
      return category;
    }

    return '$category • $subcategory';
  }

  String getProductModel(AnalysisReportModel report) {
    final model = report.product.model?.trim();

    if (model == null || model.isEmpty) {
      return 'Not provided';
    }

    return model;
  }

  String getProductCondition(AnalysisReportModel report) {
    final condition = report.product.condition?.trim();

    if (condition == null || condition.isEmpty) {
      return 'Not provided';
    }

    return condition;
  }

  String getSellerDescription(AnalysisReportModel report) {
    final description = report.product.sellerDescription?.trim();

    if (description == null || description.isEmpty) {
      return 'Not provided';
    }

    return description;
  }

  String getAnalysisDate(AnalysisReportModel report) {
    final date = report.analyzedAt;

    if (date == null) return 'Date unavailable';

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;

    return '$day/$month/$year';
  }
}
