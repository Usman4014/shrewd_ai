import 'package:hive_ce_flutter/hive_flutter.dart';

class StorageService {
  StorageService._();

  static Future<void> init() async {
    await Hive.initFlutter();
  }
}