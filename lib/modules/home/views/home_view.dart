import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/core/theme/app_motion_tokens.dart';

import 'package:shrewd_ai/modules/product_analysis/controllers/product_analysis_controller.dart';
import 'package:shrewd_ai/modules/product_analysis/views/product_analysis_view.dart';
import 'package:shrewd_ai/shared/widgets/app_section_divider.dart';

import '../controllers/home_controller.dart';
import '../widgets/analyze_product_card.dart';
import '../widgets/home_header.dart';
import '../widgets/how_it_works_section.dart';
import '../widgets/recent_analyses_section.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: theme.colorScheme.primary,
          backgroundColor: theme.colorScheme.surface,
          onRefresh: controller.refreshHome,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignTokens.screenHorizontalPadding,
              vertical: AppDesignTokens.screenVerticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeader(),

                const SizedBox(height: AppDesignTokens.homeHeaderSpacing),

                OpenContainer<void>(
                  transitionDuration: AppMotionTokens.containerTransform,
                  closedElevation: 0,
                  openElevation: 0,
                  closedColor: theme.scaffoldBackgroundColor,
                  openColor: theme.scaffoldBackgroundColor,
                  middleColor: theme.scaffoldBackgroundColor,
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDesignTokens.borderRadiusNone,
                    ),
                  ),
                  openShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDesignTokens.borderRadiusNone,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  tappable: false,
                  useRootNavigator: true,
                  onClosed: (_) {
                    if (Get.isRegistered<ProductAnalysisController>()) {
                      Get.delete<ProductAnalysisController>(force: true);
                    }
                  },
                  closedBuilder: (context, openContainer) {
                    return AnalyzeProductCard(onPressed: openContainer);
                  },
                  openBuilder: (context, closeContainer) {
                    Get.put<ProductAnalysisController>(
                      ProductAnalysisController(),
                      permanent: true,
                    );

                    return const ProductAnalysisView();
                  },
                ),

                const SizedBox(height: AppDesignTokens.homeSectionSpacing),
                const AppSectionDivider(),

                Obx(
                  () => RecentAnalysesSection(
                    latestAnalysis: controller.latestAnalysis.value,
                    onViewHistory: controller.openHistory,
                  ),
                ),

                const SizedBox(height: AppDesignTokens.homeSectionSpacing),
                 const AppSectionDivider(),

                const HowItWorksSection(),
                  const SizedBox(height: AppDesignTokens.homeSectionSpacing),
                 const AppSectionDivider(),

               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
