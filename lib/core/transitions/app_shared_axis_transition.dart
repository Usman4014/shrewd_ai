
import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/core/theme/app_motion_tokens.dart';

class AppSharedAxisTransition extends CustomTransition {
  final SharedAxisTransitionType transitionType;

  AppSharedAxisTransition({
    this.transitionType = SharedAxisTransitionType.horizontal,
  });

  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SharedAxisTransition(
      animation: CurvedAnimation(
        parent: animation,
        curve: AppMotionTokens.standardCurve,
      ),
      secondaryAnimation: CurvedAnimation(
        parent: secondaryAnimation,
        curve: AppMotionTokens.standardCurve,
      ),
      transitionType: transitionType,
      fillColor: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }
}
