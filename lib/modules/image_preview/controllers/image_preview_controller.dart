import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';
class ImagePreviewController extends GetxController {
  final RxList<XFile> images = <XFile>[].obs;
  final RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments == null) return;

    final receivedImages = arguments['images'];

    if (receivedImages is List<XFile>) {
      images.assignAll(receivedImages);
    }

    final initialIndex = arguments['initialIndex'];

    if (initialIndex is int && images.isNotEmpty) {
      currentIndex.value = initialIndex.clamp(0, images.length - 1);
    }
  }

  void changeImage(int index) {
    if (index >= 0 && index < images.length) {
      currentIndex.value = index;
    }
  }

  void removeCurrentImage() {
  if (images.isEmpty) return;

  images.removeAt(currentIndex.value);

  if (images.isEmpty) {
    closePreview();
    return;
  }

  if (currentIndex.value >= images.length) {
    currentIndex.value = images.length - 1;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (pageController.hasClients) {
      pageController.jumpToPage(currentIndex.value);
    }
  });
}

@override
void onClose() {
  pageController.dispose();
  super.onClose();
}

  void closePreview() {
    Get.back<List<XFile>>(result: images.toList());
  }
}