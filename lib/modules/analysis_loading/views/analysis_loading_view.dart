
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/modules/analysis_loading/controllers/analysis_loading_controller.dart';
import 'package:shrewd_ai/modules/analysis_loading/widgets/analysis_loading_step.dart';

class AnalysisLoadingView extends GetView<AnalysisLoadingController> {
  const AnalysisLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.screenHorizontalPadding,
            vertical: AppDesignTokens.screenVerticalPadding,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppDesignTokens.spacingLarge),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SHREWD AI',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const Spacer(flex: 2),

              const _ScanningIndicator(),

              const SizedBox(height: AppDesignTokens.spacingXXLarge),

              Text(
                'Analyzing Product',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppDesignTokens.spacingSmall),

              Obx(
                () => Text(
                  controller.isProcessing.value
                      ? 'AI is reviewing your product'
                      : controller.isUploading.value
                          ? 'Uploading product images'
                          : 'Preparing your analysis',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),

              const SizedBox(height: AppDesignTokens.spacingXXLarge),

              Obx(() {
                final uploading = controller.isUploading.value;
                final processing = controller.isProcessing.value;
                final completed = controller.isCompleted.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          uploading
                              ? 'Upload progress'
                              : processing
                                  ? 'AI analysis'
                                  : completed
                                      ? 'Analysis completed'
                                      : 'Preparing request',
                          style: theme.textTheme.labelLarge,
                        ),
                        if (uploading || completed)
                          Text(
                            '${(controller.uploadProgress.value * 100).round()}%',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: accent,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        else if (processing)
                          Icon(
                            PhosphorIconsRegular.sparkle,
                            color: accent,
                            size: AppDesignTokens.iconSizeRegular,
                          ),
                      ],
                    ),

                    const SizedBox(height: AppDesignTokens.spacingSmall),

                    ClipRRect(
                      borderRadius: BorderRadius.zero,
                      child: LinearProgressIndicator(
                        value: uploading || completed
                            ? controller.uploadProgress.value
                            : null,
                        minHeight: 6,
                        backgroundColor: theme.dividerColor,
                        valueColor: AlwaysStoppedAnimation<Color>(accent),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: AppDesignTokens.spacingXXLarge),

              Obx(
                () => Column(
                  children: [
                    AnalysisLoadingStep(
                      title: 'Preparing product details',
                      icon: PhosphorIconsRegular.fileText,
                      isCompleted: controller.currentStage.value > 0,
                      isActive: controller.currentStage.value == 0,
                    ),
                    AnalysisLoadingStep(
                      title: 'Uploading product images',
                      icon: PhosphorIconsRegular.cloudArrowUp,
                      isCompleted: controller.currentStage.value > 1,
                      isActive: controller.currentStage.value == 1,
                    ),
                    AnalysisLoadingStep(
                      title: 'Generating AI report',
                      icon: PhosphorIconsRegular.sparkle,
                      isCompleted: controller.isCompleted.value,
                      isActive: controller.currentStage.value == 2,
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScanningIndicator extends StatefulWidget {
  const _ScanningIndicator();

  @override
  State<_ScanningIndicator> createState() => _ScanningIndicatorState();
}

class _ScanningIndicatorState extends State<_ScanningIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animationController.value * 6.28318,
          child: Container(
            width: 112,
            height: 112,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: accent.withValues(alpha: 0.22),
                width: 2,
              ),
            ),
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              value: 0.72,
              color: accent,
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}
