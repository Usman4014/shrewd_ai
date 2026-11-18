
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/constants/asset_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class AnalyzeProductCard extends StatelessWidget {
  final VoidCallback onPressed;

  const AnalyzeProductCard({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
   
      decoration: BoxDecoration(
      color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: AppDesignTokens.borderWidthThin,
        ),
      ),
      padding: const EdgeInsets.all(
        AppDesignTokens.homeHeroPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.homeAnalysisTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: AppDesignTokens.spacingSmall,
                    ),
                    Text(
                      AppConstants.homeAnalysisDescription,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: AppDesignTokens.spacingSmall,
              ),
              Expanded(
                flex: 4,
                child: Image.asset(
                  AssetConstants.onboardingImage,
                  height: AppDesignTokens.homeHeroImageHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppDesignTokens.spacingRegular,
          ),
          SizedBox(
            width: double.infinity,
            height: AppDesignTokens.buttonHeightLarge,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                AppConstants.homeAnalysisButton,
              ),
            ),
          ),
          

        ],
      ),
    );
  }
}
