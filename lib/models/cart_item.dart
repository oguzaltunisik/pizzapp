import 'product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;

  CartItem({required this.id, required this.product, required this.quantity});

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'category': product.category,
      },
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      product: Product(
        id: json['product']['id'] as String,
        name: json['product']['name'] as String,
        description: json['product']['description'] as String,
        price: json['product']['price'] as double,
        category: json['product']['category'] as String,
      ),
      quantity: json['quantity'] as int,
    );
  }
}
