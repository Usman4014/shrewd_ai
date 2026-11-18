import 'package:material_ui/material_ui.dart';

extension ContextExtensions on BuildContext {
  bool get isDarkMode =>
      Theme.of(this).brightness == Brightness.dark;
}