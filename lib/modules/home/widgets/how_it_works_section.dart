import 'package:material_ui/material_ui.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'dart:math' as math;

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  static const double _stepCircleSize = 136;
  static const double _outerRingSize = 164;
  static const double _iconSize = 44;
  static const double _badgeSize = 40;
  static const double _connectorHeight = 64;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final goldColor = theme.colorScheme.primary;

    final steps = [
      (
        icon: PhosphorIconsRegular.cameraPlus,
        title: AppConstants.homeStepOneTitle,
        description: AppConstants.homeStepOneDescription,
      ),
      (
        icon: PhosphorIconsRegular.brain,
        title: AppConstants.homeStepTwoTitle,
        description: AppConstants.homeStepTwoDescription,
      ),
      (
        icon: PhosphorIconsRegular.sealCheck,
        title: AppConstants.homeStepThreeTitle,
        description: AppConstants.homeStepThreeDescription,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppDesignTokens.spacingLarge),

      

        

        Text(
          AppConstants.homeHowItWorksTitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
        ),

       const SizedBox(height: AppDesignTokens.spacingSmall),
          Text(
          '3 SIMPLE STEPS',
          textAlign: TextAlign.center,
          style: theme.textTheme.labelMedium?.copyWith(
            color: goldColor,
            fontWeight: FontWeight.w700,
            letterSpacing: 3,
          ),
        ),

        const SizedBox(height: AppDesignTokens.spacingXXLarge),

        ...List.generate(steps.length, (index) {
          final step = steps[index];

          return Column(
            children: [
              SizedBox(
                width: _outerRingSize,
                height: _outerRingSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(_outerRingSize, _outerRingSize),
                      painter: _DottedCirclePainter(
                        color: goldColor.withValues(alpha: 0.55),
                      ),
                    ),

                    Container(
                      width: _stepCircleSize,
                      height: _stepCircleSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: goldColor.withValues(alpha: 0.75),
                          width: AppDesignTokens.borderWidthThin,
                        ),
                        gradient: RadialGradient(
                          colors: [
                            goldColor.withValues(alpha: 0.12),
                            theme.colorScheme.surface.withValues(alpha: 0.15),
                          ],
                        ),
                      ),
                      child: Icon(step.icon, size: _iconSize, color: goldColor),
                    ),

                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: Container(
                        width: _badgeSize,
                        height: _badgeSize,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: goldColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.surface,
                            width: AppDesignTokens.borderWidthMedium,
                          ),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDesignTokens.spacingLarge),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDesignTokens.spacingRegular,
                ),
                child: Column(
                  children: [
                    Text(
                      step.title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: AppDesignTokens.spacingExtraSmall),

                    Text(
                      step.description,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: goldColor.withValues(alpha: 0.85),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              if (index != steps.length - 1) ...[
                const SizedBox(height: AppDesignTokens.spacingLarge),

                CustomPaint(
                  size: const Size(2, _connectorHeight),
                  painter: _DottedLinePainter(
                    color: goldColor.withValues(alpha: 0.55),
                  ),
                ),

                const SizedBox(height: AppDesignTokens.spacingLarge),
              ],
            ],
          );
        }),
      ],
    );
  }
}

class _DottedCirclePainter extends CustomPainter {
  final Color color;

  const _DottedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.width / 2 - 1;

    const dotCount = 72;

    for (int i = 0; i < dotCount; i++) {
      final angle = (i * 2 * 3.141592653589793) / dotCount;

      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      canvas.drawCircle(point, 1, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DottedCirclePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;

  const _DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;

    const dashHeight = 3.0;
    const gap = 4.0;

    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, (startY + dashHeight).clamp(0.0, size.height)),
        paint,
      );

      startY += dashHeight + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _DottedLinePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
