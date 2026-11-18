import 'product_model.dart';

class AnalysisReportModel {
  final String? id;
  final ProductModel product;
  final DateTime? analyzedAt;

  final String? overallDealAssessment;
  final List<String> visibleConditionObservations;
  final List<String> positiveAspects;
  final List<String> potentialRedFlags;
  final List<String> missingInformation;
  final List<String> questionsToAskSeller;
  final List<String> inspectionChecklist;
  final List<String> priceConsiderations;
  final String? aiRecommendation;

  const AnalysisReportModel({
    this.id,
    required this.product,
    this.analyzedAt,
    this.overallDealAssessment,
    this.visibleConditionObservations = const [],
    this.positiveAspects = const [],
    this.potentialRedFlags = const [],
    this.missingInformation = const [],
    this.questionsToAskSeller = const [],
    this.inspectionChecklist = const [],
    this.priceConsiderations = const [],
    this.aiRecommendation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toMap(),
      'analyzedAt': analyzedAt?.toIso8601String(),
      'overallDealAssessment': overallDealAssessment,
      'visibleConditionObservations': visibleConditionObservations,
      'positiveAspects': positiveAspects,
      'potentialRedFlags': potentialRedFlags,
      'missingInformation': missingInformation,
      'questionsToAskSeller': questionsToAskSeller,
      'inspectionChecklist': inspectionChecklist,
      'priceConsiderations': priceConsiderations,
      'aiRecommendation': aiRecommendation,
    };
  }

  factory AnalysisReportModel.fromMap(Map<String, dynamic> map) {
    List<String> readList(String key) {
      return (map[key] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList();
    }

    return AnalysisReportModel(
      id: map['id'] as String?,
      product: ProductModel.fromMap(
        Map<String, dynamic>.from(map['product'] as Map),
      ),
      analyzedAt: map['analyzedAt'] != null
          ? DateTime.tryParse(map['analyzedAt'].toString())
          : null,
      overallDealAssessment:
          map['overallDealAssessment'] as String?,
      visibleConditionObservations:
          readList('visibleConditionObservations'),
      positiveAspects: readList('positiveAspects'),
      potentialRedFlags: readList('potentialRedFlags'),
      missingInformation: readList('missingInformation'),
      questionsToAskSeller: readList('questionsToAskSeller'),
      inspectionChecklist: readList('inspectionChecklist'),
      priceConsiderations: readList('priceConsiderations'),
      aiRecommendation: map['aiRecommendation'] as String?,
    );
  }


  AnalysisReportModel copyWith({
  String? id,
  ProductModel? product,
  DateTime? analyzedAt,
  String? overallDealAssessment,
  List<String>? visibleConditionObservations,
  List<String>? positiveAspects,
  List<String>? potentialRedFlags,
  List<String>? missingInformation,
  List<String>? questionsToAskSeller,
  List<String>? inspectionChecklist,
  List<String>? priceConsiderations,
  String? aiRecommendation,
}) {
  return AnalysisReportModel(
    id: id ?? this.id,
    product: product ?? this.product,
    analyzedAt: analyzedAt ?? this.analyzedAt,
    overallDealAssessment:
        overallDealAssessment ?? this.overallDealAssessment,
    visibleConditionObservations:
        visibleConditionObservations ?? this.visibleConditionObservations,
    positiveAspects: positiveAspects ?? this.positiveAspects,
    potentialRedFlags: potentialRedFlags ?? this.potentialRedFlags,
    missingInformation: missingInformation ?? this.missingInformation,
    questionsToAskSeller:
        questionsToAskSeller ?? this.questionsToAskSeller,
    inspectionChecklist:
        inspectionChecklist ?? this.inspectionChecklist,
    priceConsiderations:
        priceConsiderations ?? this.priceConsiderations,
    aiRecommendation: aiRecommendation ?? this.aiRecommendation,
  );
}
}