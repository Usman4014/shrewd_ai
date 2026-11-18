
import 'package:get/get.dart';

import 'package:shrewd_ai/modules/about/controllers/about_controller.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(
      () => AboutController(),
    );
  }
}
