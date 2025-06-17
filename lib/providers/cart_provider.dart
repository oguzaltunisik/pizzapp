import 'package:flutter/foundation.dart';
import '../models/item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, Item> _items = {};

  Map<String, Item> get items => {..._items};

  int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, item) {
      total += item.totalPrice * item.quantity;
    });
    return total;
  }

  void addItem(Item item) {
    final cartId = DateTime.now().toString();
    _items.putIfAbsent(
      cartId,
      () => item.copyWith(cartId: cartId, quantity: item.quantity),
    );
    notifyListeners();
  }

  void updateItem(String cartId, Item updatedItem, int quantity) {
    if (!_items.containsKey(cartId)) {
      return;
    }
    if (quantity <= 0) {
      _items.remove(cartId);
    } else {
      _items.update(
        cartId,
        (existingItem) =>
            updatedItem.copyWith(quantity: quantity, cartId: cartId),
      );
    }
    notifyListeners();
  }

  void removeItem(String cartId) {
    _items.remove(cartId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
