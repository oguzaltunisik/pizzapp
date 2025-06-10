import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/action_button.dart';
import 'home_screen.dart';
import 'cart_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeScreen(),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) return const SizedBox();
          return ActionButton(
            text:
                '${cart.itemCount} Siparişi Görüntüleyin   ${cart.totalAmount.toStringAsFixed(2)} ₺',
            icon: Icons.shopping_cart,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            isBottomBar: true,
          );
        },
      ),
    );
  }
}
