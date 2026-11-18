
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/data/models/product_subcategory_model.dart';
import 'package:shrewd_ai/shared/widgets/app_dropdown.dart';

class SubcategorySelector extends StatelessWidget {
  final List<ProductSubcategoryModel> subcategories;
  final ProductSubcategoryModel? selectedSubcategory;
  final ValueChanged<ProductSubcategoryModel?> onChanged;
  final String? Function(ProductSubcategoryModel?) validator;
  final bool enabled;

  const SubcategorySelector({
    super.key,
    required this.subcategories,
    required this.selectedSubcategory,
    required this.onChanged,
    required this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdown<ProductSubcategoryModel>(
      enabled: enabled,
      label: AppConstants.productSubcategoryLabel,
      hint: AppConstants.productSubcategoryHint,
      value: selectedSubcategory,
      items: subcategories,
      itemLabel: (subcategory) => subcategory.name,
      onChanged: enabled ? onChanged : (_) {},
      validator: validator,
      required: true,
    );
  }
}
