
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/app/app.dart';
import 'package:shrewd_ai/core/services/storage_service.dart';
import 'package:shrewd_ai/core/theme/app_theme.dart';
import 'package:shrewd_ai/data/providers/local_storage_provider.dart';
import 'package:shrewd_ai/data/repositories/settings_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INITIALIZE LOCAL STORAGE
  await StorageService.init();

  final storageProvider = LocalStorageProvider();
  await storageProvider.init();

  // REGISTER STORAGE PROVIDER
  Get.put<LocalStorageProvider>(
    storageProvider,
    permanent: true,
  );

  // LOAD SAVED SETTINGS
  final settingsRepository = SettingsRepository(
    storageProvider: storageProvider,
  );

  final savedSettings = settingsRepository.getSettings();

  // APPLY SAVED THEME
  AppTheme.defaultThemeMode =
      savedSettings.themeMode == 'light'
          ? ThemeMode.light
          : ThemeMode.dark;

  runApp(
    const ShrewdAiApp(),
  );
}
