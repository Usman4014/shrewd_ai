
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/data/models/product_category_model.dart';

import 'category_card.dart';

class CategorySection extends StatelessWidget {
  final List<ProductCategoryModel> categories;
  final ValueChanged<ProductCategoryModel> onCategoryTap;
  final VoidCallback onViewAll;

  const CategorySection({
    super.key,
    required this.categories,
    required this.onCategoryTap,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppConstants.homeCategoriesTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Text(
                AppConstants.homeViewAllCategories,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppDesignTokens.spacingSmall,
        ),
        Text(
          AppConstants.homeCategoriesDescription,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(
          height: AppDesignTokens.spacingRegular,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: AppConstants.homeCategoryGridColumns,
childAspectRatio: AppConstants.homeCategoryCardAspectRatio,
            crossAxisSpacing: AppDesignTokens.spacingRegular,
            mainAxisSpacing: AppDesignTokens.spacingRegular,
            
          ),
          itemBuilder: (context, index) {
            final category = categories[index];

            return CategoryCard(
              category: category,
              onTap: () => onCategoryTap(category),
            );
          },
        ),
      ],
    );
  }
}
