
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/shared/widgets/app_section_divider.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  static const String _intro =
      'Welcome to SHREWD AI. These Terms and Conditions govern your use '
      'of the SHREWD AI application. By accessing or using the app, you '
      'agree to these terms. Please read them carefully before using '
      'our services.';

  static const List<Map<String, String>> _termsSections = [
    {
      'title': '1. Purpose of the Application',
      'description':
          'SHREWD AI is an AI-powered second-hand product analysis '
              'assistant designed to help users evaluate pre-owned products '
              'through uploaded images and product information. It provides '
              'observations, potential concerns, seller questions, inspection '
              'guidance, price considerations, and buying recommendations.',
    },
    {
      'title': '2. Eligibility and App Usage',
      'description':
          'You may use SHREWD AI for lawful, personal, and informational '
              'purposes. The app does not require account registration for '
              'its core functionality. You are responsible for ensuring '
              'that your use of the application complies with applicable '
              'laws and regulations.',
    },
    {
      'title': '3. User-Provided Information',
      'description':
          'You are responsible for the accuracy and relevance of the '
              'product information and images you submit. You should only '
              'upload images and content that you have the right to use. '
              'Do not submit unlawful, misleading, harmful, or sensitive '
              'personal information unrelated to product analysis.',
    },
    {
      'title': '4. AI-Generated Analysis',
      'description':
          'SHREWD AI uses artificial intelligence to generate product '
              'analysis reports. AI-generated observations and '
              'recommendations may be incomplete, inaccurate, or '
              'inconsistent. Results are provided for general informational '
              'guidance and should not be treated as verified facts or '
              'professional advice.',
    },
    {
      'title': '5. No Authenticity or Quality Guarantee',
      'description':
          'SHREWD AI does not guarantee product authenticity, originality, '
              'safety, quality, functionality, condition, or seller '
              'reliability. Image-based analysis cannot identify every '
              'hidden defect or internal problem. You should independently '
              'verify important product details and inspect the item '
              'before purchasing.',
    },
    {
      'title': '6. Price Considerations and Buying Decisions',
      'description':
          'Price considerations and buying recommendations are estimates '
              'generated from the information available in your request. '
              'They are not guaranteed market valuations or financial '
              'advice. SHREWD AI does not buy, sell, broker, or guarantee '
              'transactions between buyers and sellers. All purchasing '
              'decisions are your responsibility.',
    },
    {
      'title': '7. Third-Party Services',
      'description':
          'The application uses third-party services, including Google '
              'Gemini, to process product information and images and '
              'generate analysis reports. Your use of features involving '
              'third-party services may also be subject to their applicable '
              'terms, policies, and conditions.',
    },
    {
      'title': '8. Analysis History and App Settings',
      'description':
          'SHREWD AI provides local storage for saved analysis reports '
              'and app preferences. You can delete individual saved '
              'analyses or clear your analysis history through the app. '
              'Removing local history does not necessarily delete '
              'information processed independently by third-party services.',
    },
    {
      'title': '9. Acceptable Use',
      'description':
          'You agree not to misuse the application, interfere with its '
              'operation, attempt unauthorized access to its backend or '
              'services, reverse engineer or exploit its infrastructure, '
              'or use the app for unlawful activities. We may restrict '
              'access to functionality where necessary to protect the '
              'application and its services.',
    },
    {
      'title': '10. Availability and Changes',
      'description':
          'We aim to keep SHREWD AI available and functioning properly, '
              'but uninterrupted availability is not guaranteed. Features, '
              'AI models, services, or functionality may be updated, '
              'modified, suspended, or discontinued when necessary.',
    },
    {
      'title': '11. Limitation of Responsibility',
      'description':
          'To the extent permitted by applicable law, SHREWD AI and its '
              'developers are not responsible for purchasing decisions, '
              'financial losses, product defects, inaccurate seller claims, '
              'or disputes arising from reliance on AI-generated analysis. '
              'You remain responsible for independently evaluating products '
              'and verifying information before making a purchase.',
    },
    {
      'title': '12. Privacy',
      'description':
          'Your use of SHREWD AI is also governed by our Privacy Policy, '
              'which explains how product information, uploaded images, '
              'analysis history, and app settings are processed and stored. '
              'Please review the Privacy Policy to understand our data '
              'handling practices.',
    },
    {
      'title': '13. Updates to These Terms',
      'description':
          'These Terms and Conditions may be revised when application '
              'features, services, or applicable requirements change. '
              'Updated terms will be made available through the app. '
              'Continued use of SHREWD AI after updated terms are made '
              'available constitutes acceptance of the revised terms '
              'to the extent permitted by applicable law.',
    },
  ];

  static const String _closing =
      'By using SHREWD AI, you acknowledge that AI-generated analysis '
      'is informational guidance only. Always verify product details, '
      'ask relevant questions, and inspect products independently '
      'before making a purchasing decision.';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppConstants.termsTitle,
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
          ..._termsSections.map(
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
                color: theme.dividerColor,
                width: AppDesignTokens.borderWidthThin,
              ),
            ),
            child: Text(
              _closing,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
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
