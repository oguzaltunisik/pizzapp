import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../models/item.dart';
import '../models/enums.dart';
import '../models/customer.dart';

class OrdersProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(
    List<Item> items,
    double totalAmount, {
    required Customer customer,
    required DeliveryMethod deliveryMethod,
    required PaymentMethod paymentMethod,
  }) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        items: items,
        totalAmount: totalAmount,
        dateTime: DateTime.now(),
        customer: customer,
        deliveryMethod: deliveryMethod,
        paymentMethod: paymentMethod,
      ),
    );
    notifyListeners();
  }

  void cancelOrder(String orderId) {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1 && _orders[orderIndex].status == OrderStatus.pending) {
      _orders[orderIndex] = Order(
        id: _orders[orderIndex].id,
        items: _orders[orderIndex].items,
        totalAmount: _orders[orderIndex].totalAmount,
        dateTime: _orders[orderIndex].dateTime,
        customer: _orders[orderIndex].customer,
        deliveryMethod: _orders[orderIndex].deliveryMethod,
        paymentMethod: _orders[orderIndex].paymentMethod,
        status: OrderStatus.cancelled,
      );
      notifyListeners();
    }
  }
}
