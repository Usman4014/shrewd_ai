
import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/core/theme/app_motion_tokens.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';
import 'package:shrewd_ai/modules/product_comparison/controllers/product_comparison_controller.dart';

class ComparisonProductCard extends StatelessWidget {
  final AnalysisReportModel report;
  final ProductComparisonController controller;
  final bool isSelected;

  const ComparisonProductCard({
    super.key,
    required this.report,
    required this.controller,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final imagePaths = report.product.imagePaths;
    final imagePath = imagePaths.isNotEmpty ? imagePaths.first : null;

    return InkWell(
      onTap: () => controller.toggleSelection(report),
      child: AnimatedContainer(
        duration: AppMotionTokens.standard,
        curve: AppMotionTokens.standardCurve,
        width: double.infinity,
        padding: const EdgeInsets.all(
          AppDesignTokens.spacingRegular,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary.withValues(alpha: 0.08)
              : colors.surface,
          border: Border.all(
            color: isSelected
                ? colors.primary
                : colors.outlineVariant,
            width: isSelected
                ? AppDesignTokens.borderWidthMedium
                : AppDesignTokens.borderWidthThin,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(
              context,
              imagePath,
            ),
            SizedBox(
              width: AppDesignTokens.spacingRegular,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.getProductName(report),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: AppDesignTokens.spacingExtraSmall,
                  ),
                  Text(
                    controller.getProductCategory(report),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(
                    height: AppDesignTokens.spacingSmall,
                  ),
                  Text(
                    controller.getProductPrice(report),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: AppDesignTokens.spacingSmall,
                  ),
                  Text(
                    'Analyzed: ${controller.getAnalysisDate(report)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AppDesignTokens.spacingSmall,
            ),
            AnimatedSwitcher(
              duration: AppMotionTokens.fade,
              switchInCurve: AppMotionTokens.standardCurve,
              switchOutCurve: AppMotionTokens.standardCurve,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
              child: Icon(
                isSelected
                    ? PhosphorIconsRegular.checkCircle
                    : PhosphorIconsRegular.circle,
                key: ValueKey<bool>(isSelected),
                color: isSelected
                    ? colors.primary
                    : colors.onSurfaceVariant,
                size: AppDesignTokens.iconSizeLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(
    BuildContext context,
    String? imagePath,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        border: Border.all(
          color: colors.outlineVariant,
          width: AppDesignTokens.borderWidthThin,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: imagePath != null && File(imagePath).existsSync()
          ? Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _placeholder(context),
            )
          : _placeholder(context),
    );
  }

  Widget _placeholder(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Icon(
      PhosphorIconsRegular.image,
      color: colors.onSurfaceVariant,
      size: AppDesignTokens.iconSizeLarge,
    );
  }
}
