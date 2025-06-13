import 'enums.dart';

class Item {
  static const double extraToppingPrice = 2.0;

  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final List<Toppings>? toppings;
  List<Toppings>? removedToppings;
  List<Toppings>? extraToppings;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.toppings,
  }) {
    removedToppings = [];
    extraToppings = [];
  }

  double get totalPrice =>
      price + (extraToppings?.length ?? 0) * extraToppingPrice;

  Item copy() {
    final copy = Item(
      id: id,
      name: name,
      description: description,
      price: price,
      category: category,
      toppings: toppings,
    );
    copy.removedToppings = removedToppings?.toList();
    copy.extraToppings = extraToppings?.toList();
    return copy;
  }
}
