import 'enums.dart';

class Item {
  static const double extraToppingPrice = 2.0;

  final String id;
  final String name;
  final String image;
  final String? description;
  final double price;
  final Category category;
  final List<Toppings>? toppings;

  // For cart
  List<Toppings>? removedToppings;
  List<Toppings>? extraToppings;
  int quantity;
  String? cartId;

  Item({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    required this.price,
    required this.category,
    this.toppings,
    this.quantity = 0,
    this.cartId,
  }) {
    removedToppings = removedToppings ?? [];
    extraToppings = extraToppings ?? [];
  }

  double get totalPrice =>
      (price + (extraToppings?.length ?? 0) * extraToppingPrice);

  Item copyWith({
    int? quantity,
    String? cartId,
    List<Toppings>? removedToppings,
    List<Toppings>? extraToppings,
    Category? category,
  }) {
    return Item(
        id: id,
        name: name,
        image: image,
        description: description,
        price: price,
        category: category ?? this.category,
        toppings: toppings,
        quantity: quantity ?? this.quantity,
        cartId: cartId ?? this.cartId,
      )
      ..removedToppings = removedToppings ?? this.removedToppings?.toList()
      ..extraToppings = extraToppings ?? this.extraToppings?.toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description ?? '',
      'price': price,
      'category': category.name,
      'toppings': toppings?.map((t) => t.name).toList(),
      'removedToppings': removedToppings?.map((t) => t.name).toList(),
      'extraToppings': extraToppings?.map((t) => t.name).toList(),
      'quantity': quantity,
      'cartId': cartId,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'] as String,
        name: json['name'] as String,
        image: json['image'] as String,
        description: json['description'] as String?,
        price: (json['price'] as num).toDouble(),
        category: Category.values.firstWhere((c) => c.name == json['category']),
        toppings: (json['toppings'] as List?)
            ?.map((e) => Toppings.values.firstWhere((t) => t.name == e))
            .toList(),
        quantity: json['quantity'] ?? 0,
        cartId: json['cartId'],
      )
      ..removedToppings =
          (json['removedToppings'] as List?)
              ?.map((e) => Toppings.values.firstWhere((t) => t.name == e))
              .toList() ??
          []
      ..extraToppings =
          (json['extraToppings'] as List?)
              ?.map((e) => Toppings.values.firstWhere((t) => t.name == e))
              .toList() ??
          [];
  }
}
