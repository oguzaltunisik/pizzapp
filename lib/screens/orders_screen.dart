import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/orders_provider.dart';
import '../models/enums.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
      case OrderStatus.preparing:
        return Colors.orange;
      case OrderStatus.ready:
        return Colors.blue;
      case OrderStatus.onTheWay:
        return Colors.purple;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  void _showCancelDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Siparişi İptal Et'),
        content: const Text(
          'Bu siparişi iptal etmek istediğinizden emin misiniz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Vazgeç'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<OrdersProvider>(
                context,
                listen: false,
              ).cancelOrder(orderId);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sipariş iptal edildi')),
              );
            },
            child: const Text('İptal Et', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Siparişlerim')),
      body: Consumer<OrdersProvider>(
        builder: (context, orders, child) {
          if (orders.orders.isEmpty) {
            return const Center(child: Text('Henüz siparişiniz bulunmuyor.'));
          }

          return ListView.builder(
            itemCount: orders.orders.length,
            itemBuilder: (ctx, i) {
              final order = orders.orders[i];
              return Card(
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Sipariş #${order.id.substring(0, 8)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat('dd.MM.yyyy HH:mm').format(order.dateTime),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order.status),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              order.status.label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${order.totalAmount.toStringAsFixed(2)} ₺',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (order.status == OrderStatus.pending)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextButton.icon(
                          onPressed: () => _showCancelDialog(context, order.id),
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          label: const Text(
                            'Siparişi İptal Et',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Müşteri: ${order.customerName}'),
                          const SizedBox(height: 4),
                          Text('Telefon: ${order.customerPhone}'),
                          if (order.customerAddress != null) ...[
                            const SizedBox(height: 4),
                            Text('Adres: ${order.customerAddress}'),
                          ],
                          const SizedBox(height: 8),
                          Text('Teslimat: ${order.deliveryMethod.label}'),
                          const SizedBox(height: 4),
                          Text('Ödeme: ${order.paymentMethod.label}'),
                        ],
                      ),
                    ),
                    const Divider(),
                    ...order.items.map((item) {
                      return ListTile(
                        leading: CircleAvatar(child: Text('${item.quantity}x')),
                        title: Text(item.item.name),
                        trailing: Text(
                          '${(item.item.price * item.quantity).toStringAsFixed(2)} ₺',
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
