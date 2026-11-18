
import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class ImageActionBar extends StatelessWidget {
  final int currentIndex;
  final int totalImages;
  final VoidCallback onClose;
  final VoidCallback onDelete;

  const ImageActionBar({
    super.key,
    required this.currentIndex,
    required this.totalImages,
    required this.onClose,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spacingRegular,
        vertical: AppDesignTokens.spacingSmall,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onClose,
            icon: const Icon(PhosphorIconsRegular.x),
            color: theme.colorScheme.onSurface,
          ),
          const Spacer(),
          Text(
            '${currentIndex + 1} / $totalImages',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(PhosphorIconsRegular.trash),
            color: theme.colorScheme.error,
          ),
        ],
      ),
    );
  }
}
