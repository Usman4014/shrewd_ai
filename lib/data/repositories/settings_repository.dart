import 'package:shrewd_ai/core/constants/storage_constants.dart';
import 'package:shrewd_ai/data/models/app_settings_model.dart';
import 'package:shrewd_ai/data/providers/local_storage_provider.dart';

class SettingsRepository {
  final LocalStorageProvider _storageProvider;

  SettingsRepository({
    required this._storageProvider,
  });

  AppSettingsModel getSettings() {
    return AppSettingsModel(
      currencyPreference: _storageProvider.getSetting(
        StorageConstants.currencyPreference,
      ) as String?,
      languagePreference: _storageProvider.getSetting(
        StorageConstants.languagePreference,
      ) as String?,
      themeMode: _storageProvider.getSetting(
            StorageConstants.themeMode,
          ) as String? ??
          StorageConstants.defaultThemeMode,
    );
  }

  Future<void> saveCurrencyPreference(String currency) {
    return _storageProvider.saveSetting(
      key: StorageConstants.currencyPreference,
      value: currency,
    );
  }

  Future<void> saveLanguagePreference(String language) {
    return _storageProvider.saveSetting(
      key: StorageConstants.languagePreference,
      value: language,
    );
  }

  Future<void> saveThemeMode(String themeMode) {
    return _storageProvider.saveSetting(
      key: StorageConstants.themeMode,
      value: themeMode,
    );
  }

  Future<void> clearSettings() async {
    await _storageProvider.deleteSetting(
      StorageConstants.currencyPreference,
    );

    await _storageProvider.deleteSetting(
      StorageConstants.languagePreference,
    );

    await _storageProvider.deleteSetting(
      StorageConstants.themeMode,
    );
  }
}