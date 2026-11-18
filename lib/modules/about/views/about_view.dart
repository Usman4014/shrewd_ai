import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/constants/asset_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/modules/about/controllers/about_controller.dart';
import 'package:shrewd_ai/shared/widgets/app_section_divider.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  static const String _aboutDescription =
      'SHREWD AI is an AI-powered second-hand product analysis assistant '
      'designed to help you make more informed buying decisions. '
      'Upload product images, provide basic product details, and receive '
      'a structured analysis to help you evaluate a product before purchasing.';

  static const String _purposeDescription =
      'Buying second-hand products can involve uncertainty about their '
      'visible condition, possible issues, and asking price. SHREWD AI '
      'helps reduce that uncertainty by organizing visual observations, '
      'potential concerns, and practical buying guidance in one report. '
      'Our goal is to help you ask better questions and inspect products '
      'more carefully before making a purchase.';

  static const List<String> _features = [
    'Analyze second-hand products using up to five images.',
    'Review AI-generated observations about visible product condition.',
    'Identify potential red flags and missing product information.',
    'Get practical questions to ask sellers before purchasing.',
    'Follow an inspection checklist when evaluating a product.',
    'Review price considerations and an overall buying recommendation.',
    'Save previous analyses locally for future reference.',
    'Compare two previously saved product analyses.',
    'Use the app without creating an account or signing up.',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.aboutTitle, style: theme.textTheme.titleLarge),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.screenHorizontalPadding,
          vertical: AppDesignTokens.screenVerticalPadding,
        ),
        children: [
          Column(
            children: [
              Image.asset(
                AssetConstants.appLogo,
                width: AppDesignTokens.homeHeaderLogoSize,
                height: AppDesignTokens.homeHeaderLogoSize,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: AppDesignTokens.spacingRegular),
              Text(
                AppConstants.appName,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spacingSmall),
              Text(
                AppConstants.aboutTagline,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacingXXLarge),
          _buildInformationSection(
            context,
            title: 'What Is SHREWD AI?',
            description: _aboutDescription,
          ),
          const SizedBox(height: AppDesignTokens.spacingLarge),
          _buildInformationSection(
            context,
            title: 'Our Purpose',
            description: _purposeDescription,
          ),
          const SizedBox(height: AppDesignTokens.spacingLarge),
          _buildFeaturesSection(context),
          const SizedBox(height: AppDesignTokens.spacingLarge),

          const AppSectionDivider(),
           const SizedBox(height: AppDesignTokens.spacingLarge),
        ],
      ),
    );
  }

  Widget _buildInformationSection(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDesignTokens.spacingRegular),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.dividerColor,
          width: AppDesignTokens.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingRegular),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDesignTokens.spacingRegular),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.dividerColor,
          width: AppDesignTokens.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What You Can Do',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingRegular),
          ..._features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(
                bottom: AppDesignTokens.spacingSmall,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    PhosphorIconsRegular.checkCircle,
                    size: AppDesignTokens.iconSizeRegular,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: AppDesignTokens.spacingRegular),
                  Expanded(
                    child: Text(
                      feature,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
