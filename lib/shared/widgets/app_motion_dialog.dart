
import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/theme/app_motion_tokens.dart';

class AppMotionDialog {
  AppMotionDialog._();

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel:
          MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: AppMotionTokens.fade,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Builder(builder: builder);
      },
      transitionBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return FadeScaleTransition(
          animation: animation,
          child: child,
        );
      },
    );
  }
}
