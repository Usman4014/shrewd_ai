import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/modules/image_preview/controllers/image_preview_controller.dart';
import 'package:shrewd_ai/modules/image_preview/widgets/image_action_bar.dart';
import 'package:shrewd_ai/modules/image_preview/widgets/preview_image_card.dart';

class ImagePreviewView extends GetView<ImagePreviewController> {
  const ImagePreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.images.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              ImageActionBar(
                currentIndex: controller.currentIndex.value,
                totalImages: controller.images.length,
                onClose: controller.closePreview,
                onDelete: controller.removeCurrentImage,
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: controller.images.length,
                  controller: controller.pageController,
                  onPageChanged: controller.changeImage,
                  itemBuilder: (context, index) {
  final image = controller.images[index];

  return PreviewImageCard(
    image: image,
    heroTag: 'product-image-${image.path}',
  );
},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Swipe to view photos',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}