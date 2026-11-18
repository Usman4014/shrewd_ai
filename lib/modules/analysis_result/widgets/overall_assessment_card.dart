
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';

class OverallAssessmentCard extends StatelessWidget {
  final AnalysisReportModel report;

  const OverallAssessmentCard({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final assessment = report.overallDealAssessment;
    final recommendation = report.aiRecommendation;

    final hasAssessment = assessment?.trim().isNotEmpty ?? false;
    final hasRecommendation =
        recommendation?.trim().isNotEmpty ?? false;

    if (!hasAssessment && !hasRecommendation) {
      return const SizedBox.shrink();
    }

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
            AppConstants.analysisOverallAssessmentTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (hasAssessment) ...[
            const SizedBox(height: AppDesignTokens.spacingRegular),
            Text(
              assessment!,
              style: theme.textTheme.bodyMedium,
            ),
          ],
          if (hasRecommendation) ...[
            const SizedBox(height: AppDesignTokens.spacingLarge),
            Text(
              AppConstants.analysisRecommendationTitle,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingSmall),
            Text(
              recommendation!,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}
