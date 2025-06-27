import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';
import '../widgets/item_list_tile.dart';

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
              return ItemListTile(item: item);
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) return const SizedBox();
          return ElevatedButton.icon(
            label: Text('Devam Et: ${cart.totalAmount.toStringAsFixed(2)} TL'),
            icon: Icon(Icons.payment),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CheckoutScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
