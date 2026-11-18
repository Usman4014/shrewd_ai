import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:shrewd_ai/data/repositories/history_repository.dart';
import 'package:shrewd_ai/modules/product_comparison/controllers/product_comparison_controller.dart';

class ProductComparisonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductComparisonController>(
      () => ProductComparisonController(
        historyRepository: Get.find<HistoryRepository>(),
      ),
    );
  }
}