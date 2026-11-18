
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/shared/enums/app_theme_mode.dart';

class ThemeSelector extends StatelessWidget {
  final AppThemeMode selectedTheme;
  final ValueChanged<AppThemeMode> onChanged;

  const ThemeSelector({
    super.key,
    required this.selectedTheme,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<AppThemeMode>(
      initialValue: selectedTheme,
      decoration: const InputDecoration(
        labelText: 'App Theme',
      ),
      items: AppThemeMode.values.map((mode) {
        return DropdownMenuItem<AppThemeMode>(
          value: mode,
          child: Text(
            mode == AppThemeMode.dark ? 'Dark' : 'Light',
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      dropdownColor: theme.colorScheme.surface,
    );
  }
}
