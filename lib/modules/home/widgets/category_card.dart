
import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/data/models/product_category_model.dart';

class CategoryCard extends StatelessWidget {
  final ProductCategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
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
        child: Row(
          children: [
            Icon(
             PhosphorIconsRegular.squaresFour,
              color: theme.colorScheme.primary,
              size: AppDesignTokens.iconSizeLarge,
            ),
            const SizedBox(
              width: AppDesignTokens.spacingSmall,
            ),
            Expanded(
              child: Text(
                category.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
