
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/data/models/product_category_model.dart';
import 'package:shrewd_ai/shared/widgets/app_dropdown.dart';

class CategorySelector extends StatelessWidget {
  final List<ProductCategoryModel> categories;
  final ProductCategoryModel? selectedCategory;
  final ValueChanged<ProductCategoryModel?> onChanged;
  final String? Function(ProductCategoryModel?) validator;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdown<ProductCategoryModel>(
      label: AppConstants.productCategoryLabel,
      hint: AppConstants.productCategoryHint,
      value: selectedCategory,
      items: categories,
      itemLabel: (category) => category.name,
      onChanged: onChanged,
      validator: validator,
      required: true,
    );
  }
}
