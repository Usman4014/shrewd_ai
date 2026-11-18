import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

import '../controllers/history_controller.dart';

class HistoryFilterBar extends GetView<HistoryController> {
  const HistoryFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () {
        final categories = controller.availableCategories;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.screenHorizontalPadding,
            vertical: AppDesignTokens.spacingSmall,
          ),
          child: Row(
            children: categories.map((category) {
              final isSelected =
                  controller.selectedCategory.value == category;

              return Padding(
                padding: const EdgeInsets.only(
                  right: AppDesignTokens.spacingSmall,
                ),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) {
                    controller.selectCategory(category);
                  },
                  selectedColor: theme.colorScheme.primary,
                  backgroundColor: theme.colorScheme.surface,
                  labelStyle: theme.textTheme.labelLarge?.copyWith(
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface,
                  ),
                  side: BorderSide(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.dividerColor,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  showCheckmark: false,
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}