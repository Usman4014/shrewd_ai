import 'package:shrewd_ai/core/constants/app_constants.dart';

class ImageHelper {
  ImageHelper._();

  static bool canAddMoreImages(int currentImageCount) {
    return currentImageCount < AppConstants.maxProductImages;
  }

  static int remainingImageSlots(int currentImageCount) {
    final remaining = AppConstants.maxProductImages - currentImageCount;

    return remaining.clamp(0, AppConstants.maxProductImages);
  }
}