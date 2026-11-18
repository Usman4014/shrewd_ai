
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/shared/enums/product_condition.dart';
import 'package:shrewd_ai/shared/widgets/app_dropdown.dart';

class ProductConditionSelector extends StatelessWidget {
  final ProductCondition? selectedCondition;
  final ValueChanged<ProductCondition?> onChanged;
  final String? Function(ProductCondition?) validator;

  const ProductConditionSelector({
    super.key,
    required this.selectedCondition,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdown<ProductCondition>(
      
      label: AppConstants.productConditionLabel,
      hint: AppConstants.productConditionHint,
      value: selectedCondition,
      items: ProductCondition.values,
      itemLabel: (condition) => condition.label,
      onChanged: onChanged,
      validator: validator,
      required: true,
    );
  }
}
