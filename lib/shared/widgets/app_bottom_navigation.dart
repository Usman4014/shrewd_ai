
import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: theme.colorScheme.surface,
      indicatorColor: theme.colorScheme.primary.withValues(alpha: 0.15),
      height: AppDesignTokens.buttonHeightLarge +
          AppDesignTokens.spacingRegular,
      destinations: const [
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.house),
          selectedIcon: Icon(PhosphorIconsFill.house),
          label: AppConstants.mainHomeLabel,
        ),
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.arrowsLeftRight),
          selectedIcon: Icon(PhosphorIconsFill.arrowsLeftRight),
          label: AppConstants.mainCompareLabel,
        ),
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.clockCounterClockwise),
          selectedIcon: Icon(PhosphorIconsFill.clockCounterClockwise),
          label: AppConstants.mainHistoryLabel,
        ),
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.gear),
          selectedIcon: Icon(PhosphorIconsFill.gear),
          label: AppConstants.mainSettingsLabel,
        ),
      ],
    );
  }
}
