
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';
import 'package:shrewd_ai/shared/widgets/app_text_field.dart';

import '../controllers/history_controller.dart';

class HistorySearchBar extends GetView<HistoryController> {
  const HistorySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.screenHorizontalPadding,
        vertical: AppDesignTokens.spacingSmall,
      ),
      child: Obx(
        () => AppTextField(
          controller: controller.searchTextController,
          hint: AppConstants.historySearchHint,
          onChanged: controller.updateSearch,
          prefixIcon: const Icon(
            PhosphorIconsRegular.magnifyingGlass,
          ),
          suffixIcon: controller.searchQuery.value.isNotEmpty
              ? IconButton(
                  onPressed: controller.clearSearch,
                  icon: const Icon(PhosphorIconsRegular.x),
                )
              : null,
          contentPadding: const EdgeInsets.all(
            AppDesignTokens.inputContentPadding,
          ),
        ),
      ),
    );
  }
}
