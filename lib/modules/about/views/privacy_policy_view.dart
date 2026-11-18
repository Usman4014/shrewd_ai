import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/shared/widgets/app_section_divider.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  static const String _intro =
      'SHREWD AI respects your privacy. This Privacy Policy explains '
      'what information is processed when you use the app, how product '
      'images and details are used for AI analysis, and how your analysis '
      'history and app settings are stored.';

  static const List<Map<String, String>> _privacyPolicySections = [
    {
      'title': '1. Account and Personal Information',
      'description':
          'SHREWD AI does not require you to create an account or sign up '
          'to use its core features. The product analysis process shown '
          'in the app does not ask for your name, email address, or '
          'password. You provide product-related information when '
          'requesting an analysis.',
    },
    {
      'title': '2. Product Information We Process',
      'description':
          'When you request an analysis, the app processes the product '
          'category, subcategory, product name, optional model, asking '
          'price, currency, seller-reported condition, and optional '
          'seller description. This information is sent to our backend '
          'to generate your analysis report.',
    },
    {
      'title': '3. Product Images',
      'description':
          'You can select up to five product images for an analysis. '
          'Supported image formats are JPEG, PNG, and WebP. Images are '
          'sent to our backend as part of your analysis request and '
          'forwarded to Google Gemini for image-based analysis. Avoid '
          'uploading images containing personal, financial, or other '
          'sensitive information that is not necessary for product '
          'evaluation.',
    },
    {
      'title': '4. AI Processing and Third-Party Services',
      'description':
          'SHREWD AI uses Google Gemini to generate product analysis '
          'reports. Product information and uploaded images are sent '
          'through our backend to the Gemini API for processing. '
          'Google processes this information under its own applicable '
          'terms and privacy policies. We do not control Google’s '
          'independent data handling or retention practices.',
    },
    {
      'title': '5. Local Storage on Your Device',
      'description':
          'Your analysis reports and app settings are stored locally on '
          'your device using Hive storage. This includes saved analysis '
          'history and preferences such as your selected theme and '
          'other app settings. The local storage implementation does '
          'not itself upload your saved history to our backend.',
    },
    {
      'title': '6. Analysis History and Deletion',
      'description':
          'You can delete individual saved analyses or clear your entire '
          'analysis history using the available app functionality. '
          'These actions remove the corresponding records from the '
          'app’s local Hive storage. They do not constitute a request '
          'to delete information that may have been processed or '
          'retained independently by Google or infrastructure providers.',
    },
    {
      'title': '7. Data Retention',
      'description':
          'Saved analysis reports remain in local app storage until you '
          'delete them or the app data is otherwise removed. The '
          'backend analysis code processes submitted information and '
          'returns a report; the code reviewed does not show a database '
          'that permanently stores submitted product details or images. '
          'However, infrastructure logs and third-party service '
          'retention may be governed by their respective providers.',
    },
    {
      'title': '8. Data Sharing',
      'description':
          'Product details and images are shared with our backend and '
          'Google Gemini as necessary to provide the requested AI '
          'analysis. We do not sell your product information or images. '
          'Other handling by infrastructure and service providers is '
          'subject to their applicable terms and policies.',
    },
    {
      'title': '9. Data Security',
      'description':
          'We use a backend API to handle analysis requests and process '
          'them through the AI service. No method of electronic '
          'transmission or storage can be guaranteed to be completely '
          'secure. Please avoid submitting sensitive personal '
          'information or content that is unrelated to product analysis.',
    },
    {
      'title': '10. Your Choices',
      'description':
          'You choose which product details and images to submit for '
          'analysis. You can also manage your saved analysis history '
          'through the app. You may stop using the AI analysis feature '
          'at any time if you do not wish to send product information '
          'and images for processing.',
    },
    {
      'title': '11. Changes to This Privacy Policy',
      'description':
          'This Privacy Policy may be updated when app features, data '
          'processing practices, or applicable requirements change. '
          'Any revised version will be made available through the app. '
          'Please review this page periodically for updates.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppConstants.privacyPolicyTitle,
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
            padding: const EdgeInsets.all(AppDesignTokens.spacingRegular),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border.all(
                color: theme.dividerColor,
                width: AppDesignTokens.borderWidthThin,
              ),
            ),
            child: Text(_intro, style: theme.textTheme.bodyMedium),
          ),
          const SizedBox(height: AppDesignTokens.spacingLarge),
          ..._privacyPolicySections.map(
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
      padding: const EdgeInsets.all(AppDesignTokens.spacingRegular),
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
