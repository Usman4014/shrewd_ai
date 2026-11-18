
import 'package:get/get.dart';

class AnalysisLoadingController extends GetxController {
  final RxDouble uploadProgress = 0.0.obs;
  final RxBool isUploading = false.obs;
  final RxBool isProcessing = false.obs;
  final RxBool isCompleted = false.obs;
  final RxInt currentStage = 0.obs;

  void startPreparing() {
    uploadProgress.value = 0;
    isUploading.value = false;
    isProcessing.value = false;
    isCompleted.value = false;
    currentStage.value = 0;
  }

  void startUploading() {
    isUploading.value = true;
    isProcessing.value = false;
    currentStage.value = 1;
  }

  void updateUploadProgress(int sent, int total) {
    if (total <= 0 || !isUploading.value) return;

    uploadProgress.value = (sent / total).clamp(0.0, 1.0);
  }

  void startProcessing() {
    isUploading.value = false;
    isProcessing.value = true;
    currentStage.value = 2;
  }

  void completeAnalysis() {
    uploadProgress.value = 1;
    isUploading.value = false;
    isProcessing.value = false;
    isCompleted.value = true;
    currentStage.value = 3;
  }
}
