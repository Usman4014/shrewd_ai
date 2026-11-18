import 'package:get/get.dart';

import '../controllers/product_analysis_controller.dart';

class ProductAnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductAnalysisController>(() => ProductAnalysisController());
  }
}
