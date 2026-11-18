
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/shared/widgets/app_dropdown.dart';
import 'package:shrewd_ai/shared/widgets/app_text_field.dart';

class ProductDetailsForm extends StatelessWidget {
  final TextEditingController productNameController;
  final TextEditingController modelController;
  final TextEditingController priceController;
  final String selectedCurrency;
  final ValueChanged<String?> onCurrencyChanged;
  final String? Function(String?) productNameValidator;
  final String? Function(String?) priceValidator;

  const ProductDetailsForm({
    super.key,
    required this.productNameController,
    required this.modelController,
    required this.priceController,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
    required this.productNameValidator,
    required this.priceValidator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.productDetailsSectionTitle,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingLarge),
        AppTextField(
          controller: productNameController,
          label: AppConstants.productNameLabel,
          hint: AppConstants.productNameHint,
          validator: productNameValidator,
          required: true,
        ),
        const SizedBox(height: AppDesignTokens.spacingLarge),
        AppTextField(
          controller: modelController,
          label: AppConstants.productModelLabel,
          hint: AppConstants.productModelHint,
        ),
        const SizedBox(height: AppDesignTokens.spacingLarge),
        AppTextField(
          controller: priceController,
          label: AppConstants.productPriceLabel,
          hint: AppConstants.productPriceHint,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          validator: priceValidator,
          required: true,
        ),
        const SizedBox(height: AppDesignTokens.spacingLarge),
        AppDropdown<String>(
          label: AppConstants.productCurrencyLabel,
          value: selectedCurrency,
          items: AppConstants.supportedCurrencies,
          itemLabel: (currency) => currency,
          onChanged: onCurrencyChanged,
          required: true,
        ),
      ],
    );
  }
}
