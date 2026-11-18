
enum AppThemeMode {
  dark,
  light;

  String get value => name;

  static AppThemeMode fromValue(String? value) {
    return AppThemeMode.values.firstWhere(
      (mode) => mode.value == value,
      orElse: () => AppThemeMode.dark,
    );
  }
}
