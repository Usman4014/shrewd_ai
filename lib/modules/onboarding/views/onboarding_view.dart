
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/constants/asset_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.screenHorizontalPadding,
            vertical: AppDesignTokens.screenVerticalPadding,
          ),
          child: Column(
            children: [
              // ONBOARDING ILLUSTRATION
              Expanded(
                flex: 5,
                child: Center(
                  child: Image.asset(
                    AssetConstants.onboardingImage,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),

              const SizedBox(
                height: AppDesignTokens.spacingXXLarge,
              ),

              // ONBOARDING CONTENT
              Text(
                AppConstants.onboardingTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(
                height: AppDesignTokens.spacingRegular,
              ),

              Text(
                AppConstants.onboardingDescription,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                  height: 1.6,
                ),
              ),

              const Spacer(),

              // GET STARTED BUTTON
              SizedBox(
                width: double.infinity,
                height: AppDesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: controller.completeOnboarding,
                  child: Text(
                    AppConstants.onboardingButtonText,
                  ),
                ),
              ),

              const SizedBox(
                height: AppDesignTokens.spacingLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
