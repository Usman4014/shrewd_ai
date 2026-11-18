
import 'package:get/get.dart';

import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/data/models/analysis_report_model.dart';
import 'package:shrewd_ai/data/repositories/history_repository.dart';
import 'package:shrewd_ai/modules/history/controllers/history_controller.dart';
import 'package:shrewd_ai/shared/widgets/app_snackbar.dart';

class AnalysisResultController extends GetxController {
  AnalysisResultController({
    this.initialReport,
  });

  final AnalysisReportModel? initialReport;

  final HistoryRepository _historyRepository =
      Get.find<HistoryRepository>();

  final Rxn<AnalysisReportModel> report =
      Rxn<AnalysisReportModel>();

  final RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();

    final arguments = initialReport ?? Get.arguments;

    if (arguments is AnalysisReportModel) {
      report.value = arguments;
      _saveReportToHistory(arguments);
    }
  }

  Future<void> _saveReportToHistory(
    AnalysisReportModel analysisReport,
  ) async {
    if (analysisReport.id != null) return;

    if (isSaving.value) return;

    try {
      isSaving.value = true;

      final savedId = await _historyRepository.saveReport(
        analysisReport,
      );

      report.value = analysisReport.copyWith(id: savedId);

      if (Get.isRegistered<HistoryController>()) {
        Get.find<HistoryController>().loadHistory();
      }
    } catch (error) {
     AppSnackbar.error(
  AppConstants.historySaveError,
);
    } finally {
      isSaving.value = false;
    }
  }
}
