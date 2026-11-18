
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/app/routes/app_routes.dart';
import 'package:shrewd_ai/core/theme/app_theme.dart';
import 'package:shrewd_ai/data/repositories/settings_repository.dart';
import 'package:shrewd_ai/shared/enums/app_theme_mode.dart';

class SettingsController extends GetxController {
  final SettingsRepository _settingsRepository =
      Get.find<SettingsRepository>();

  final RxString currencyPreference = ''.obs;
  final RxString languagePreference = ''.obs;
  final Rx<AppThemeMode> selectedTheme = AppThemeMode.dark.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    final settings = _settingsRepository.getSettings();

    currencyPreference.value =
        settings.currencyPreference ?? '';

    languagePreference.value =
        settings.languagePreference ?? '';

    selectedTheme.value =
        AppThemeMode.fromValue(settings.themeMode);
  }

  Future<void> changeTheme(AppThemeMode mode) async {
    selectedTheme.value = mode;

    final themeMode = mode == AppThemeMode.dark
        ? ThemeMode.dark
        : ThemeMode.light;

    AppTheme.defaultThemeMode = themeMode;
    Get.changeThemeMode(themeMode);

    await _settingsRepository.saveThemeMode(mode.value);
  }

  Future<void> changeCurrency(String currency) async {
    currencyPreference.value = currency;

    await _settingsRepository.saveCurrencyPreference(currency);
  }

  Future<void> changeLanguage(String language) async {
    languagePreference.value = language;

    await _settingsRepository.saveLanguagePreference(language);
  }

  // About Navigation

  void openAbout() {
    Get.toNamed(AppRoutes.about);
  }

  void openAiLimitations() {
    Get.toNamed(AppRoutes.aiLimitations);
  }

  void openPrivacyPolicy() {
    Get.toNamed(AppRoutes.privacyPolicy);
  }

  void openTerms() {
    Get.toNamed(AppRoutes.terms);
  }
}
