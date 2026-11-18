
export interface ProductAnalysisInput {
  category: string;
  subcategory: string;
  productName: string;
  model?: string;
  askingPrice: number;
  currency: string;
  condition: string;
  sellerDescription?: string;
}

export interface ProductImageInput {
  data: ArrayBuffer;
  mimeType: string;
}

export interface AnalysisReportPayload {
  overallDealAssessment: string;
  visibleConditionObservations: string[];
  positiveAspects: string[];
  potentialRedFlags: string[];
  missingInformation: string[];
  questionsToAskSeller: string[];
  inspectionChecklist: string[];
  priceConsiderations: string[];
  aiRecommendation: string;
}

export interface AnalysisReportResponse
  extends AnalysisReportPayload {
  analyzedAt: string;
}
