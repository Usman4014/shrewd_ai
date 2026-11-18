
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/constants/asset_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AssetConstants.appLogo,
          width: AppDesignTokens.homeHeaderLogoSize,
          height: AppDesignTokens.homeHeaderLogoSize,
          fit: BoxFit.contain,
        ),
        const SizedBox(
          width: AppDesignTokens.spacingRegular,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConstants.homeWelcomeTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(
              //   height: AppDesignTokens.spacingExtraSmall,
              // ),
              Text(
                AppConstants.homeWelcomeDescription,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
