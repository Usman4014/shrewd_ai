
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';

class ProductOverviewCard extends StatelessWidget {
  final AnalysisReportModel report;

  const ProductOverviewCard({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = report.product;

    final details = <MapEntry<String, String>>[
      if (product.productName?.trim().isNotEmpty ?? false)
        MapEntry(
          AppConstants.analysisProductNameLabel,
          product.productName!,
        ),
      if (product.category?.trim().isNotEmpty ?? false)
        MapEntry(
          AppConstants.analysisCategoryLabel,
          product.category!,
        ),
      if (product.subcategory?.trim().isNotEmpty ?? false)
        MapEntry(
          AppConstants.analysisSubcategoryLabel,
          product.subcategory!,
        ),
      if (product.model?.trim().isNotEmpty ?? false)
        MapEntry(
          AppConstants.analysisModelLabel,
          product.model!,
        ),
      if (product.askingPrice != null)
        MapEntry(
          AppConstants.analysisPriceLabel,
          '${product.currency ?? ''} ${product.askingPrice}',
        ),
      if (product.condition?.trim().isNotEmpty ?? false)
        MapEntry(
          AppConstants.analysisConditionLabel,
          product.condition!,
        ),
      if (report.analyzedAt != null)
        MapEntry(
          AppConstants.analysisDateLabel,
          DateFormat.yMMMd().format(report.analyzedAt!),
        ),
    ];

    return Container(
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.analysisProductDetailsTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingRegular),
          if (details.isEmpty)
            Text(
              AppConstants.analysisNoDetailsAvailable,
              style: theme.textTheme.bodyMedium,
            )
          else
            ...details.map(
              (detail) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDesignTokens.spacingSmall,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        detail.key,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        detail.value.trim(),
                        textAlign: TextAlign.end,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
