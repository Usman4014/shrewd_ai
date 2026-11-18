import 'package:get/get.dart';

import 'package:shrewd_ai/core/services/api_service.dart';
import 'package:shrewd_ai/core/services/image_service.dart';

import 'package:shrewd_ai/data/providers/analysis_provider.dart';
import 'package:shrewd_ai/data/providers/local_storage_provider.dart';

import 'package:shrewd_ai/data/repositories/analysis_repository.dart';
import 'package:shrewd_ai/data/repositories/category_repository.dart';
import 'package:shrewd_ai/data/repositories/history_repository.dart';
import 'package:shrewd_ai/data/repositories/settings_repository.dart';

import 'package:shrewd_ai/shared/data/product_categories_data.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // API SERVICE
    Get.put<ApiService>(ApiService(), permanent: true);

    // ANALYSIS PROVIDER
    Get.put<AnalysisProvider>(
      AnalysisProvider(dio: Get.find<ApiService>().dio),
      permanent: true,
    );

    Get.put<ImageService>(ImageService(), permanent: true);

    // ANALYSIS REPOSITORY
    Get.put<AnalysisRepository>(
      AnalysisRepository(analysisProvider: Get.find<AnalysisProvider>()),
      permanent: true,
    );

    // CATEGORY REPOSITORY
    Get.put<CategoryRepository>(
      CategoryRepository(categories: ProductCategoriesData.categories),
      permanent: true,
    );

    // HISTORY REPOSITORY
    Get.put<HistoryRepository>(
      HistoryRepository(storageProvider: Get.find<LocalStorageProvider>()),
      permanent: true,
    );

    // SETTINGS REPOSITORY
    Get.put<SettingsRepository>(
      SettingsRepository(storageProvider: Get.find<LocalStorageProvider>()),
      permanent: true,
    );
  }
}
