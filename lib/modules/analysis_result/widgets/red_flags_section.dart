
import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class RedFlagsSection extends StatelessWidget {
  final List<String> items;

  const RedFlagsSection({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleItems = items
        .where((item) => item.trim().isNotEmpty)
        .toList();

    if (visibleItems.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppDesignTokens.spacingRegular,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.colorScheme.error,
          width: AppDesignTokens.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.analysisRedFlagsTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingRegular),
          ...visibleItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(
                bottom: AppDesignTokens.spacingSmall,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    PhosphorIconsRegular.warning,
                    size: AppDesignTokens.iconSizeRegular,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(
                    width: AppDesignTokens.spacingRegular,
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: theme.textTheme.bodyMedium,
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
