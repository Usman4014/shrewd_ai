
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/app/bindings/initial_binding.dart';
import 'package:shrewd_ai/app/routes/app_pages.dart';
import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_theme.dart';

class ShrewdAiApp extends StatelessWidget {
  const ShrewdAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // APP CONFIGURATION
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // INITIALIZATION
      initialBinding: InitialBinding(),

      // ROUTING
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 350),

      // THEMING
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppTheme.defaultThemeMode,

      // STATUS BAR
      builder: (context, child) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: theme.scaffoldBackgroundColor,
            statusBarIconBrightness: isDark
                ? Brightness.light
                : Brightness.dark,
            statusBarBrightness: isDark
                ? Brightness.dark
                : Brightness.light,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
