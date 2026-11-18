import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/core/theme/app_motion_tokens.dart';
import 'package:shrewd_ai/modules/product_comparison/controllers/product_comparison_controller.dart';
import 'package:shrewd_ai/modules/product_comparison/widgets/comparison_product_card.dart';
import 'package:shrewd_ai/modules/product_comparison/widgets/comparison_details_section.dart';
import 'package:shrewd_ai/modules/product_comparison/widgets/comparison_result_section.dart';

class ProductComparisonView extends GetView<ProductComparisonController> {
  const ProductComparisonView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Compare Products'), centerTitle: false),
      body: Obx(() {
        final Widget content;

        if (controller.isLoading.value) {
          content = const Center(
            key: ValueKey('comparison-loading'),
            child: CircularProgressIndicator(),
          );
        } else if (!controller.hasReports) {
          content = _buildEmptyState(context);
        } else {
          content = _buildComparisonContent(context);
        }

        return AnimatedSwitcher(
          duration: AppMotionTokens.fadeThrough,
          switchInCurve: AppMotionTokens.standardCurve,
          switchOutCurve: AppMotionTokens.standardCurve,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: KeyedSubtree(
            key: ValueKey<String>(
              controller.isLoading.value
                  ? 'loading'
                  : controller.hasReports
                  ? 'content'
                  : 'empty',
            ),
            child: content,
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (!controller.hasReports) {
          return const SizedBox.shrink();
        }

        return _buildBottomAction(context);
      }),
    );
  }

  Widget _buildComparisonContent(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SingleChildScrollView(
      key: const ValueKey('comparison-content'),
      padding: EdgeInsets.symmetric(
        horizontal: AppDesignTokens.screenHorizontalPadding,
        vertical: AppDesignTokens.screenVerticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Products',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppDesignTokens.spacingSmall),
          Text(
            'Choose two saved product analyses to compare their details and findings.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: AppDesignTokens.spacingRegular),
          _buildSelectionCounter(context),
          SizedBox(height: AppDesignTokens.spacingRegular),
          ...controller.savedReports.map(
            (report) => Padding(
              padding: EdgeInsets.only(bottom: AppDesignTokens.spacingRegular),
              child: ComparisonProductCard(
                report: report,
                controller: controller,
                isSelected: controller.isSelected(report.id),
              ),
            ),
          ),
          _buildComparisonSwitcher(context),
        ],
      ),
    );
  }

  Widget _buildComparisonSwitcher(BuildContext context) {
    final isReady = controller.isComparisonReady;

    final firstReport = controller.firstSelectedReport;
    final secondReport = controller.secondSelectedReport;

    if (!isReady || firstReport == null || secondReport == null) {
      return AnimatedSwitcher(
        duration: AppMotionTokens.fade,
        switchInCurve: AppMotionTokens.standardCurve,
        switchOutCurve: AppMotionTokens.standardCurve,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: SizedBox(
          key: const ValueKey('comparison-empty'),
          width: double.infinity,
        ),
      );
    }

    final comparisonKey = '${firstReport.id}_${secondReport.id}';

    return AnimatedSwitcher(
      duration: AppMotionTokens.fadeThrough,
      switchInCurve: AppMotionTokens.standardCurve,
      switchOutCurve: AppMotionTokens.standardCurve,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Padding(
        key: ValueKey<String>(comparisonKey),
        padding: EdgeInsets.only(top: AppDesignTokens.spacingLarge),
        child: _buildComparison(context, firstReport, secondReport),
      ),
    );
  }

  Widget _buildSelectionCounter(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: AnimatedSwitcher(
            duration: AppMotionTokens.fade,
            switchInCurve: AppMotionTokens.standardCurve,
            switchOutCurve: AppMotionTokens.standardCurve,
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Text(
              '${controller.selectedReportIds.length} of 2 products selected',
              key: ValueKey<int>(controller.selectedReportIds.length),
              style: theme.textTheme.labelLarge?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        if (controller.hasSelection)
          TextButton(
            onPressed: controller.clearSelection,
            child: const Text('Clear'),
          ),
      ],
    );
  }

  Widget _buildComparison(BuildContext context, firstReport, secondReport) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: AppDesignTokens.spacingXXLarge),
        Text(
          'Comparison Results',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: AppDesignTokens.spacingRegular),
        ComparisonDetailsSection(
          firstReport: firstReport,
          secondReport: secondReport,
          controller: controller,
        ),
        SizedBox(height: AppDesignTokens.spacingLarge),
        ComparisonResultSection(
          firstReport: firstReport,
          secondReport: secondReport,
        ),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Obx(() {
      return Container(
        padding: EdgeInsets.all(AppDesignTokens.spacingRegular),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(
            top: BorderSide(
              color: colors.outlineVariant,
              width: AppDesignTokens.borderWidthThin,
            ),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: AppDesignTokens.buttonHeightLarge,
          child: FilledButton(
            onPressed: controller.canCompare
                ? controller.compareProducts
                : null,
            child: const Text('Compare Selected Products'),
          ),
        ),
      );
    });
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Center(
      key: const ValueKey('comparison-empty-state'),
      child: Padding(
        padding: EdgeInsets.all(AppDesignTokens.spacingXXLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
             PhosphorIconsRegular.arrowsLeftRight,
              size: 56,
              color: colors.primary,
            ),
            SizedBox(height: AppDesignTokens.spacingLarge),
            Text(
              'No Saved Analyses',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDesignTokens.spacingSmall),
            Text(
              'Save at least two product analyses in your history to compare them here.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
