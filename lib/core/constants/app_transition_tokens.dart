
import 'package:get/get.dart';

class AppTransitionTokens {
  AppTransitionTokens._();

  static const Transition splashTransition =
      Transition.leftToRightWithFade;

  static const Transition pageTransition =
      Transition.rightToLeftWithFade;

  static const Transition rootTransition =
      Transition.fadeIn;

  static const Duration transitionDuration =
      Duration(milliseconds: 350);
}
