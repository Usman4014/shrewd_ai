
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/core/theme/app_motion_tokens.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';
import 'package:shrewd_ai/modules/analysis_result/controllers/analysis_result_controller.dart';
import 'package:shrewd_ai/modules/analysis_result/views/analysis_result_view.dart';

class RecentAnalysesSection extends StatelessWidget {
  final AnalysisReportModel? latestAnalysis;
  final VoidCallback onViewHistory;

  const RecentAnalysesSection({
    super.key,
    required this.latestAnalysis,
    required this.onViewHistory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppConstants.homeRecentTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: onViewHistory,
              child: Text(AppConstants.homeViewHistory),
            ),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacingSmall),
        if (latestAnalysis == null)
          _buildEmptyState(theme)
        else
          _buildLatestAnalysisCard(context, latestAnalysis!),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return CustomPaint(
      foregroundPainter: _DottedBorderPainter(color: theme.dividerColor),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.spacingRegular,
          vertical: AppDesignTokens.spacingLarge,
        ),
        color: theme.colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.clockCounterClockwise,
              size: AppDesignTokens.iconSizeLarge,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: AppDesignTokens.spacingSmall),
            Text(
              AppConstants.homeRecentEmptyTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestAnalysisCard(
    BuildContext context,
    AnalysisReportModel report,
  ) {
    final theme = Theme.of(context);

    return OpenContainer<void>(
      transitionDuration: AppMotionTokens.containerTransform,
      closedElevation: 0,
      openElevation: 0,
      closedColor: theme.cardColor,
      openColor: theme.scaffoldBackgroundColor,
      middleColor: theme.scaffoldBackgroundColor,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDesignTokens.borderRadiusNone),
      ),
      openShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDesignTokens.borderRadiusNone),
      ),
      clipBehavior: Clip.antiAlias,
      tappable: false,
      useRootNavigator: true,
      onClosed: (_) {
        if (Get.isRegistered<AnalysisResultController>()) {
          Get.delete<AnalysisResultController>(force: true);
        }
      },
      closedBuilder: (context, openContainer) {
        return _LatestAnalysisCard(report: report, onTap: openContainer);
      },
      openBuilder: (context, closeContainer) {
        if (Get.isRegistered<AnalysisResultController>()) {
          Get.delete<AnalysisResultController>(force: true);
        }

        Get.put<AnalysisResultController>(
          AnalysisResultController(initialReport: report),
        );

        return const AnalysisResultView();
      },
    );
  }
}

class _LatestAnalysisCard extends StatelessWidget {
  final AnalysisReportModel report;
  final VoidCallback onTap;

  const _LatestAnalysisCard({required this.report, required this.onTap});

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
          padding: const EdgeInsets.all(AppDesignTokens.spacingRegular),
          child: Row(
            children: [
              _buildProductImage(theme, imagePath),
              const SizedBox(width: AppDesignTokens.spacingRegular),
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
                    const SizedBox(height: AppDesignTokens.spacingExtraSmall),
                    Text(
                      category,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: AppDesignTokens.spacingSmall),
                    Text(
                      price,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppDesignTokens.spacingExtraSmall),
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
              Icon(
                PhosphorIconsRegular.caretRight,
                size: AppDesignTokens.iconSizeSmall,
                color: theme.colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(ThemeData theme, String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return _imagePlaceholder(theme);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDesignTokens.borderRadiusNone),
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

class _DottedBorderPainter extends CustomPainter {
  final Color color;

  const _DottedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    for (final metric in path.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        final end = (distance + 2).clamp(0.0, metric.length);

        canvas.drawPath(metric.extractPath(distance, end), paint);

        distance += 4;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DottedBorderPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
