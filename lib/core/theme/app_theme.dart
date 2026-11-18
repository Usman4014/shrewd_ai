import 'package:material_ui/material_ui.dart';
import 'app_colors.dart';
import 'app_design_tokens.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  // ==========================================
  // DEFAULT THEME
  // ==========================================

  static ThemeMode defaultThemeMode = ThemeMode.dark;

  // ==========================================
  // DARK THEME
  // ==========================================

  static ThemeData darkTheme = _buildTheme(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackgroundPrimary,
    backgroundColor: AppColors.darkBackgroundSecondary,
    surfaceColor: AppColors.darkSurfacePrimary,
    secondarySurfaceColor: AppColors.darkSurfaceSecondary,
    primaryTextColor: AppColors.darkTextPrimary,
    secondaryTextColor: AppColors.darkTextSecondary,
    disabledTextColor: AppColors.darkTextDisabled,
    borderColor: AppColors.darkBorder,
    dividerColor: AppColors.darkDivider,
    primaryButtonColor: AppColors.darkPrimaryButton,
    primaryButtonTextColor: AppColors.darkPrimaryButtonText,
    accentColor: AppColors.darkAccent,
    textTheme: AppTextTheme.darkTextTheme,
  );

  // ==========================================
  // LIGHT THEME
  // ==========================================

  static ThemeData lightTheme = _buildTheme(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackgroundPrimary,
    backgroundColor: AppColors.lightBackgroundSecondary,
    surfaceColor: AppColors.lightSurfacePrimary,
    secondarySurfaceColor: AppColors.lightSurfaceSecondary,
    primaryTextColor: AppColors.lightTextPrimary,
    secondaryTextColor: AppColors.lightTextSecondary,
    disabledTextColor: AppColors.lightTextDisabled,
    borderColor: AppColors.lightBorder,
    dividerColor: AppColors.lightDivider,
    primaryButtonColor: AppColors.lightPrimaryButton,
    primaryButtonTextColor: AppColors.lightPrimaryButtonText,
    accentColor: AppColors.lightAccent,
    textTheme: AppTextTheme.lightTextTheme,
  );

  // ==========================================
  // COMMON THEME BUILDER
  // ==========================================

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color scaffoldBackgroundColor,
    required Color backgroundColor,
    required Color surfaceColor,
    required Color secondarySurfaceColor,
    required Color primaryTextColor,
    required Color secondaryTextColor,
    required Color disabledTextColor,
    required Color borderColor,
    required Color dividerColor,
    required Color primaryButtonColor,
    required Color primaryButtonTextColor,
    required Color accentColor,
    required TextTheme textTheme,
  }) {

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: accentColor,
      onPrimary: primaryButtonTextColor,
      secondary: accentColor,
      onSecondary: primaryButtonTextColor,
      error: const Color(0xFFDC5252),
      onError: const Color(0xFFFFFFFF),
      surface: surfaceColor,
      onSurface: primaryTextColor,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: scaffoldBackgroundColor,
      cardColor: surfaceColor,
      dividerColor: dividerColor,
      disabledColor: disabledTextColor,
      fontFamily: AppTextTheme.fontFamily,
      textTheme: textTheme,

      // ========================================
      // GLOBAL SHAPE
      // ========================================

      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),

      // ========================================
      // APP BAR
      // ========================================

      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: primaryTextColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(
          color: primaryTextColor,
          size: AppDesignTokens.iconSizeRegular,
        ),
      ),

      // ========================================
      // ELEVATED BUTTON
      // ========================================

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryButtonColor,
          foregroundColor: primaryButtonTextColor,
          disabledBackgroundColor: disabledTextColor,
          disabledForegroundColor: scaffoldBackgroundColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.spacingLarge,
            vertical: AppDesignTokens.spacingRegular,
          ),
          minimumSize: const Size(
            double.infinity,
            AppDesignTokens.buttonHeightMedium,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ========================================
      // OUTLINED BUTTON
      // ========================================

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryTextColor,
          side: BorderSide(color: borderColor),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.spacingLarge,
            vertical: AppDesignTokens.spacingRegular,
          ),
          minimumSize: const Size(
            double.infinity,
            AppDesignTokens.buttonHeightMedium,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ========================================
      // TEXT BUTTON
      // ========================================

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ========================================
      // INPUT DECORATION
      // ========================================

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondarySurfaceColor,
        contentPadding: const EdgeInsets.all(
          AppDesignTokens.inputContentPadding,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: secondaryTextColor,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: secondaryTextColor,
        ),
        floatingLabelStyle: textTheme.labelMedium?.copyWith(
          color: accentColor,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.error,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: accentColor,
            width: AppDesignTokens.borderWidthMedium,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: colorScheme.error,
            width: AppDesignTokens.borderWidthMedium,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: disabledTextColor),
        ),
      ),

      // ========================================
      // DIVIDER
      // ========================================

      dividerTheme: DividerThemeData(
        color: dividerColor,
        thickness: AppDesignTokens.borderWidthThin,
        space: AppDesignTokens.spacingRegular,
      ),

      // ========================================
      // DIALOG
      // ========================================

      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),

      // ========================================
      // BOTTOM SHEET
      // ========================================

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceColor,
        modalBackgroundColor: surfaceColor,
        elevation: 0,
        modalElevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),

      // ========================================
      // BOTTOM NAVIGATION
      // ========================================

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        indicatorColor: accentColor.withValues(alpha: 0.15),
        elevation: 0,
        height: 64,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) {
            final selected = states.contains(WidgetState.selected);

            return textTheme.labelSmall?.copyWith(
              color: selected ? accentColor : secondaryTextColor,
            );
          },
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) {
            final selected = states.contains(WidgetState.selected);

            return IconThemeData(
              color: selected ? accentColor : secondaryTextColor,
              size: AppDesignTokens.iconSizeRegular,
            );
          },
        ),
      ),

      // ========================================
      // CHECKBOX
      // ========================================

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? accentColor
              : Colors.transparent,
        ),
        checkColor: WidgetStateProperty.all(
          primaryButtonTextColor,
        ),
        side: BorderSide(color: borderColor),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),

      // ========================================
      // SWITCH
      // ========================================

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? accentColor
              : secondaryTextColor,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? accentColor.withValues(alpha: 0.25)
              : secondarySurfaceColor,
        ),
        trackOutlineColor: WidgetStateProperty.all(borderColor),
      ),

      // ========================================
      // RADIO
      // ========================================

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? accentColor
              : secondaryTextColor,
        ),
      ),

      // ========================================
      // SNACKBAR
      // ========================================

      snackBarTheme: SnackBarThemeData(
        backgroundColor: secondarySurfaceColor,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: primaryTextColor,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),

      // ========================================
      // PROGRESS INDICATOR
      // ========================================

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: accentColor,
        linearTrackColor: dividerColor,
        circularTrackColor: dividerColor,
      ),

      // ========================================
      // ICON THEME
      // ========================================

      iconTheme: IconThemeData(
        color: primaryTextColor,
        size: AppDesignTokens.iconSizeRegular,
      ),

      // ========================================
      // SELECTION
      // ========================================

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accentColor,
        selectionColor: accentColor.withValues(alpha: 0.25),
        selectionHandleColor: accentColor,
      ),

      // ========================================
      // TOOLTIP
      // ========================================

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: secondarySurfaceColor,
          borderRadius: BorderRadius.zero,
          border: Border.all(color: borderColor),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: primaryTextColor,
        ),
      ),

      // ========================================
      // DROPDOWN
      // ========================================

      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(surfaceColor),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          side: WidgetStateProperty.all(
            BorderSide(color: borderColor),
          ),
        ),
      ),

      // ========================================
      // LIST TILE
      // ========================================

      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        textColor: primaryTextColor,
        iconColor: secondaryTextColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.spacingRegular,
        ),
      ),

      // ========================================
      // MATERIAL
      // ========================================

      materialTapTargetSize: MaterialTapTargetSize.padded,
      splashFactory: InkRipple.splashFactory,
      hoverColor: accentColor.withValues(alpha: 0.05),
      highlightColor: accentColor.withValues(alpha: 0.08),
    );
  }
}
