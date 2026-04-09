import '../../../home/domain/models/food_item.dart';

class OrderSummary {
  const OrderSummary({
    required this.item,
    required this.quantity,
    required this.spicyLevel,
    required this.subtotal,
    required this.toppings,
    required this.sides,
    this.taxes = 0.30,
    this.deliveryFee = 1.50,
  });

  final FoodItem item;
  final int quantity;
  final double spicyLevel;
  final double subtotal;
  final List<String> toppings;
  final List<String> sides;
  final double taxes;
  final double deliveryFee;

  double get total => subtotal + taxes + deliveryFee;
}
