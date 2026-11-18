
import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/shared/widgets/app_section_divider.dart';

class AiLimitationsView extends StatelessWidget {
  const AiLimitationsView({super.key});

  static const String _intro =
      'SHREWD AI uses artificial intelligence to analyze product images '
      'and provide buying guidance. While it can help you identify visible '
      'concerns and make more informed decisions, its results have certain '
      'limitations. Please review the following before relying on an analysis.';

  static const List<Map<String, String>> _limitationSections = [
    {
      'title': 'AI Analysis Is Not Always Accurate',
      'description':
          'AI-generated observations may sometimes be incomplete, '
              'inaccurate, or misleading. The analysis is intended to provide '
              'guidance, not a definitive assessment of a product.',
    },
    {
      'title': 'Only Visible Details Can Be Assessed',
      'description':
          'SHREWD AI analyzes the product details visible in the uploaded '
              'images. It cannot reliably identify internal damage, hidden '
              'defects, mechanical problems, or issues that are not visible '
              'in the provided photos.',
    },
    {
      'title': 'Image Quality Matters',
      'description':
          'Blurry, dark, incomplete, or poorly angled images can affect '
              'analysis quality. Clear images showing different sides and '
              'important details of the product can help produce more useful '
              'observations.',
    },
    {
      'title': 'No Authenticity Verification',
      'description':
          'SHREWD AI cannot guarantee whether a product is genuine, original, '
              'or counterfeit. Brand names, logos, serial numbers, and other '
              'visible details should be independently verified.',
    },
    {
      'title': 'Price Guidance Is an Estimate',
      'description':
          'Price considerations and buying recommendations are AI-generated '
              'guidance. They are not verified market valuations and may not '
              'reflect current market prices, local demand, or the actual '
              'condition of a product.',
    },
    {
      'title': 'Seller Information Is Not Verified',
      'description':
          'SHREWD AI cannot independently verify seller statements, product '
              'history, ownership, warranty status, or claims made in a '
              'listing. Always ask the seller for supporting information.',
    },
    {
      'title': 'Physical Inspection Is Important',
      'description':
          'An image-based analysis cannot replace hands-on inspection or '
              'professional testing. Check the product personally, test its '
              'important functions, and consult a qualified technician when '
              'necessary.',
    },
  ];

  static const String _closing =
      'Always verify product details, ask the seller relevant questions, '
      'and inspect the item before purchasing. The final buying decision '
      'and responsibility remain yours. SHREWD AI is an informational '
      'assistant, not a guarantee of product quality or authenticity.';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppConstants.aiLimitationsTitle,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.screenHorizontalPadding,
          vertical: AppDesignTokens.screenVerticalPadding,
        ),
        children: [
          Container(
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
            child: Text(
              _intro,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingLarge),
          ..._limitationSections.map(
            (section) => Padding(
              padding: const EdgeInsets.only(
                bottom: AppDesignTokens.spacingRegular,
              ),
              child: _buildSection(
                context,
                title: section['title']!,
                description: section['description']!,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              AppDesignTokens.spacingRegular,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border.all(
                color: theme.colorScheme.primary,
                width: AppDesignTokens.borderWidthThin,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  PhosphorIconsRegular.info,
                  size: AppDesignTokens.iconSizeRegular,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(
                  width: AppDesignTokens.spacingRegular,
                ),
                Expanded(
                  child: Text(
                    _closing,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
                const SizedBox(height: AppDesignTokens.spacingLarge),

          const AppSectionDivider(),
           const SizedBox(height: AppDesignTokens.spacingLarge),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);

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
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingSmall),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
