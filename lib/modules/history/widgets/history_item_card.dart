
import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';

class HistoryItemCard extends StatelessWidget {
  final AnalysisReportModel report;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const HistoryItemCard({
    super.key,
    required this.report,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = report.product;

    final imagePath = product.imagePaths.isNotEmpty
        ? product.imagePaths.first
        : null;

    final productName = product.productName?.trim().isNotEmpty == true
        ? product.productName!
        : AppConstants.historyProductFallback;

    final category = product.category?.trim().isNotEmpty == true
        ? product.category!
        : AppConstants.historyCategoryFallback;

    final price = product.askingPrice != null
        ? '${product.currency ?? ''} ${NumberFormat('#,##0.##').format(product.askingPrice)}'
        : AppConstants.historyPriceUnavailable;

    final analyzedDate = report.analyzedAt != null
        ? DateFormat('dd MMM yyyy').format(report.analyzedAt!)
        : AppConstants.historyDateFallback;

    return Card(
      margin: EdgeInsets.zero,
      color: theme.cardColor,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(
            AppDesignTokens.spacingRegular,
          ),
          child: Row(
            children: [
              _buildProductImage(
                theme,
                imagePath,
              ),
              const SizedBox(
                width: AppDesignTokens.spacingRegular,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: AppDesignTokens.spacingExtraSmall,
                    ),
                    Text(
                      category,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(
                      height: AppDesignTokens.spacingSmall,
                    ),
                    Text(
                      price,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: AppDesignTokens.spacingExtraSmall,
                    ),
                    Row(
                      children: [
                        Icon(
                          PhosphorIconsRegular.calendarBlank,
                          size: AppDesignTokens.iconSizeExtraSmall,
                          color: theme.colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: AppDesignTokens.spacingExtraSmall,
                        ),
                        Expanded(
                          child: Text(
                            analyzedDate,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onDelete,
                tooltip: AppConstants.historyDeleteButton,
                icon: Icon(
                  PhosphorIconsRegular.trash,
                  color: theme.colorScheme.error,
                  size: AppDesignTokens.iconSizeRegular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(
    ThemeData theme,
    String? imagePath,
  ) {
    if (imagePath == null || imagePath.isEmpty) {
      return _imagePlaceholder(theme);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        AppDesignTokens.borderRadiusNone,
      ),
      child: Image.file(
        File(imagePath),
        width: AppDesignTokens.imagePreviewSize,
        height: AppDesignTokens.imagePreviewSize,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _imagePlaceholder(theme),
      ),
    );
  }

  Widget _imagePlaceholder(ThemeData theme) {
    return Container(
      width: AppDesignTokens.imagePreviewSize,
      height: AppDesignTokens.imagePreviewSize,
      color: theme.colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(
        PhosphorIconsRegular.image,
        size: AppDesignTokens.iconSizeExtraLarge,
        color: theme.colorScheme.secondary,
      ),
    );
  }
}
