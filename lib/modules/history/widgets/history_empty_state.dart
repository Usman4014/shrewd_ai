
import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class HistoryEmptyState extends StatelessWidget {
  const HistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppDesignTokens.spacingXXLarge,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.clockCounterClockwise,
              size: AppDesignTokens.iconSizeExtraLarge +
                  AppDesignTokens.iconSizeLarge,
              color: theme.colorScheme.secondary,
            ),
            const SizedBox(
              height: AppDesignTokens.spacingLarge,
            ),
            Text(
              AppConstants.homeRecentEmptyTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: AppDesignTokens.spacingSmall,
            ),
            Text(
              AppConstants.homeRecentEmptyDescription,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


