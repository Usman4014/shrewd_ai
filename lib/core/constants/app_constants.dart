
class AppConstants {
  AppConstants._();

  // ==========================================
  // APP INFORMATION
  // ==========================================

  static const String appName = 'SHREWD AI';

  static const String appTagline = 'Buy Smart. Buy Confident.';

  static const String appSubtitle =
      'AI-Powered Insights for Smarter Second-Hand Purchases.';

  static const String appDescription =
      'An AI-powered smart buying assistant designed to help users '
      'make informed and confident purchasing decisions when buying '
      'second-hand or pre-owned products.';

  // ==========================================
  // APP CONFIGURATION
  // ==========================================

  static const int onboardingPageCount = 1;

  static const int maxProductImages = 5;

  static const int bottomNavigationTabCount = 3;

  static const bool authenticationEnabled = false;

  // ==========================================
  // ONBOARDING CONTENT
  // ==========================================

  static const String onboardingTitle =
      'Buy Second-Hand with Confidence';

  static const String onboardingDescription =
      'Let AI analyze product details, identify potential red flags, '
      'and help you make smarter buying decisions.';

  static const String onboardingButtonText = 'Get Started';

  static const String onboardingSkipText = 'Skip';

  // ==========================================
  // BACKEND CONFIGURATION
  // ==========================================

  static const String backendProvider = 'Cloudflare Workers';

  static const String aiProvider = 'Gemini API';

  // ==========================================
  // LOCAL STORAGE
  // ==========================================

  static const String localStorageProvider = 'Hive';

  static const bool historyStoredLocally = true;

  // ==========================================
  // PRODUCT ANALYSIS
  // ==========================================

  static const String analysisDisclaimer =
      'SHREWD AI provides AI-generated decision support based on '
      'available information. It does not guarantee product '
      'authenticity, detect all hidden defects, verify seller claims, '
      'or provide certified product valuations.';


  
  // ==========================================
  // HOME SCREEN
  // ==========================================

  static const String homeWelcomeTitle = 'Welcome to SHREWD AI';
  static const String homeWelcomeDescription =
      'Make informed decisions before buying.';

  static const String homeAnalysisTitle = 'Analyze Before You Buy';
  static const String homeAnalysisDescription =
      'Get AI-powered insights into product condition, potential '
      'red flags, and buying recommendations.';
  static const String homeAnalysisButton = 'Start Product Analysis';

  static const String homeCategoriesTitle = 'Explore Categories';
  static const String homeCategoriesDescription =
      'Choose a category to analyze a pre-owned product.';
  static const String homeViewAllCategories = 'View All';

  static const String homeHowItWorksTitle = 'How It Works?';
  static const String homeStepOneTitle = 'Share Product Details';
  static const String homeStepOneDescription =
      'Add product information, photos, price, and seller description.';
  static const String homeStepTwoTitle = 'AI Analyzes the Product';
  static const String homeStepTwoDescription =
      'Review available details and identify potential concerns.';
  static const String homeStepThreeTitle = 'Make a Smarter Decision';
  static const String homeStepThreeDescription =
      'Explore insights and recommendations before purchasing.';

  static const String homeRecentTitle = 'Recent Analyses';
  static const String homeRecentEmptyTitle = 'No Analyses Yet';
  static const String homeRecentEmptyDescription =
      'Your previous product analyses will appear here.';
  static const String homeViewHistory = 'View History';
  static const String homeSavedAnalysisLabel = 'Saved Analyses';

  static const String homeCompareTitle = 'Compare Products';
  static const String homeCompareDescription =
      'Compare saved product analyses to make a more informed choice.';
  static const String homeCompareButton = 'Compare Products';

  static const String homeCategoryIconFallback = 'Category';
  static const int homeCategoryGridColumns = 2;
static const double homeCategoryCardAspectRatio = 2.5;


// Main Navigation
static const String mainHomeLabel = 'Home';
static const String mainHistoryLabel = 'History';
static const String mainSettingsLabel = 'Settings';



// Settings
static const String settingsTitle = 'Settings';
static const String settingsAppearanceTitle = 'Appearance';
static const String settingsPreferencesTitle = 'Preferences';
static const String settingsAboutTitle = 'About SHREWD AI';
static const String settingsAboutDescription =
    'SHREWD AI helps you make more informed decisions '
    'when buying second-hand and pre-owned products.';




  // ==========================================
  // PRODUCT ANALYSIS
  // ==========================================

  static const String productAnalysisTitle = 'Analyze Product';
  static const String productAnalysisSubtitle =
      'Enter product details to get AI-powered buying insights.';

  static const String productCategoryLabel = 'Product Category';
  static const String productSubcategoryLabel = 'Subcategory';
  static const String productNameLabel = 'Product Name';
  static const String productModelLabel = 'Model';
  static const String productPriceLabel = 'Asking Price';
  static const String productCurrencyLabel = 'Currency';
  static const String productConditionLabel = 'Product Condition';
  static const String productImagesLabel = 'Product Photos';
  static const String productDescriptionLabel = 'Seller Description';

  static const String productCategoryHint = 'Select a category';
  static const String productSubcategoryHint = 'Select a subcategory';
  static const String productNameHint = 'Enter product name';
  static const String productModelHint = 'Enter model (optional)';
  static const String productPriceHint = 'Enter asking price';
  static const String productConditionHint = 'Select product condition';
  static const String productDescriptionHint =
      'Enter the seller description (optional)';

  static const String productImagesDescription =
      'Add up to 5 photos of the product.';
  static const String productAddImages = 'Add Photos';
  static const String productAnalyzeButton = 'Analyze with AI';

  static const String productDetailsSectionTitle = 'Product Details';
  static const String productImagesSectionTitle = 'Product Images';

  static const String productSelectCategoryError =
      'Please select a product category';
  static const String productSelectSubcategoryError =
      'Please select a subcategory';
  static const String productSelectConditionError =
      'Please select product condition';

  static const String productFormReadyMessage =
      'Product details validated. AI analysis will be available after backend integration.';

  static const List<String> supportedCurrencies = [
    'PKR',
    'USD',
    'EUR',
    'GBP',
  ];


  // Analysis Loading
static const String analysisLoadingTitle = 'Preparing Your Analysis';
static const String analysisLoadingSubtitle =
    'Your product details will be reviewed to help you make a more informed buying decision.';

static const String analysisLoadingStepOne =
    'Analyzing Product Images';

static const String analysisLoadingStepTwo =
    'Reviewing Seller Description';

static const String analysisLoadingStepThree =
    'Identifying Potential Concerns';

static const String analysisLoadingStepFour =
    'Preparing Recommendations';

static const String analysisLoadingDisclaimer =
    'AI-generated insights are intended to support your decision. '
    'They do not guarantee product authenticity or reveal every hidden defect.';

  
  // Analysis Result
  static const String analysisResultTitle = 'Analysis Report';
  static const String analysisResultEmptyTitle = 'Report Unavailable';
  static const String analysisResultEmptyDescription =
      'No analysis report is available to display.';

  static const String analysisProductDetailsTitle = 'Product Overview';
  static const String analysisOverallAssessmentTitle = 'Overall Assessment';
  static const String analysisConditionTitle =
      'Visible Condition Observations';
  static const String analysisPositiveTitle = 'Positive Aspects';
  static const String analysisRedFlagsTitle = 'Potential Red Flags';
  static const String analysisMissingInfoTitle = 'Missing Information';
  static const String analysisSellerQuestionsTitle =
      'Questions to Ask Seller';
  static const String analysisInspectionTitle = 'Inspection Checklist';
  static const String analysisPriceTitle = 'Price Considerations';
  static const String analysisRecommendationTitle = 'AI Recommendation';

  static const String analysisProductNameLabel = 'Product';
  static const String analysisCategoryLabel = 'Category';
  static const String analysisSubcategoryLabel = 'Subcategory';
  static const String analysisModelLabel = 'Model';
  static const String analysisPriceLabel = 'Asking Price';
  static const String analysisConditionLabel = 'Condition';
  static const String analysisDateLabel = 'Analyzed On';

  static const String analysisNoDetailsAvailable =
      'No details available.';

  static const String analysisdisclaimer =
      'AI-generated insights are intended to support your buying decision. '
      'They do not guarantee authenticity, identify every hidden defect, '
      'or provide certified valuations.';

        // ==========================================
  // HISTORY
  // ==========================================

  static const String historyTitle = 'Analysis History';
  static const String historySearchHint = 'Search your analyses';
  static const String historyAllFilter = 'All';
  static const String historyNoResultsTitle = 'No Matching Analyses';
  static const String historyNoResultsDescription =
      'Try another search or select a different category.';
  static const String historyDeleteTitle = 'Delete Analysis?';
  static const String historyDeleteDescription =
      'This analysis will be permanently removed from your history.';
  static const String historyDeleteButton = 'Delete';
  static const String historyCancelButton = 'Cancel';
  static const String historyClearButton = 'Clear History';
  static const String historyClearTitle = 'Clear Analysis History?';
  static const String historyClearDescription =
      'All saved analysis reports will be permanently deleted.';
  static const String historyDeletedMessage =
      'Analysis deleted successfully.';
  static const String historyClearedMessage =
      'Analysis history cleared.';
  static const String historyDeleteError =
      'Unable to delete this analysis.';
  static const String historyLoadError =
      'Unable to load analysis history.';
  static const String historyProductFallback = 'Product Analysis';
  static const String historyCategoryFallback = 'Uncategorized';
  static const String historyDateFallback = 'Date unavailable';
  static const String historyPriceUnavailable = 'Price unavailable';
  static const String historyImageUnavailable = 'No image available';

  static const String historySaveError =
    'Unable to save this analysis to history.';



  // ==========================================
  // ABOUT SHREWD AI
  // ==========================================

  static const String aboutTitle = 'About SHREWD AI';
  static const String aboutTagline = 'Buy Smart. Buy Confident.';
  static const String aboutDescription =
      'SHREWD AI is an AI-powered smart buying assistant designed '
      'to help users make informed decisions when purchasing '
      'second-hand and pre-owned products.';

  static const String aboutPurposeTitle = 'Our Purpose';
  static const String aboutPurposeDescription =
      'Our goal is to reduce uncertainty when buying pre-owned '
      'products by helping users review available product details, '
      'identify potential concerns, and make more confident decisions.';

  static const String aboutFeaturesTitle = 'What You Can Do';
  static const List<String> aboutFeatures = [
    'Analyze product details and photos.',
    'Review visible condition observations.',
    'Identify potential red flags and missing information.',
    'Prepare questions to ask the seller.',
    'Review inspection tips and price considerations.',
    'Save and revisit previous analysis reports.',
  ];

  static const String aboutLimitationsLabel = 'AI Limitations';
  static const String aboutPrivacyLabel = 'Privacy Policy';
  static const String aboutTermsLabel = 'Terms & Conditions';

  // ==========================================
  // AI LIMITATIONS
  // ==========================================

  static const String aiLimitationsTitle = 'AI Limitations';
  static const String aiLimitationsIntro =
      'SHREWD AI provides AI-generated decision support based on '
      'the product information and images made available for analysis. '
      'Its results should be treated as guidance, not as a guarantee.';

  static const List<Map<String, String>> aiLimitationSections = [
    {
      'title': 'AI Accuracy',
      'description':
          'AI-generated observations may be incomplete, inaccurate, '
          'or inconsistent. Results can vary depending on the quality '
          'and amount of information provided.',
    },
    {
      'title': 'Hidden Defects',
      'description':
          'Photos and descriptions cannot reveal every internal, '
          'mechanical, electrical, or concealed defect. A product may '
          'have issues that are not visible in the submitted material.',
    },
    {
      'title': 'Product Authenticity',
      'description':
          'SHREWD AI cannot guarantee that a product is genuine, '
          'original, or free from counterfeit components.',
    },
    {
      'title': 'Seller Information',
      'description':
          'The application cannot independently verify seller claims, '
          'ownership, product history, warranties, or documents.',
    },
    {
      'title': 'Price Considerations',
      'description':
          'Price-related insights are general guidance and are not '
          'certified valuations, professional appraisals, or guarantees '
          'of market value.',
    },
    {
      'title': 'Physical Inspection',
      'description':
          'Users should inspect the product in person, test its '
          'important functions, and consult a qualified professional '
          'when necessary before making a purchase.',
    },
  ];

  static const String aiLimitationsClosing =
      'Always verify important details independently before making '
      'a purchase decision.';

  // ==========================================
  // PRIVACY POLICY
  // ==========================================

  static const String privacyPolicyTitle = 'Privacy Policy';

  static const String privacyPolicyIntro =
      'This preliminary privacy notice explains the information '
      'SHREWD AI is designed to handle. Some online processing '
      'details will be finalized when backend integration is completed.';

  static const List<Map<String, String>> privacyPolicySections = [
    {
      'title': 'Account Information',
      'description':
          'SHREWD AI currently does not require users to create an '
          'account or sign in to use the application.',
    },
    {
      'title': 'Product Information',
      'description':
          'Users may provide product names, categories, models, '
          'asking prices, condition details, seller descriptions, '
          'and product photos for analysis.',
    },
    {
      'title': 'Local History',
      'description':
          'Analysis history is designed to be stored locally on '
          'the device using Hive storage. Users can manage or clear '
          'their saved history from within the application.',
    },
    {
      'title': 'Product Photos',
      'description':
          'Selected product photos are used as part of the product '
          'analysis workflow. The application supports up to five '
          'photos per analysis.',
    },
    {
      'title': 'AI Processing',
      'description':
          'Online AI processing through Cloudflare Workers and the '
          'Gemini API is planned but is not yet active in the current '
          'frontend implementation. Before this feature is enabled, '
          'the data transmitted, processing purposes, retention, and '
          'applicable provider practices must be documented.',
    },
    {
      'title': 'Data Sharing',
      'description':
          'This draft does not make a claim that information is '
          'currently transmitted to or shared with external AI '
          'providers. Any third-party processing details will be '
          'disclosed before the related feature is enabled.',
    },
    {
      'title': 'Data Retention',
      'description':
          'Saved analysis history is intended to remain on the device '
          'until the user deletes individual reports or clears the '
          'history. Final retention details for any future online '
          'processing will be documented after backend integration.',
    },
    {
      'title': 'Policy Updates',
      'description':
          'This policy may be updated as application features and '
          'data processing practices are finalized.',
    },
  ];

  // ==========================================
  // TERMS & CONDITIONS
  // ==========================================

  static const String termsTitle = 'Terms & Conditions';

  static const String termsIntro =
      'By using SHREWD AI, you agree to use the application '
      'responsibly and understand the following terms.';

  static const List<Map<String, String>> termsSections = [
    {
      'title': 'Purpose of the Application',
      'description':
          'SHREWD AI is designed to provide AI-generated insights '
          'to support decisions when considering second-hand or '
          'pre-owned products.',
    },
    {
      'title': 'Informational Use',
      'description':
          'All analysis reports, observations, recommendations, '
          'and price considerations are provided for informational '
          'purposes only. They are not professional inspections, '
          'certified valuations, or purchase guarantees.',
    },
    {
      'title': 'User Responsibility',
      'description':
          'Users are responsible for reviewing product information, '
          'verifying seller claims, inspecting products, and making '
          'their own purchasing decisions.',
    },
    {
      'title': 'Accuracy of Submitted Information',
      'description':
          'Users should provide accurate and lawful product details '
          'and should only submit images and information they are '
          'permitted to use.',
    },
    {
      'title': 'No Authenticity Guarantee',
      'description':
          'SHREWD AI does not guarantee product authenticity, '
          'condition, ownership, seller reliability, or market value.',
    },
    {
      'title': 'Limitation of AI Results',
      'description':
          'AI-generated results may contain errors or omissions. '
          'Users should independently verify important information '
          'before relying on any recommendation.',
    },
    {
      'title': 'Changes to the Application',
      'description':
          'Application features, functionality, and these terms '
          'may be updated as the product develops.',
    },
  ];

  static const String termsClosing =
      'If you do not agree with these terms, please discontinue '
      'use of the application.';

static const String mainCompareLabel = 'Compare';

}
