import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/item_bottom_sheet.dart';
import 'checkout_screen.dart';
import '../widgets/item_list_tile.dart';
import '../widgets/bottom_action_button.dart';

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
              return ItemListTile(
                item: item,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (ctx) => DraggableScrollableSheet(
                      initialChildSize: 0.6,
                      minChildSize: 0.4,
                      maxChildSize: 0.9,
                      expand: false,
                      builder: (context, scrollController) =>
                          SingleChildScrollView(
                            controller: scrollController,
                            child: ItemBottomSheet(
                              item: item,
                              cartItemId: item.cartId,
                              initialQuantity: item.quantity,
                            ),
                          ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) return const SizedBox();
          return BottomActionButton(
            label: 'Devam Et: ${cart.totalAmount.toStringAsFixed(2)} €',
            icon: Icons.payment,
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
