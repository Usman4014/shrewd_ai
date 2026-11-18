import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static const String fontFamily = 'Manrope';

  // ==========================================
  // DARK TEXT THEME
  // ==========================================

  static TextTheme darkTextTheme = _buildTextTheme(
    primaryColor: AppColors.darkTextPrimary,
    secondaryColor: AppColors.darkTextSecondary,
    disabledColor: AppColors.darkTextDisabled,
  );

  // ==========================================
  // LIGHT TEXT THEME
  // ==========================================

  static TextTheme lightTextTheme = _buildTextTheme(
    primaryColor: AppColors.lightTextPrimary,
    secondaryColor: AppColors.lightTextSecondary,
    disabledColor: AppColors.lightTextDisabled,
  );

  // ==========================================
  // TEXT THEME BUILDER
  // ==========================================

  static TextTheme _buildTextTheme({
    required Color primaryColor,
    required Color secondaryColor,
    required Color disabledColor,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        height: 1.25,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        height: 1.3,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        height: 1.3,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        height: 1.35,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        height: 1.4,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        height: 1.4,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        height: 1.4,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryColor,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: secondaryColor,
        height: 1.4,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: disabledColor,
        height: 1.4,
      ),
    );
  }

}
