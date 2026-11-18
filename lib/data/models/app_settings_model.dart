class AppSettingsModel {
  final String? currencyPreference;
  final String? languagePreference;
  final String themeMode;

  const AppSettingsModel({
    this.currencyPreference,
    this.languagePreference,
    this.themeMode = 'dark',
  });
}