import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/core/theme/app_motion_tokens.dart';
import 'package:shrewd_ai/modules/analysis_result/controllers/analysis_result_controller.dart';
import 'package:shrewd_ai/modules/analysis_result/widgets/condition_observations.dart';
import 'package:shrewd_ai/modules/analysis_result/widgets/inspection_tips_section.dart';
import 'package:shrewd_ai/modules/analysis_result/widgets/missing_information_section.dart';
import 'package:shrewd_ai/modules/analysis_result/widgets/overall_assessment_card.dart';
import 'package:shrewd_ai/modules/analysis_result/widgets/positive_points_section.dart';
import 'package:shrewd_ai/modules/analysis_result/widgets/price_considerations_section.dart';
import 'package:shrewd_ai/modules/analysis_result/widgets/product_overview_card.dart';
import 'package:shrewd_ai/modules/analysis_result/widgets/red_flags_section.dart';
import 'package:shrewd_ai/modules/analysis_result/widgets/seller_questions_section.dart';

class AnalysisResultView extends GetView<AnalysisResultController> {
  const AnalysisResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppConstants.analysisResultTitle,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Obx(() {
        final report = controller.report.value;

        if (report == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppDesignTokens.spacingXXLarge),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIconsRegular.fileText,
                    size: AppDesignTokens.iconSizeExtraLarge,
                    color: theme.colorScheme.secondary,
                  ),
                  const SizedBox(height: AppDesignTokens.spacingRegular),
                  Text(
                    AppConstants.analysisResultEmptyTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppDesignTokens.spacingSmall),
                  Text(
                    AppConstants.analysisResultEmptyDescription,
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

        final hasAssessment =
            report.overallDealAssessment?.trim().isNotEmpty == true ||
            report.aiRecommendation?.trim().isNotEmpty == true;

        final hasObservations = report.visibleConditionObservations.any(
          (item) => item.trim().isNotEmpty,
        );

        final hasPositivePoints = report.positiveAspects.any(
          (item) => item.trim().isNotEmpty,
        );

        final hasRedFlags = report.potentialRedFlags.any(
          (item) => item.trim().isNotEmpty,
        );

        final hasMissingInformation = report.missingInformation.any(
          (item) => item.trim().isNotEmpty,
        );

        final hasSellerQuestions = report.questionsToAskSeller.any(
          (item) => item.trim().isNotEmpty,
        );

        final hasInspectionTips = report.inspectionChecklist.any(
          (item) => item.trim().isNotEmpty,
        );

        final hasPriceConsiderations = report.priceConsiderations.any(
          (item) => item.trim().isNotEmpty,
        );

        final hasAdditionalSections =
            hasAssessment ||
            hasObservations ||
            hasPositivePoints ||
            hasRedFlags ||
            hasMissingInformation ||
            hasSellerQuestions ||
            hasInspectionTips ||
            hasPriceConsiderations;

        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: AppMotionTokens.fadeThrough,
          curve: AppMotionTokens.standardCurve,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignTokens.screenHorizontalPadding,
              vertical: AppDesignTokens.screenVerticalPadding,
            ),
            children: [
              ProductOverviewCard(report: report),

              if (hasAssessment) ...[
                const SizedBox(height: AppDesignTokens.spacingLarge),
                OverallAssessmentCard(report: report),
              ],

              if (hasObservations) ...[
                const SizedBox(height: AppDesignTokens.spacingLarge),
                ConditionObservations(
                  observations: report.visibleConditionObservations,
                ),
              ],

              if (hasPositivePoints) ...[
                const SizedBox(height: AppDesignTokens.spacingLarge),
                PositivePointsSection(items: report.positiveAspects),
              ],

              if (hasRedFlags) ...[
                const SizedBox(height: AppDesignTokens.spacingLarge),
                RedFlagsSection(items: report.potentialRedFlags),
              ],

              if (hasMissingInformation) ...[
                const SizedBox(height: AppDesignTokens.spacingLarge),
                MissingInformationSection(items: report.missingInformation),
              ],

              if (hasSellerQuestions) ...[
                const SizedBox(height: AppDesignTokens.spacingLarge),
                SellerQuestionsSection(questions: report.questionsToAskSeller),
              ],

              if (hasInspectionTips) ...[
                const SizedBox(height: AppDesignTokens.spacingLarge),
                InspectionTipsSection(items: report.inspectionChecklist),
              ],

              if (hasPriceConsiderations) ...[
                const SizedBox(height: AppDesignTokens.spacingLarge),
                PriceConsiderationsSection(items: report.priceConsiderations),
              ],

              SizedBox(
                height: hasAdditionalSections
                    ? AppDesignTokens.spacingXXLarge
                    : AppDesignTokens.spacingLarge,
              ),

              Text(
                AppConstants.analysisDisclaimer,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),

              const SizedBox(height: AppDesignTokens.spacingLarge),
            ],
          ),
          builder: (context, value, child) {
            return FadeTransition(
              opacity: AlwaysStoppedAnimation<double>(value),
              child: child,
            );
          },
        );
      }),
    );
  }
}
