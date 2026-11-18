
import 'package:get/get.dart';

import 'package:shrewd_ai/app/routes/app_routes.dart';

class AboutController extends GetxController {
  void openAiLimitations() {
    Get.toNamed(AppRoutes.aiLimitations);
  }

  void openPrivacyPolicy() {
    Get.toNamed(AppRoutes.privacyPolicy);
  }

  void openTerms() {
    Get.toNamed(AppRoutes.terms);
  }
}
