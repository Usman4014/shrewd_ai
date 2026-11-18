
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/shared/widgets/app_text_field.dart';

class SellerDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const SellerDescriptionField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: AppConstants.productDescriptionLabel,
      hint: AppConstants.productDescriptionHint,
      maxLines: 5,
      maxLength: 1000,
    );
  }
}
