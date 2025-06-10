import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/action_button.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim')),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(child: Text('Sepetiniz boş'));
          }
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) {
              final item = cart.items.values.elementAt(i);
              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(item.product.name),
                    subtitle: Text(
                      '${item.product.price.toStringAsFixed(2)} ₺',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            cart.updateQuantity(
                              item.product.id,
                              item.quantity - 1,
                            );
                          },
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            cart.updateQuantity(
                              item.product.id,
                              item.quantity + 1,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) return const SizedBox();
          return ActionButton(
            text: 'Ödemeye Gidin   ${cart.totalAmount.toStringAsFixed(2)} ₺',
            icon: Icons.payment,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CheckoutScreen()),
              );
            },
            isBottomBar: true,
          );
        },
      ),
    );
  }
}
