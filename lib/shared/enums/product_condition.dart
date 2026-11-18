
enum ProductCondition {
  newCondition('New'),
  likeNew('Like New'),
  good('Good'),
  fair('Fair'),
  poor('Poor');

  final String label;

  const ProductCondition(this.label);
}
