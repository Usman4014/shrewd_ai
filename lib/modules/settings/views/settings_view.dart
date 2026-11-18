import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/shared/widgets/app_section_divider.dart';

import '../controllers/settings_controller.dart';
import '../widgets/theme_selector.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppConstants.settingsTitle,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDesignTokens.screenHorizontalPadding,
                  vertical: AppDesignTokens.screenVerticalPadding,
                ),
                children: [
                  Text(
                    AppConstants.settingsAppearanceTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingRegular),
                  Obx(
                    () => ThemeSelector(
                      selectedTheme: controller.selectedTheme.value,
                      onChanged: controller.changeTheme,
                    ),
                  ),

                  const SizedBox(height: AppDesignTokens.spacingRegular),

                  _buildNavigationTile(
                    context: context,
                    icon: PhosphorIconsRegular.info,
                    title: AppConstants.aboutTitle,
                    onTap: controller.openAbout,
                  ),
                  _buildNavigationTile(
                    context: context,
                    icon: PhosphorIconsRegular.brain,
                    title: AppConstants.aboutLimitationsLabel,
                    onTap: controller.openAiLimitations,
                  ),
                  _buildNavigationTile(
                    context: context,
                    icon: PhosphorIconsRegular.shieldCheck,
                    title: AppConstants.aboutPrivacyLabel,
                    onTap: controller.openPrivacyPolicy,
                  ),
                  _buildNavigationTile(
                    context: context,
                    icon: PhosphorIconsRegular.fileText,
                    title: AppConstants.aboutTermsLabel,
                    onTap: controller.openTerms,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDesignTokens.screenHorizontalPadding,
              ),
              child: _buildAppFooter(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppFooter(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final packageInfo = snapshot.data;

        final version = packageInfo == null
            ? ''
            : 'Version ${packageInfo.version} '
                  '(${packageInfo.buildNumber})';

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppConstants.appName,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: AppDesignTokens.spacingExtraSmall),

            Text(
              'Smart Second-Hand Buying Assistant',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),

            const SizedBox(height: AppDesignTokens.spacingSmall),

            if (version.isNotEmpty)
              Text(
                version,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),

            const SizedBox(height: AppDesignTokens.spacingSmall),

            Text(
              '© ${DateTime.now().year} ${AppConstants.appName}. '
              'All rights reserved.',
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.disabledColor,
              ),
            ),
            const SizedBox(height: AppDesignTokens.homeSectionSpacing),

            const AppSectionDivider(),
          ],
        );
      },
    );
  }

  Widget _buildNavigationTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: theme.colorScheme.secondary,
        size: AppDesignTokens.iconSizeLarge,
      ),
      title: Text(title, style: theme.textTheme.bodyLarge),
      trailing: Icon(
        PhosphorIconsRegular.caretRight,
        size: AppDesignTokens.iconSizeExtraSmall,
        color: theme.colorScheme.secondary,
      ),
      onTap: onTap,
    );
  }
}
