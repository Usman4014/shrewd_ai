
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/theme/app_colors.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class AppSectionDivider extends StatefulWidget {
  const AppSectionDivider({
    super.key,
  });

  @override
  State<AppSectionDivider> createState() => _AppSectionDividerState();
}

class _AppSectionDividerState extends State<AppSectionDivider>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDesignTokens.spacingLarge,
      ),
      child: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.68,
          height: AppDesignTokens.spacingLarge,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: _SectionDividerPainter(
                  progress: _animation.value,
                 color: Theme.of(context).brightness == Brightness.dark
    ? AppColors.darkAccent
    : AppColors.lightAccent,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SectionDividerPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _SectionDividerPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    const dotRadius = 2.0;
    const dotGap = 9.0;

    final halfWidth = (size.width - dotGap * 2) / 2;
    final animatedWidth = halfWidth * progress;

    final leftDotPaint = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;

    final rightDotPaint = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(dotRadius, centerY),
      dotRadius,
      leftDotPaint,
    );

    canvas.drawCircle(
      Offset(size.width - dotRadius, centerY),
      dotRadius,
      rightDotPaint,
    );

    final lineStart = dotRadius * 2 + dotGap;
    final lineEnd = size.width - lineStart;

    final leftStart = centerX;
    final leftEnd = leftStart - animatedWidth;

    final rightStart = centerX;
    final rightEnd = rightStart + animatedWidth;

    final linePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.95),
          color.withValues(alpha: 0.08),
        ],
      ).createShader(
        Rect.fromLTWH(
          lineStart,
          centerY,
          lineEnd - lineStart,
          1,
        ),
      )
      ..strokeCap = StrokeCap.round;

    final thickness = 1.0 + (2.0 * progress);

    linePaint.strokeWidth = thickness;

    canvas.drawLine(
      Offset(leftStart, centerY),
      Offset(leftEnd, centerY),
      linePaint,
    );

    canvas.drawLine(
      Offset(rightStart, centerY),
      Offset(rightEnd, centerY),
      linePaint,
    );

    final centerPaint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(centerX - 5, centerY),
      Offset(centerX + 5, centerY),
      centerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SectionDividerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color;
  }
}
