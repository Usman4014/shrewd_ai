import 'analysis_report_model.dart';

class ComparisonModel {
  final AnalysisReportModel firstProduct;
  final AnalysisReportModel secondProduct;
  final String? comparisonRecommendation;

  const ComparisonModel({
    required this.firstProduct,
    required this.secondProduct,
    this.comparisonRecommendation,
  });
}