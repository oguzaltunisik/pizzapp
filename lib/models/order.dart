import 'cart_item.dart';
import 'enums.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime dateTime;
  final String customerName;
  final String customerPhone;
  final String? customerAddress;
  final DeliveryMethod deliveryMethod;
  final PaymentMethod paymentMethod;
  final OrderStatus status;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
    required this.customerName,
    required this.customerPhone,
    this.customerAddress,
    required this.deliveryMethod,
    required this.paymentMethod,
    this.status = OrderStatus.pending,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'dateTime': dateTime.toIso8601String(),
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'deliveryMethod': deliveryMethod.name,
      'paymentMethod': paymentMethod.name,
      'status': status.name,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalAmount: json['totalAmount'],
      dateTime: DateTime.parse(json['dateTime']),
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      customerAddress: json['customerAddress'],
      deliveryMethod: DeliveryMethod.values.firstWhere(
        (e) => e.name == json['deliveryMethod'],
      ),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == json['paymentMethod'],
      ),
      status: OrderStatus.values.firstWhere((e) => e.name == json['status']),
    );
  }
}
