import 'package:shrewd_ai/data/models/product_category_model.dart';
import 'package:shrewd_ai/data/models/product_subcategory_model.dart';

class ProductCategoriesData {
  ProductCategoriesData._();

  static const List<ProductCategoryModel> categories = [
    // 1. Electronics
    ProductCategoryModel(
      name: 'Electronics',
      subcategories: [
        ProductSubcategoryModel(name: 'Phones'),
        ProductSubcategoryModel(name: 'Laptops'),
        ProductSubcategoryModel(name: 'Tablets'),
        ProductSubcategoryModel(name: 'Smartwatches'),
        ProductSubcategoryModel(name: 'Headphones'),
        ProductSubcategoryModel(name: 'Cameras'),
        ProductSubcategoryModel(name: 'TVs'),
        ProductSubcategoryModel(name: 'Monitors'),
        ProductSubcategoryModel(name: 'Gaming Consoles'),
        ProductSubcategoryModel(name: 'Speakers'),
      ],
    ),

    // 2. Home Appliances
    ProductCategoryModel(
      name: 'Home Appliances',
      subcategories: [
        ProductSubcategoryModel(name: 'Refrigerators'),
        ProductSubcategoryModel(name: 'Washing Machines'),
        ProductSubcategoryModel(name: 'Air Conditioners'),
        ProductSubcategoryModel(name: 'Microwaves'),
        ProductSubcategoryModel(name: 'Ovens'),
        ProductSubcategoryModel(name: 'Vacuum Cleaners'),
        ProductSubcategoryModel(name: 'Kitchen Appliances'),
      ],
    ),

    // 3. Furniture
    ProductCategoryModel(
      name: 'Furniture',
      subcategories: [
        ProductSubcategoryModel(name: 'Sofas'),
        ProductSubcategoryModel(name: 'Beds'),
        ProductSubcategoryModel(name: 'Tables'),
        ProductSubcategoryModel(name: 'Chairs'),
        ProductSubcategoryModel(name: 'Wardrobes'),
        ProductSubcategoryModel(name: 'Office Furniture'),
        ProductSubcategoryModel(name: 'Cabinets'),
      ],
    ),

    // 4. Vehicles
    ProductCategoryModel(
      name: 'Vehicles',
      subcategories: [
        ProductSubcategoryModel(name: 'Cars'),
        ProductSubcategoryModel(name: 'Motorcycles'),
        ProductSubcategoryModel(name: 'Scooters'),
        ProductSubcategoryModel(name: 'Bicycles'),
      ],
    ),

    // 5. Fashion & Accessories
    ProductCategoryModel(
      name: 'Fashion & Accessories',
      subcategories: [
        ProductSubcategoryModel(name: 'Clothing'),
        ProductSubcategoryModel(name: 'Shoes'),
        ProductSubcategoryModel(name: 'Watches'),
        ProductSubcategoryModel(name: 'Handbags'),
        ProductSubcategoryModel(name: 'Jewelry'),
        ProductSubcategoryModel(name: 'Accessories'),
      ],
    ),

    // 6. Tools & Equipment
    ProductCategoryModel(
      name: 'Tools & Equipment',
      subcategories: [
        ProductSubcategoryModel(name: 'Power Tools'),
        ProductSubcategoryModel(name: 'Hand Tools'),
        ProductSubcategoryModel(name: 'Workshop Equipment'),
        ProductSubcategoryModel(name: 'Construction Equipment'),
      ],
    ),

    // 7. Musical Instruments
    ProductCategoryModel(
      name: 'Musical Instruments',
      subcategories: [
        ProductSubcategoryModel(name: 'Guitars'),
        ProductSubcategoryModel(name: 'Keyboards'),
        ProductSubcategoryModel(name: 'Drums'),
        ProductSubcategoryModel(name: 'Pianos'),
        ProductSubcategoryModel(name: 'Audio Equipment'),
      ],
    ),

    // 8. Sports & Fitness
    ProductCategoryModel(
      name: 'Sports & Fitness',
      subcategories: [
        ProductSubcategoryModel(name: 'Gym Equipment'),
        ProductSubcategoryModel(name: 'Bicycles'),
        ProductSubcategoryModel(name: 'Fitness Machines'),
        ProductSubcategoryModel(name: 'Sports Gear'),
      ],
    ),

    // 9. Baby & Kids
    ProductCategoryModel(
      name: 'Baby & Kids',
      subcategories: [
        ProductSubcategoryModel(name: 'Strollers'),
        ProductSubcategoryModel(name: 'Toys'),
        ProductSubcategoryModel(name: 'Baby Furniture'),
        ProductSubcategoryModel(name: "Kids' Bicycles"),
        ProductSubcategoryModel(name: 'Accessories'),
      ],
    ),

    // 10. Books & Education
    ProductCategoryModel(
      name: 'Books & Education',
      subcategories: [
        ProductSubcategoryModel(name: 'Books'),
        ProductSubcategoryModel(name: 'Textbooks'),
        ProductSubcategoryModel(name: 'Study Materials'),
        ProductSubcategoryModel(name: 'Educational Equipment'),
      ],
    ),

    // 11. Home & Garden
    ProductCategoryModel(
      name: 'Home & Garden',
      subcategories: [
        ProductSubcategoryModel(name: 'Decor'),
        ProductSubcategoryModel(name: 'Lighting'),
        ProductSubcategoryModel(name: 'Garden Tools'),
        ProductSubcategoryModel(name: 'Outdoor Furniture'),
        ProductSubcategoryModel(name: 'Gardening Equipment'),
      ],
    ),
  ];
}