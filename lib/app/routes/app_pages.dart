
import 'package:animations/animations.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/app/routes/app_routes.dart';
import 'package:shrewd_ai/core/constants/app_transition_tokens.dart';
import 'package:shrewd_ai/core/theme/app_motion_tokens.dart';
import 'package:shrewd_ai/core/transitions/app_shared_axis_transition.dart';
import 'package:shrewd_ai/modules/about/bindings/about_binding.dart';
import 'package:shrewd_ai/modules/about/views/about_view.dart';
import 'package:shrewd_ai/modules/about/views/ai_limitations_view.dart';
import 'package:shrewd_ai/modules/about/views/privacy_policy_view.dart';
import 'package:shrewd_ai/modules/about/views/terms_view.dart';
import 'package:shrewd_ai/modules/product_comparison/bindings/product_comparison_binding.dart';
import 'package:shrewd_ai/modules/product_comparison/views/product_comparison_view.dart';
import 'package:shrewd_ai/modules/analysis_loading/bindings/analysis_loading_binding.dart';
import 'package:shrewd_ai/modules/analysis_loading/views/analysis_loading_view.dart';
import 'package:shrewd_ai/modules/analysis_result/bindings/analysis_result_binding.dart';
import 'package:shrewd_ai/modules/analysis_result/views/analysis_result_view.dart';
import 'package:shrewd_ai/modules/image_preview/bindings/image_preview_binding.dart';
import 'package:shrewd_ai/modules/image_preview/views/image_preview_view.dart';
import 'package:shrewd_ai/modules/history/bindings/history_binding.dart';
import 'package:shrewd_ai/modules/history/views/history_view.dart';
import 'package:shrewd_ai/modules/splash/bindings/splash_binding.dart';
import 'package:shrewd_ai/modules/splash/views/splash_view.dart';
import 'package:shrewd_ai/modules/home/bindings/home_binding.dart';
import 'package:shrewd_ai/modules/home/views/home_view.dart';
import 'package:shrewd_ai/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:shrewd_ai/modules/onboarding/views/onboarding_view.dart';
import 'package:shrewd_ai/modules/main/bindings/main_binding.dart';
import 'package:shrewd_ai/modules/main/views/main_view.dart';
import 'package:shrewd_ai/modules/product_analysis/bindings/product_analysis_binding.dart';
import 'package:shrewd_ai/modules/product_analysis/views/product_analysis_view.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: AppTransitionTokens.splashTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
      binding: MainBinding(),
      transition: AppTransitionTokens.rootTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: AppTransitionTokens.pageTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    GetPage(
      name: AppRoutes.productAnalysis,
      page: () => const ProductAnalysisView(),
      binding: ProductAnalysisBinding(),
      transition: AppTransitionTokens.pageTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    GetPage(
      name: AppRoutes.imagePreview,
      page: () => const ImagePreviewView(),
      binding: ImagePreviewBinding(),
      transition: AppTransitionTokens.pageTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    GetPage(
      name: AppRoutes.analysisLoading,
      page: () => const AnalysisLoadingView(),
      binding: AnalysisLoadingBinding(),
      transition: AppTransitionTokens.pageTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    GetPage(
  name: AppRoutes.analysisResult,
  page: () => const AnalysisResultView(),
  binding: AnalysisResultBinding(),
  customTransition: AppSharedAxisTransition(
    transitionType: SharedAxisTransitionType.horizontal,
  ),
  transitionDuration: AppMotionTokens.sharedAxis,
),

    // ABOUT & INFORMATION

    GetPage(
      name: AppRoutes.about,
      page: () => const AboutView(),
      binding: AboutBinding(),
      transition: AppTransitionTokens.pageTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    GetPage(
      name: AppRoutes.aiLimitations,
      page: () => const AiLimitationsView(),
      transition: AppTransitionTokens.pageTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicyView(),
      transition: AppTransitionTokens.pageTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    GetPage(
      name: AppRoutes.terms,
      page: () => const TermsView(),
      transition: AppTransitionTokens.pageTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    // HISTORY

    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
      transition: AppTransitionTokens.pageTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),

    // PRODUCT COMPARISON

    GetPage(
      name: AppRoutes.productComparison,
      page: () => const ProductComparisonView(),
      binding: ProductComparisonBinding(),
      transition: AppTransitionTokens.pageTransition,
      transitionDuration: AppTransitionTokens.transitionDuration,
    ),
  ];
}
