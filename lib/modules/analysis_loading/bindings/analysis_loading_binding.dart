
import 'package:get/get.dart';
import 'package:shrewd_ai/modules/analysis_loading/controllers/analysis_loading_controller.dart';

class AnalysisLoadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalysisLoadingController>(
      () => AnalysisLoadingController(),
    );
  }
}
