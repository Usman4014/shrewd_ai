
import 'package:flutter/animation.dart';

class AppMotionTokens {
  AppMotionTokens._();

  // ==========================================
  // DURATIONS
  // ==========================================

  static const Duration standard =
      Duration(milliseconds: 350);

  static const Duration containerTransform =
      Duration(milliseconds: 450);

  static const Duration sharedAxis =
      Duration(milliseconds: 350);

  static const Duration fadeThrough =
      Duration(milliseconds: 300);

  static const Duration fade =
      Duration(milliseconds: 200);

  // ==========================================
  // CURVES
  // ==========================================

  static const Curve standardCurve = Curves.easeInOut;

  static const Curve emphasizedCurve =
      Curves.easeInOutCubic;
    
}
