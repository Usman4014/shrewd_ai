
import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class ProductImagePicker extends StatelessWidget {
  final List<XFile> images;
  final VoidCallback onAddImages;
  final ValueChanged<int> onRemoveImage;
  final ValueChanged<int> onPreviewImage;
  final bool isPicking;

  const ProductImagePicker({
    super.key,
    required this.images,
    required this.onAddImages,
    required this.onRemoveImage,
    required this.onPreviewImage,
    this.isPicking = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.productImagesSectionTitle,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingSmall),
        Text(
          AppConstants.productImagesDescription,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingRegular),
        Wrap(
          spacing: AppDesignTokens.spacingRegular,
          runSpacing: AppDesignTokens.spacingRegular,
          children: [
            ...List.generate(images.length, (index) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () => onPreviewImage(index),
                    child: Hero(
                      tag: 'product-image-${images[index].path}',
                      child: SizedBox(
                        width: AppDesignTokens.imagePreviewSize,
                        height: AppDesignTokens.imagePreviewSize,
                        child: Image.file(
                          File(images[index].path),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                border: Border.all(
                                  color: theme.colorScheme.error,
                                  width: AppDesignTokens.borderWidthThin,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  PhosphorIconsRegular.imageBroken,
                                  size: AppDesignTokens.iconSizeExtraLarge,
                                  color: theme.colorScheme.error,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -AppDesignTokens.spacingSmall,
                    right: -AppDesignTokens.spacingSmall,
                    child: IconButton(
                      onPressed: () => onRemoveImage(index),
                      icon: const Icon(PhosphorIconsRegular.x),
                      color: theme.colorScheme.onPrimary,
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              );
            }),
            if (images.length < AppConstants.maxProductImages)
              InkWell(
                onTap: isPicking ? null : onAddImages,
                child: Container(
                  width: AppDesignTokens.imagePreviewSize,
                  height: AppDesignTokens.imagePreviewSize,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    border: Border.all(
                      color: theme.dividerColor,
                      width: AppDesignTokens.borderWidthThin,
                    ),
                  ),
                  child: Center(
                    child: isPicking
                        ? const CircularProgressIndicator()
                        : Icon(
                            PhosphorIconsRegular.plus,
                            size: AppDesignTokens.iconSizeExtraLarge,
                            color: theme.colorScheme.primary,
                          ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacingSmall),
        Text(
          '${images.length}/${AppConstants.maxProductImages}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
