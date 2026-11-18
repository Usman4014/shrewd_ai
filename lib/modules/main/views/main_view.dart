
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import 'package:shrewd_ai/core/theme/app_motion_tokens.dart';

import 'package:shrewd_ai/modules/home/views/home_view.dart';
import 'package:shrewd_ai/modules/product_comparison/views/product_comparison_view.dart';
import 'package:shrewd_ai/modules/history/views/history_view.dart';
import 'package:shrewd_ai/modules/settings/views/settings_view.dart';
import 'package:shrewd_ai/shared/widgets/app_bottom_navigation.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _MainTabContent(
          selectedIndex: controller.selectedIndex.value,
        ),
        bottomNavigationBar: AppBottomNavigation(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTab,
        ),
      ),
    );
  }
}

class _MainTabContent extends StatefulWidget {
  final int selectedIndex;

  const _MainTabContent({
    required this.selectedIndex,
  });

  @override
  State<_MainTabContent> createState() => _MainTabContentState();
}

class _MainTabContentState extends State<_MainTabContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<double> _outgoingOpacity;
  late final Animation<double> _incomingOpacity;

  late final Animation<double> _outgoingScale;
  late final Animation<double> _incomingScale;

  int? _previousIndex;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: AppMotionTokens.fadeThrough,
      value: 1,
    );

    _outgoingOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );

    _incomingOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeIn),
      ),
    );

    _outgoingScale = Tween<double>(begin: 1, end: 0.92).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );

    _incomingScale = Tween<double>(begin: 0.92, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeIn),
      ),
    );

    _animationController.addStatusListener(_handleAnimationStatus);
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      setState(() {
        _previousIndex = null;
      });
    }
  }

  @override
  void didUpdateWidget(covariant _MainTabContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _previousIndex = oldWidget.selectedIndex;
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_handleAnimationStatus);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomeView(),
      ProductComparisonView(),
      HistoryView(),
      SettingsView(),
    ];

    return Stack(
      fit: StackFit.expand,
      children: List.generate(pages.length, (index) {
        final isCurrent = index == widget.selectedIndex;
        final isPrevious = index == _previousIndex;
        final isVisible = isCurrent || isPrevious;

        return Offstage(
          offstage: !isVisible,
          child: TickerMode(
            enabled: isCurrent,
            child: IgnorePointer(
              ignoring: !isCurrent,
              child: FadeTransition(
                opacity: isCurrent ? _incomingOpacity : _outgoingOpacity,
                child: ScaleTransition(
                  scale: isCurrent ? _incomingScale : _outgoingScale,
                  child: pages[index],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
