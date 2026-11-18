
import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class AnalysisLoadingStep extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isCompleted;
  final bool isActive;

  const AnalysisLoadingStep({
    super.key,
    required this.title,
    required this.icon,
    this.isCompleted = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    final iconColor = isCompleted || isActive
        ? accent
        : theme.colorScheme.secondary;

    final textColor = isCompleted || isActive
        ? theme.colorScheme.onSurface
        : theme.colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDesignTokens.spacingRegular,
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: AppDesignTokens.buttonHeightSmall,
            height: AppDesignTokens.buttonHeightSmall,
            decoration: BoxDecoration(
              border: Border.all(
                color: isCompleted || isActive
                    ? accent
                    : theme.dividerColor,
                width: AppDesignTokens.borderWidthThin,
              ),
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isCompleted
                    ? Icon(
                        PhosphorIconsRegular.check,
                        key: const ValueKey('completed'),
                        color: accent,
                        size: AppDesignTokens.iconSizeRegular,
                      )
                    : Icon(
                        icon,
                        key: const ValueKey('stage'),
                        color: iconColor,
                        size: AppDesignTokens.iconSizeRegular,
                      ),
              ),
            ),
          ),
          const SizedBox(width: AppDesignTokens.spacingRegular),
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: theme.textTheme.bodyMedium!.copyWith(
                color: textColor,
                fontWeight: isActive || isCompleted
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
              child: Text(title),
            ),
          ),
          if (isActive && !isCompleted)
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: AppDesignTokens.borderWidthThin,
                color: accent,
              ),
            ),
        ],
      ),
    );
  }
}
