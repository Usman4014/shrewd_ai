
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/theme/app_colors.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

enum _SnackbarType {
  success,
  error,
  warning,
  info,
}

class AppSnackbar {
  AppSnackbar._();

  static const Duration _duration = Duration(seconds: 3);

  static void success(String message) {
    _show(
      message: message,
      type: _SnackbarType.success,
    );
  }

  static void error(String message) {
    _show(
      message: message,
      type: _SnackbarType.error,
    );
  }

  static void warning(String message) {
    _show(
      message: message,
      type: _SnackbarType.warning,
    );
  }

  static void info(String message) {
    _show(
      message: message,
      type: _SnackbarType.info,
    );
  }

  static void _show({
    required String message,
    required _SnackbarType type,
  }) {
    final context = Get.context;

    if (context == null) return;

    final messenger = ScaffoldMessenger.maybeOf(context);

    if (messenger == null) return;

    final theme = Theme.of(context);

    final (icon, color) = switch (type) {
      _SnackbarType.success => (
          PhosphorIconsRegular.checkCircle,
          AppColors.success,
        ),
      _SnackbarType.error => (
          PhosphorIconsRegular.warningCircle,
          AppColors.error,
        ),
      _SnackbarType.warning => (
          PhosphorIconsRegular.warning,
          AppColors.warning,
        ),
      _SnackbarType.info => (
          PhosphorIconsRegular.info,
          AppColors.info,
        ),
    };

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: _duration,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: theme.colorScheme.surface,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.spacingRegular,
            vertical: AppDesignTokens.spacingRegular,
          ),
          margin: const EdgeInsets.all(
            AppDesignTokens.spacingRegular,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDesignTokens.borderRadiusNone,
            ),
            side: BorderSide(
              color: theme.colorScheme.outlineVariant,
              width: AppDesignTokens.borderWidthThin,
            ),
          ),
          content: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: AppDesignTokens.iconSizeMedium,
              ),
              const SizedBox(
                width: AppDesignTokens.spacingRegular,
              ),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
