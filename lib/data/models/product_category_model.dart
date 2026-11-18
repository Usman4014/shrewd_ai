import 'product_subcategory_model.dart';

class ProductCategoryModel {
  final String name;
  final List<ProductSubcategoryModel> subcategories;

  const ProductCategoryModel({
    required this.name,
    this.subcategories = const [],
  });
}