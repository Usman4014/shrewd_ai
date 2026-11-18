
import 'package:get/get.dart';

import 'package:shrewd_ai/modules/analysis_result/controllers/analysis_result_controller.dart';

class AnalysisResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalysisResultController>(
      () => AnalysisResultController(),
    );
  }
}
