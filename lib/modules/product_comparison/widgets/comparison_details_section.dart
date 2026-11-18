import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';
import 'package:shrewd_ai/modules/product_comparison/controllers/product_comparison_controller.dart';

class ComparisonDetailsSection extends StatelessWidget {
  final AnalysisReportModel firstReport;
  final AnalysisReportModel secondReport;
  final ProductComparisonController controller;

  const ComparisonDetailsSection({
    super.key,
    required this.firstReport,
    required this.secondReport,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final details = [
      _ComparisonRowData(
        title: 'Product Name',
        firstValue: controller.getProductName(firstReport),
        secondValue: controller.getProductName(secondReport),
      ),
      _ComparisonRowData(
        title: 'Category',
        firstValue: controller.getProductCategory(firstReport),
        secondValue: controller.getProductCategory(secondReport),
      ),
      _ComparisonRowData(
        title: 'Model',
        firstValue: controller.getProductModel(firstReport),
        secondValue: controller.getProductModel(secondReport),
      ),
      _ComparisonRowData(
        title: 'Condition',
        firstValue: controller.getProductCondition(firstReport),
        secondValue: controller.getProductCondition(secondReport),
      ),
      _ComparisonRowData(
        title: 'Asking Price',
        firstValue: controller.getProductPrice(firstReport),
        secondValue: controller.getProductPrice(secondReport),
      ),
      _ComparisonRowData(
        title: 'Seller Description',
        firstValue: controller.getSellerDescription(firstReport),
        secondValue: controller.getSellerDescription(secondReport),
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(
          color: colors.outlineVariant,
          width: AppDesignTokens.borderWidthThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              AppDesignTokens.spacingRegular,
            ),
            child: Text(
              'Product Details',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: colors.outlineVariant,
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppDesignTokens.spacingRegular,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.getProductName(firstReport),
                    style: theme.textTheme.labelLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: AppDesignTokens.spacingSmall,
                ),
                Expanded(
                  child: Text(
                    controller.getProductName(secondReport),
                    style: theme.textTheme.labelLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          ...details.map(
            (detail) => _buildComparisonRow(
              context,
              detail,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
    BuildContext context,
    _ComparisonRowData detail,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 1,
          color: colors.outlineVariant,
        ),
        Padding(
          padding: const EdgeInsets.all(
            AppDesignTokens.spacingRegular,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail.title,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: AppDesignTokens.spacingSmall,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      detail.firstValue,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    width: AppDesignTokens.spacingSmall,
                  ),
                  Expanded(
                    child: Text(
                      detail.secondValue,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ComparisonRowData {
  final String title;
  final String firstValue;
  final String secondValue;

  const _ComparisonRowData({
    required this.title,
    required this.firstValue,
    required this.secondValue,
  });
}