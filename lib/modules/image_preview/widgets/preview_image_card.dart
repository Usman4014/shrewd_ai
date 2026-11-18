
import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

class PreviewImageCard extends StatelessWidget {
  final XFile image;
  final String heroTag;

  const PreviewImageCard({
    super.key,
    required this.image,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 0.8,
      maxScale: 4,
      child: Center(
        child: Hero(
          tag: heroTag,
          child: Image.file(
            File(image.path),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                PhosphorIconsRegular.imageBroken,
                size: 64,
              );
            },
          ),
        ),
      ),
    );
  }
}
