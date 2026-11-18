
import 'package:get/get.dart';

import 'package:shrewd_ai/data/repositories/history_repository.dart';
import 'package:shrewd_ai/modules/home/bindings/home_binding.dart';
import 'package:shrewd_ai/modules/history/bindings/history_binding.dart';
import 'package:shrewd_ai/modules/settings/bindings/settings_binding.dart';
import 'package:shrewd_ai/modules/product_comparison/controllers/product_comparison_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );

    HomeBinding().dependencies();
    HistoryBinding().dependencies();
    SettingsBinding().dependencies();

    Get.lazyPut<ProductComparisonController>(
      () => ProductComparisonController(
        historyRepository: Get.find<HistoryRepository>(),
      ),
    );
  }
}
