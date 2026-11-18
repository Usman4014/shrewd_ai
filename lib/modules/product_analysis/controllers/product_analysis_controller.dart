import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shrewd_ai/modules/analysis_loading/controllers/analysis_loading_controller.dart';
import 'package:http_parser/http_parser.dart';

import 'package:shrewd_ai/app/routes/app_routes.dart';
import 'package:shrewd_ai/core/constants/api_constants.dart';
import 'package:shrewd_ai/core/constants/app_constants.dart';
import 'package:shrewd_ai/core/services/image_service.dart';
import 'package:shrewd_ai/core/utils/app_validators.dart';

import 'package:shrewd_ai/data/models/analysis_report_model.dart';
import 'package:shrewd_ai/data/models/product_category_model.dart';
import 'package:shrewd_ai/data/models/product_model.dart';
import 'package:shrewd_ai/data/models/product_subcategory_model.dart';

import 'package:shrewd_ai/data/repositories/analysis_repository.dart';
import 'package:shrewd_ai/data/repositories/category_repository.dart';
import 'package:shrewd_ai/data/repositories/settings_repository.dart';

import 'package:shrewd_ai/shared/enums/product_condition.dart';
import 'package:shrewd_ai/shared/widgets/app_snackbar.dart';

class ProductAnalysisController extends GetxController {
  final CategoryRepository _categoryRepository = Get.find<CategoryRepository>();

  final SettingsRepository _settingsRepository = Get.find<SettingsRepository>();

  final ImageService _imageService = Get.find<ImageService>();

  final AnalysisRepository _analysisRepository = Get.find<AnalysisRepository>();

  final formKey = GlobalKey<FormState>();

  final productNameController = TextEditingController();
  final modelController = TextEditingController();
  final priceController = TextEditingController();
  final sellerDescriptionController = TextEditingController();

  final RxList<ProductCategoryModel> categories = <ProductCategoryModel>[].obs;

  final RxList<ProductSubcategoryModel> subcategories =
      <ProductSubcategoryModel>[].obs;

  final RxList<XFile> selectedImages = <XFile>[].obs;

  final Rxn<ProductCategoryModel> selectedCategory =
      Rxn<ProductCategoryModel>();

  final Rxn<ProductSubcategoryModel> selectedSubcategory =
      Rxn<ProductSubcategoryModel>();

  final Rxn<ProductCondition> selectedCondition = Rxn<ProductCondition>();

  final RxString selectedCurrency = ''.obs;

  final RxBool isPickingImages = false.obs;
  final RxBool isSubmitting = false.obs;

  ProductModel? preparedProduct;

  @override
  void onInit() {
    super.onInit();

    categories.assignAll(_categoryRepository.getAllCategories());

    final savedCurrency = _settingsRepository.getSettings().currencyPreference;

    selectedCurrency.value =
        AppConstants.supportedCurrencies.contains(savedCurrency)
        ? savedCurrency!
        : AppConstants.supportedCurrencies.first;
  }

  void selectCategory(ProductCategoryModel? category) {
    selectedCategory.value = category;
    selectedSubcategory.value = null;

    subcategories.assignAll(category?.subcategories ?? []);
  }

  void selectSubcategory(ProductSubcategoryModel? subcategory) {
    selectedSubcategory.value = subcategory;
  }

  void selectCondition(ProductCondition? condition) {
    selectedCondition.value = condition;
  }

  void selectCurrency(String? currency) {
    if (currency != null) {
      selectedCurrency.value = currency;
    }
  }

  Future<void> addImages() async {
    if (isPickingImages.value) return;

    if (selectedImages.length >= AppConstants.maxProductImages) {
      return;
    }

    try {
      isPickingImages.value = true;

      final images = await _imageService.pickProductImages(
        currentImageCount: selectedImages.length,
      );

      final existingPaths = selectedImages.map((image) => image.path).toSet();

      for (final image in images) {
        if (!existingPaths.contains(image.path) &&
            selectedImages.length < AppConstants.maxProductImages) {
          selectedImages.add(image);
        }
      }

      if (images.isEmpty) {
        AppSnackbar.warning(
          'No readable images were selected. Please try another image.',
        );
      }
    } catch (error, stackTrace) {
      debugPrint('SHREWD AI: Image selection failed: $error');
      debugPrintStack(stackTrace: stackTrace);

      AppSnackbar.error('Unable to process images. Please try again.');
    } finally {
      isPickingImages.value = false;
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  String? validateCategory(ProductCategoryModel? value) {
    return value == null ? AppConstants.productSelectCategoryError : null;
  }

  String? validateSubcategory(ProductSubcategoryModel? value) {
    return value == null ? AppConstants.productSelectSubcategoryError : null;
  }

  Future<void> openImagePreview(int index) async {
    if (index < 0 || index >= selectedImages.length) return;

    final updatedImages = await Get.toNamed<List<XFile>>(
      AppRoutes.imagePreview,
      arguments: {'images': selectedImages.toList(), 'initialIndex': index},
    );

    if (updatedImages != null) {
      selectedImages.assignAll(updatedImages);
    }
  }

  String? validateCondition(ProductCondition? value) {
    return value == null ? AppConstants.productSelectConditionError : null;
  }

  String? validateProductName(String? value) {
    return AppValidators.requiredField(
      value,
      fieldName: AppConstants.productNameLabel,
    );
  }

  String? validatePrice(String? value) {
    return AppValidators.positivePrice(value);
  }

  Future<FormData> _buildMultipartData(ProductModel product) async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('category', product.category!),
      MapEntry('subcategory', product.subcategory!),
      MapEntry('productName', product.productName!),
      MapEntry('askingPrice', product.askingPrice.toString()),
      MapEntry('currency', product.currency!),
      MapEntry('condition', product.condition!),
    ]);

    if (product.model != null) {
      formData.fields.add(MapEntry('model', product.model!));
    }

    if (product.sellerDescription != null) {
      formData.fields.add(
        MapEntry('sellerDescription', product.sellerDescription!),
      );
    }

    for (final image in selectedImages) {
      final extension = image.name.split('.').last.toLowerCase();

      final mimeType = switch (extension) {
        'jpg' || 'jpeg' => MediaType('image', 'jpeg'),
        'png' => MediaType('image', 'png'),
        'webp' => MediaType('image', 'webp'),
        _ => throw FormatException('Unsupported image format: $extension'),
      };

      final multipartFile = await MultipartFile.fromFile(
        image.path,
        filename: image.name,
        contentType: mimeType,
      );

      formData.files.add(MapEntry('images', multipartFile));
    }

    return formData;
  }

  AnalysisReportModel _createAnalysisReport(
    ProductModel product,
    dynamic responseData,
  ) {
    if (responseData is! Map) {
      throw const FormatException('Invalid analysis response.');
    }

    final data = Map<String, dynamic>.from(responseData);

    if (data['success'] != true || data['data'] is! Map) {
      throw FormatException(
        data['message']?.toString() ?? 'Analysis could not be completed.',
      );
    }

    final reportData = Map<String, dynamic>.from(data['data'] as Map);

    List<String> readList(String key) {
      final value = reportData[key];

      if (value is! List || !value.every((item) => item is String)) {
        throw FormatException('Invalid analysis field: $key');
      }

      return value.cast<String>();
    }

    String readString(String key) {
      final value = reportData[key];

      if (value is! String || value.trim().isEmpty) {
        throw FormatException('Missing analysis field: $key');
      }

      return value;
    }

    final analyzedAtValue = reportData['analyzedAt'];

    final analyzedAt = analyzedAtValue is String
        ? DateTime.tryParse(analyzedAtValue)
        : null;

    if (analyzedAt == null) {
      throw const FormatException('Invalid analysis timestamp.');
    }

    return AnalysisReportModel(
      product: product,
      analyzedAt: analyzedAt,
      overallDealAssessment: readString('overallDealAssessment'),
      visibleConditionObservations: readList('visibleConditionObservations'),
      positiveAspects: readList('positiveAspects'),
      potentialRedFlags: readList('potentialRedFlags'),
      missingInformation: readList('missingInformation'),
      questionsToAskSeller: readList('questionsToAskSeller'),
      inspectionChecklist: readList('inspectionChecklist'),
      priceConsiderations: readList('priceConsiderations'),
      aiRecommendation: readString('aiRecommendation'),
    );
  }

 
String _getErrorMessage(Object error) {
  if (error is DioException) {
    final response = error.response;
    final responseData = response?.data;
    final statusCode = response?.statusCode;

    String responseMessage = '';
    String responseStatus = '';
    String responseErrorCode = '';

    if (responseData is Map) {
      final errorData = responseData['error'];

      if (errorData is Map) {
        responseErrorCode =
            errorData['code']?.toString() ?? '';

        responseStatus =
            errorData['status']?.toString() ?? '';

        responseMessage =
            errorData['message']?.toString() ?? '';
      }

      if (responseMessage.isEmpty) {
        responseMessage =
            responseData['message']?.toString() ?? '';
      }

      if (responseStatus.isEmpty) {
        responseStatus =
            responseData['status']?.toString() ?? '';
      }

      if (responseErrorCode.isEmpty) {
        responseErrorCode =
            responseData['code']?.toString() ?? '';
      }
    }

    final errorDetails =
        '$responseMessage $responseStatus'.toLowerCase();

    final normalizedErrorCode =
        responseErrorCode.toUpperCase();

    final normalizedStatus =
        responseStatus.toUpperCase();

    final isQuotaExceeded =
        statusCode == 429 ||
        normalizedErrorCode == '429' ||
        normalizedErrorCode == 'AI_QUOTA_EXCEEDED' ||
        normalizedStatus == 'RESOURCE_EXHAUSTED' ||
        errorDetails.contains('quota exceeded') ||
        errorDetails.contains('generate_content_free_tier_requests');

    if (isQuotaExceeded) {
      return "You've reached today's free AI analysis limit. Please try again tomorrow.";
    }

    if (statusCode == 503 ||
        normalizedErrorCode == '503' ||
        normalizedStatus == 'UNAVAILABLE') {
      return 'The AI service is temporarily unavailable. Please try again later.';
    }

    if (statusCode == 524 ||
        normalizedErrorCode == 'AI_TIMEOUT' ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return 'The analysis is taking longer than expected. Please try again later.';
    }

    if (response == null) {
      return 'Unable to connect to SHREWD AI server. Please check your connection.';
    }

    return 'The AI service could not complete the analysis. Please try again later.';
  }

  if (error is FormatException) {
    return error.message;
  }

  return 'Something went wrong while analyzing your product. Please try again.';
}


  Future<void> submitAnalysis() async {
    if (isSubmitting.value) return;

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (selectedImages.isEmpty) {
      AppSnackbar.warning('Please select at least one product image.');
      return;
    }

    if (selectedImages.length > AppConstants.maxProductImages) {
      return;
    }

    final product = ProductModel(
      category: selectedCategory.value!.name,
      subcategory: selectedSubcategory.value!.name,
      productName: productNameController.text.trim(),
      model: modelController.text.trim().isEmpty
          ? null
          : modelController.text.trim(),
      imagePaths: selectedImages.map((image) => image.path).toList(),
      askingPrice: double.parse(priceController.text.trim()),
      currency: selectedCurrency.value,
      condition: selectedCondition.value!.label,
      sellerDescription: sellerDescriptionController.text.trim().isEmpty
          ? null
          : sellerDescriptionController.text.trim(),
    );

    preparedProduct = product;
    isSubmitting.value = true;

    try {
      final loadingController = Get.put(AnalysisLoadingController());

      loadingController.startPreparing();

      Get.toNamed(AppRoutes.analysisLoading);

      final formData = await _buildMultipartData(product);
      loadingController.startUploading();

      final response = await _analysisRepository.submitAnalysis(
        endpoint: ApiConstants.analyzeEndpoint,
        data: formData,
        onSendProgress: (sent, total) {
          loadingController.updateUploadProgress(sent, total);

          if (total > 0 && sent >= total) {
            loadingController.startProcessing();
          }
        },
      );

      final report = _createAnalysisReport(product, response.data);

      loadingController.completeAnalysis();

      Get.offNamed(AppRoutes.analysisResult, arguments: report);
    } catch (error, stackTrace) {
      debugPrint('SHREWD AI: Product analysis failed: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (Get.currentRoute == AppRoutes.analysisLoading) {
        Get.back();
      }

      AppSnackbar.error(_getErrorMessage(error));
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    productNameController.dispose();
    modelController.dispose();
    priceController.dispose();
    sellerDescriptionController.dispose();

    super.onClose();
  }
}
