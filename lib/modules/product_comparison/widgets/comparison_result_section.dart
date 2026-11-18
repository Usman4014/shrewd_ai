
import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';

class ComparisonResultSection extends StatelessWidget {
  final AnalysisReportModel firstReport;
  final AnalysisReportModel secondReport;

  const ComparisonResultSection({
    super.key,
    required this.firstReport,
    required this.secondReport,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildListSection(
          context,
          title: 'Visible Condition Observations',
          icon: PhosphorIconsRegular.eye,
          firstItems: firstReport.visibleConditionObservations,
          secondItems: secondReport.visibleConditionObservations,
        ),
        _buildListSection(
          context,
          title: 'Positive Aspects',
          icon: PhosphorIconsRegular.thumbsUp,
          firstItems: firstReport.positiveAspects,
          secondItems: secondReport.positiveAspects,
        ),
        _buildListSection(
          context,
          title: 'Potential Red Flags',
          icon: PhosphorIconsRegular.warning,
          firstItems: firstReport.potentialRedFlags,
          secondItems: secondReport.potentialRedFlags,
        ),
        _buildListSection(
          context,
          title: 'Missing Information',
          icon: PhosphorIconsRegular.info,
          firstItems: firstReport.missingInformation,
          secondItems: secondReport.missingInformation,
        ),
        _buildListSection(
          context,
          title: 'Price Considerations',
          icon: PhosphorIconsRegular.currencyCircleDollar,
          firstItems: firstReport.priceConsiderations,
          secondItems: secondReport.priceConsiderations,
        ),
        _buildListSection(
          context,
          title: 'Seller Questions',
          icon: PhosphorIconsRegular.chats,
          firstItems: firstReport.questionsToAskSeller,
          secondItems: secondReport.questionsToAskSeller,
        ),
        _buildListSection(
          context,
          title: 'Inspection Checklist',
          icon: PhosphorIconsRegular.listChecks,
          firstItems: firstReport.inspectionChecklist,
          secondItems: secondReport.inspectionChecklist,
        ),
      ],
    );
  }

  Widget _buildListSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<String> firstItems,
    required List<String> secondItems,
  }) {
    if (firstItems.isEmpty && secondItems.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: AppDesignTokens.spacingRegular,
      ),
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
            child: Row(
              children: [
                Icon(
                  icon,
                  color: colors.primary,
                  size: AppDesignTokens.iconSizeMedium,
                ),
                SizedBox(
                  width: AppDesignTokens.spacingSmall,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildItems(
                    context,
                    firstItems,
                  ),
                ),
                SizedBox(
                  width: AppDesignTokens.spacingRegular,
                ),
                Expanded(
                  child: _buildItems(
                    context,
                    secondItems,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItems(
    BuildContext context,
    List<String> items,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (items.isEmpty) {
      return Text(
        'No information available',
        style: theme.textTheme.bodySmall?.copyWith(
          color: colors.onSurfaceVariant,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: AppDesignTokens.spacingSmall,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: AppDesignTokens.spacingExtraSmall,
                ),
                child: Icon(
                  PhosphorIconsRegular.circle,
                  size: AppDesignTokens.iconSizeExtraSmall,
                  color: colors.primary,
                ),
              ),
              SizedBox(
                width: AppDesignTokens.spacingSmall,
              ),
              Expanded(
                child: Text(
                  item,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
