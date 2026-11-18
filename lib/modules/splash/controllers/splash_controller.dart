
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/app/routes/app_routes.dart';
import 'package:shrewd_ai/core/constants/storage_constants.dart';
import 'package:shrewd_ai/data/providers/local_storage_provider.dart';

class SplashController extends GetxController {
  final LocalStorageProvider _storageProvider =
      Get.find<LocalStorageProvider>();

  bool _hasNavigated = false;

  @override
  void onReady() {
    super.onReady();

    debugPrint('SHREWD AI: SplashController onReady called');

    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    if (_hasNavigated) return;

    try {
      debugPrint('SHREWD AI: Splash screen displayed');

      // KEEP SPLASH VISIBLE FOR 2 SECONDS
      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (isClosed || _hasNavigated) return;

      final bool isOnboardingCompleted =
          _storageProvider.getSetting(
            StorageConstants.onboardingCompleted,
          ) ??
          StorageConstants.defaultOnboardingCompleted;

      debugPrint(
        'SHREWD AI: Onboarding completed = $isOnboardingCompleted',
      );

      _hasNavigated = true;

      if (isOnboardingCompleted) {
        debugPrint('SHREWD AI: Navigating to Main');

        Get.offAllNamed(AppRoutes.main);
      } else {
        debugPrint('SHREWD AI: Navigating to Onboarding');

        Get.offAllNamed(AppRoutes.onboarding);
      }
    } catch (error, stackTrace) {
      debugPrint('SHREWD AI: Navigation error = $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}
