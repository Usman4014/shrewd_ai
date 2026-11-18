
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shrewd_ai/core/constants/app_constants.dart';

class ImageService {
  ImageService();

  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>> pickProductImages({
    int currentImageCount = 0,
  }) async {
    final remainingSlots =
        AppConstants.maxProductImages - currentImageCount;

    if (remainingSlots <= 0) return [];

    final selectedImages = await _picker.pickMultiImage();

    final imagesToProcess =
        selectedImages.take(remainingSlots).toList();

    final validImages = <XFile>[];

    for (int i = 0; i < imagesToProcess.length; i++) {
      final image = imagesToProcess[i];

      try {
        debugPrint('SHREWD AI: Validating ${image.name}');

        final originalFile = File(image.path);

        if (!await originalFile.exists()) {
          debugPrint('SHREWD AI: Image file does not exist');
          continue;
        }

        final originalBytes = await originalFile.readAsBytes();

        if (await _canDecodeImage(originalBytes)) {
          debugPrint('SHREWD AI: Original image is valid');
          validImages.add(image);
          continue;
        }

        debugPrint(
          'SHREWD AI: Original decoding failed. '
          'Trying native JPEG conversion.',
        );

        final convertedBytes =
            await FlutterImageCompress.compressWithFile(
          image.path,
          format: CompressFormat.jpeg,
          quality: 100,
          minWidth: 10000,
          minHeight: 10000,
          keepExif: true,
        );

        if (convertedBytes == null || convertedBytes.isEmpty) {
          debugPrint('SHREWD AI: Image conversion failed');
          continue;
        }

        if (!await _canDecodeImage(convertedBytes)) {
          debugPrint(
            'SHREWD AI: Converted image is also unreadable',
          );
          continue;
        }

        final tempDirectory =
            await Directory.systemTemp.createTemp(
          'shrewd_ai_images_',
        );

        final convertedFile = File(
          '${tempDirectory.path}/converted_$i.jpg',
        );

        await convertedFile.writeAsBytes(
          convertedBytes,
          flush: true,
        );

        debugPrint('SHREWD AI: Image converted successfully');

        validImages.add(
          XFile(convertedFile.path),
        );
      } catch (error, stackTrace) {
        debugPrint(
          'SHREWD AI: Image processing failed: $error',
        );
        debugPrintStack(stackTrace: stackTrace);
      }
    }

    debugPrint(
      'SHREWD AI: Successfully processed '
      '${validImages.length}/${imagesToProcess.length} images',
    );

    return validImages;
  }

  Future<bool> _canDecodeImage(Uint8List bytes) async {
    ui.Codec? codec;

    try {
      codec = await ui.instantiateImageCodec(bytes);

      final frame = await codec.getNextFrame();

      final isValid =
          frame.image.width > 0 && frame.image.height > 0;

      frame.image.dispose();

      return isValid;
    } catch (error) {
      debugPrint('SHREWD AI: Image decoding error: $error');
      return false;
    } finally {
      codec?.dispose();
    }
  }
}
