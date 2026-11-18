import 'package:shrewd_ai/data/models/product_category_model.dart';
import 'package:shrewd_ai/data/models/product_subcategory_model.dart';

class CategoryRepository {
  final List<ProductCategoryModel> _categories;

  CategoryRepository({
    required List<ProductCategoryModel> categories,
  }) : _categories = List.unmodifiable(categories);

  List<ProductCategoryModel> getAllCategories() {
    return _categories;
  }

  ProductCategoryModel? getCategoryByName(String name) {
    for (final category in _categories) {
      if (category.name == name) {
        return category;
      }
    }

    return null;
  }

  List<ProductSubcategoryModel> getSubcategories(String categoryName) {
    return getCategoryByName(categoryName)?.subcategories ?? [];
  }
}