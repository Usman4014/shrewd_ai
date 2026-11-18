import 'package:get/get.dart';

import 'package:shrewd_ai/app/routes/app_routes.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';
import 'package:shrewd_ai/data/models/product_category_model.dart';
import 'package:shrewd_ai/data/repositories/category_repository.dart';
import 'package:shrewd_ai/data/repositories/history_repository.dart';

class HomeController extends GetxController {
  final CategoryRepository _categoryRepository = Get.find<CategoryRepository>();

  final HistoryRepository _historyRepository = Get.find<HistoryRepository>();

  final RxList<ProductCategoryModel> categories = <ProductCategoryModel>[].obs;

  final RxInt analysisCount = 0.obs;

  final Rxn<AnalysisReportModel> latestAnalysis = Rxn<AnalysisReportModel>();

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  void loadHomeData() {
    categories.assignAll(_categoryRepository.getAllCategories());

    final analyses = _historyRepository.getAllAnalyses();

    analysisCount.value = analyses.length;

    if (analyses.isEmpty) {
      latestAnalysis.value = null;
      return;
    }

    final reports = analyses
        .map(
          (item) =>
              AnalysisReportModel.fromMap(Map<String, dynamic>.from(item)),
        )
        .toList();

    reports.sort((a, b) {
      final dateA = a.analyzedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final dateB = b.analyzedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

      return dateB.compareTo(dateA);
    });

    latestAnalysis.value = reports.first;
  }

  Future<void> refreshHome() async {
    loadHomeData();
  }

  void openProductAnalysis() {
    Get.toNamed(AppRoutes.productAnalysis);
  }

  void openCategories() {
    Get.toNamed(AppRoutes.categories);
  }

  void openCategory(ProductCategoryModel category) {
    Get.toNamed(AppRoutes.categories, arguments: category.name);
  }

  void openHistory() {
    Get.toNamed(AppRoutes.history);
  }

  void openProductComparison() {
    Get.toNamed(AppRoutes.productComparison);
  }
}
