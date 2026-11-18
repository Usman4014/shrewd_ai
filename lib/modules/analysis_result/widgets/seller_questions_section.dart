
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class SellerQuestionsSection extends StatelessWidget {
  final List<String> questions;

  const SellerQuestionsSection({
    super.key,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = questions
        .where((item) => item.trim().isNotEmpty)
        .toList();

    if (items.isEmpty) return const SizedBox.shrink();

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
            AppConstants.analysisSellerQuestionsTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingRegular),
          ...List.generate(items.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: AppDesignTokens.spacingSmall,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${index + 1}.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: AppDesignTokens.spacingRegular,
                  ),
                  Expanded(
                    child: Text(
                      items[index],
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
