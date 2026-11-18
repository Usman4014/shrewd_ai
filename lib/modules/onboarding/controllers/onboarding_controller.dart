
import 'package:get/get.dart';
import 'package:shrewd_ai/app/routes/app_routes.dart';
import 'package:shrewd_ai/core/constants/storage_constants.dart';
import 'package:shrewd_ai/data/providers/local_storage_provider.dart';

class OnboardingController extends GetxController {
  final LocalStorageProvider _storageProvider =
      Get.find<LocalStorageProvider>();

  Future<void> completeOnboarding() async {
    await _storageProvider.saveSetting(
      key: StorageConstants.onboardingCompleted,
      value: true,
    );

    Get.offAllNamed(AppRoutes.main);
  }
}
