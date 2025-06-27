import 'enums.dart';

class Item {
  final String id;
  final String name;
  final String image;
  final String? description;
  final double price;
  final Category category;
  final List<Toppings>? toppings;

  // For cart
  List<Toppings>? removedToppings;
  Map<Toppings, int>? extraToppings;
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
    extraToppings = extraToppings ?? {};
  }

  double get totalPrice {
    double extraTotal = 0.0;
    if (extraToppings != null) {
      for (final entry in extraToppings!.entries) {
        extraTotal += entry.key.price * entry.value;
      }
    }
    return price + extraTotal;
  }

  Item copyWith({
    int? quantity,
    String? cartId,
    List<Toppings>? removedToppings,
    Map<Toppings, int>? extraToppings,
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
      ..extraToppings = extraToppings ?? Map.from(this.extraToppings ?? {});
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
      'extraToppings': extraToppings?.map(
        (key, value) => MapEntry(key.name, value),
      ),
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
          (json['extraToppings'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              Toppings.values.firstWhere((t) => t.name == key),
              value as int,
            ),
          ) ??
          {};
  }
}
