
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/constants/asset_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignTokens.screenHorizontalPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetConstants.appLogo,
                  height: AppDesignTokens.imagePreviewSize,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: AppDesignTokens.spacingExtraLarge,
                ),
                Text(
                  AppConstants.appName,
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: AppDesignTokens.spacingSmall,
                ),
                Text(
                  AppConstants.appTagline,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: AppDesignTokens.spacingXXLarge,
                ),
                SizedBox(
                  width: AppDesignTokens.iconSizeLarge,
                  height: AppDesignTokens.iconSizeLarge,
                  child: CircularProgressIndicator(
                    strokeWidth: AppDesignTokens.borderWidthMedium,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
