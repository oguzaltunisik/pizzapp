import 'item.dart';
import 'enums.dart';

class CartItem {
  final String id;
  final Item item;
  final int quantity;

  CartItem({required this.id, required this.item, required this.quantity});

  double get totalPrice => item.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': {
        'id': item.id,
        'name': item.name,
        'description': item.description,
        'price': item.price,
        'category': item.category.name,
      },
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final categoryName = json['item']['category'] as String;
    final category = Category.values.firstWhere(
      (e) => e.name == categoryName,
      orElse: () => Category.pizzas, // Varsayılan kategori
    );

    return CartItem(
      id: json['id'] as String,
      item: Item(
        id: json['item']['id'] as String,
        name: json['item']['name'] as String,
        description: json['item']['description'] as String,
        price: json['item']['price'] as double,
        category: category,
      ),
      quantity: json['quantity'] as int,
    );
  }
}
