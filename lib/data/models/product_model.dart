class ProductModel {
  final String? category;
  final String? subcategory;
  final String? productName;
  final String? model;
  final List<String> imagePaths;
  final double? askingPrice;
  final String? currency;
  final String? condition;
  final String? sellerDescription;

  const ProductModel({
    this.category,
    this.subcategory,
    this.productName,
    this.model,
    this.imagePaths = const [],
    this.askingPrice,
    this.currency,
    this.condition,
    this.sellerDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'subcategory': subcategory,
      'productName': productName,
      'model': model,
      'imagePaths': imagePaths,
      'askingPrice': askingPrice,
      'currency': currency,
      'condition': condition,
      'sellerDescription': sellerDescription,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      category: map['category'] as String?,
      subcategory: map['subcategory'] as String?,
      productName: map['productName'] as String?,
      model: map['model'] as String?,
      imagePaths: (map['imagePaths'] as List<dynamic>? ?? [])
          .map((path) => path.toString())
          .toList(),
      askingPrice: (map['askingPrice'] as num?)?.toDouble(),
      currency: map['currency'] as String?,
      condition: map['condition'] as String?,
      sellerDescription: map['sellerDescription'] as String?,
    );
  }
}