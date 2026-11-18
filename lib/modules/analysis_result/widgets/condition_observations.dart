
import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class ConditionObservations extends StatelessWidget {
  final List<String> observations;

  const ConditionObservations({
    super.key,
    required this.observations,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = observations
        .where((item) => item.trim().isNotEmpty)
        .toList();

    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppDesignTokens.spacingRegular,
      ),
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
            AppConstants.analysisConditionTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingRegular),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(
                bottom: AppDesignTokens.spacingSmall,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                  PhosphorIconsRegular.circle,
                    size: AppDesignTokens.iconSizeExtraSmall,
                    color: theme.colorScheme.primary,
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
