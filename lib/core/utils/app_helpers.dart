import 'package:material_ui/material_ui.dart';

class AppHelpers {
  AppHelpers._();

  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}