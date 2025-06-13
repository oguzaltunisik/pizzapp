import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.item.totalPrice * cartItem.quantity;
    });
    return total;
  }

  void addItem(Item item) {
    final cartItemId = DateTime.now().toString();
    _items.putIfAbsent(
      cartItemId,
      () => CartItem(id: cartItemId, item: item.copy(), quantity: 1),
    );
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    if (!_items.containsKey(itemId)) {
      return;
    }
    if (quantity <= 0) {
      _items.remove(itemId);
    } else {
      _items.update(
        itemId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          item: existingCartItem.item,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.remove(itemId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
