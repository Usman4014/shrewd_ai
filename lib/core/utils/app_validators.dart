class AppValidators {
  AppValidators._();

  static String? requiredField(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  static String? positivePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Asking price is required';
    }

    final price = double.tryParse(value.trim());

    if (price == null) {
      return 'Enter a valid price';
    }

    if (price <= 0) {
      return 'Price must be greater than zero';
    }

    return null;
  }
}