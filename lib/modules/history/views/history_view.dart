
import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:shrewd_ai/shared/widgets/app_motion_dialog.dart';
import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/core/theme/app_motion_tokens.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';
import 'package:shrewd_ai/modules/analysis_result/controllers/analysis_result_controller.dart';
import 'package:shrewd_ai/modules/analysis_result/views/analysis_result_view.dart';
import '../controllers/history_controller.dart';
import '../widgets/history_empty_state.dart';
import '../widgets/history_filter_bar.dart';
import '../widgets/history_item_card.dart';
import '../widgets/history_search_bar.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppConstants.historyTitle,
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Obx(
            () => controller.hasHistory
                ? IconButton(
                    tooltip: AppConstants.historyClearButton,
                    onPressed: () => _confirmClearHistory(context),
                    icon: const Icon(PhosphorIconsRegular.trash),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(width: AppDesignTokens.spacingSmall),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.analyses.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty &&
              controller.analyses.isEmpty) {
            return _buildErrorState(context);
          }

          if (!controller.hasHistory) {
            return RefreshIndicator(
              onRefresh: controller.refreshHistory,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: constraints.maxHeight,
                        child: const HistoryEmptyState(),
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return Column(
            children: [
              const HistorySearchBar(),
              const HistoryFilterBar(),
              Expanded(child: _buildAnalysisList(context)),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildAnalysisList(BuildContext context) {
    return Obx(() {
      final reports = controller.filteredAnalyses;

      if (reports.isEmpty) {
        return _buildNoResultsState(context);
      }

      return RefreshIndicator(
        onRefresh: controller.refreshHistory,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppDesignTokens.screenHorizontalPadding,
            AppDesignTokens.spacingSmall,
            AppDesignTokens.screenHorizontalPadding,
            AppDesignTokens.spacingXXLarge,
          ),
          itemCount: reports.length,
          separatorBuilder: (_, _) =>
              const SizedBox(height: AppDesignTokens.spacingRegular),
          itemBuilder: (context, index) {
            final report = reports[index];

            return _buildHistoryContainer(context, report);
          },
        ),
      );
    });
  }

  Widget _buildHistoryContainer(
    BuildContext context,
    AnalysisReportModel report,
  ) {
    final theme = Theme.of(context);

    return OpenContainer<AnalysisReportModel>(
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
        return HistoryItemCard(
          report: report,
          onTap: openContainer,
          onDelete: () => _confirmDeleteAnalysis(context, report),
        );
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

  Widget _buildNoResultsState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spacingXXLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.magnifyingGlass,
              size:
                  AppDesignTokens.iconSizeExtraLarge +
                  AppDesignTokens.iconSizeLarge,
              color: theme.colorScheme.secondary,
            ),
            const SizedBox(height: AppDesignTokens.spacingLarge),
            Text(
              AppConstants.historyNoResultsTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingSmall),
            Text(
              AppConstants.historyNoResultsDescription,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spacingXXLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.warningCircle,
              size: AppDesignTokens.iconSizeExtraLarge,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: AppDesignTokens.spacingRegular),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: AppDesignTokens.spacingRegular),
            TextButton(
              onPressed: controller.loadHistory,
              child: Text(AppConstants.historyTitle),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteAnalysis(
    BuildContext context,
    AnalysisReportModel report,
  ) async {
    final confirmed = await AppMotionDialog.show<bool>(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);

        return AlertDialog(
          title: Text(AppConstants.historyDeleteTitle),
          content: Text(
            AppConstants.historyDeleteDescription,
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(AppConstants.historyCancelButton),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                AppConstants.historyDeleteButton,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await controller.deleteAnalysis(report);
    }
  }

  Future<void> _confirmClearHistory(BuildContext context) async {
    final confirmed = await AppMotionDialog.show<bool>(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);

        return AlertDialog(
          title: Text(AppConstants.historyClearTitle),
          content: Text(
            AppConstants.historyClearDescription,
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(AppConstants.historyCancelButton),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                AppConstants.historyClearButton,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await controller.clearHistory();
    }
  }
}
