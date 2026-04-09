class FoodItem {
  const FoodItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.deliveryTime,
    required this.category,
    required this.imagePath,
    required this.description,
    required this.price,
    required this.initialQuantity,
    required this.initialSpiceLevel,
  });

  final String id;
  final String title;
  final String subtitle;
  final double rating;
  final int deliveryTime;
  final String category;
  final String imagePath;
  final String description;
  final double price;
  final int initialQuantity;
  final double initialSpiceLevel;
}
