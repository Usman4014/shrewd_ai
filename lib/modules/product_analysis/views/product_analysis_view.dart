import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

import '../controllers/product_analysis_controller.dart';
import '../widgets/category_selector.dart';
import '../widgets/product_condition_selector.dart';
import '../widgets/product_details_form.dart';
import '../widgets/product_image_picker.dart';
import '../widgets/seller_description_field.dart';
import '../widgets/subcategory_selector.dart';

class ProductAnalysisView extends GetView<ProductAnalysisController> {
  const ProductAnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppConstants.productAnalysisTitle,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignTokens.screenHorizontalPadding,
              vertical: AppDesignTokens.screenVerticalPadding,
            ),
            children: [
              Text(
                AppConstants.productAnalysisSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spacingXXLarge),

              Obx(
                () => CategorySelector(
                  categories: controller.categories.toList(),
                  selectedCategory: controller.selectedCategory.value,
                  onChanged: controller.selectCategory,
                  validator: controller.validateCategory,
                ),
              ),

              const SizedBox(height: AppDesignTokens.spacingLarge),

              Obx(
                () => SubcategorySelector(
                  subcategories: controller.subcategories.toList(),
                  selectedSubcategory: controller.selectedSubcategory.value,
                  onChanged: controller.selectSubcategory,
                  validator: controller.validateSubcategory,
                  enabled: controller.selectedCategory.value != null,
                ),
              ),

              const SizedBox(height: AppDesignTokens.spacingXXLarge),

              Obx(
                () => ProductDetailsForm(
                  productNameController: controller.productNameController,
                  modelController: controller.modelController,
                  priceController: controller.priceController,
                  selectedCurrency: controller.selectedCurrency.value,
                  onCurrencyChanged: controller.selectCurrency,
                  productNameValidator: controller.validateProductName,
                  priceValidator: controller.validatePrice,
                ),
              ),

              const SizedBox(height: AppDesignTokens.spacingXXLarge),

              Obx(
                () => ProductConditionSelector(
                  selectedCondition: controller.selectedCondition.value,
                  onChanged: controller.selectCondition,
                  validator: controller.validateCondition,
                ),
              ),

              const SizedBox(height: AppDesignTokens.spacingXXLarge),

              Obx(
                () => ProductImagePicker(
                  images: controller.selectedImages.toList(),
                  onAddImages: controller.addImages,
                  onRemoveImage: controller.removeImage,
                  onPreviewImage: controller.openImagePreview,
                  isPicking: controller.isPickingImages.value,
                ),
              ),

              const SizedBox(height: AppDesignTokens.spacingXXLarge),

              // Text(
              //   AppConstants.productDescriptionLabel,
              //   style: theme.textTheme.titleMedium?.copyWith(
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
             // const SizedBox(height: AppDesignTokens.spacingRegular),

              SellerDescriptionField(
                controller: controller.sellerDescriptionController,
              ),

              const SizedBox(height: AppDesignTokens.spacingXXLarge),

              SizedBox(
                height: AppDesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: controller.submitAnalysis,
                  child: Text(AppConstants.productAnalyzeButton),
                ),
              ),

              const SizedBox(height: AppDesignTokens.spacingXXLarge),
            ],
          ),
        ),
      ),
    );
  }
}
