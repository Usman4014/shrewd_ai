
import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const SettingsItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spacingRegular,
      ),
      leading: Icon(
        icon,
        color: theme.colorScheme.primary,
        size: AppDesignTokens.iconSizeRegular,
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall,
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.secondary,
        ),
      ),
      trailing: onTap == null
          ? null
          : const Icon(PhosphorIconsRegular.caretRight),
      onTap: onTap,
    );
  }
}
