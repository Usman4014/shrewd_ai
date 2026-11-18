
import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changeTab(int index) {
    if (index < 0 || index >= 4) return;

    selectedIndex.value = index;
  }
}
