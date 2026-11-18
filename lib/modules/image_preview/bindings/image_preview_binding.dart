import 'package:get/get.dart';
import 'package:shrewd_ai/modules/image_preview/controllers/image_preview_controller.dart';

class ImagePreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagePreviewController>(
      () => ImagePreviewController(),
    );
  }
}