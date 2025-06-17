import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../data/mock_data.dart';
import '../widgets/item_bottom_sheet.dart';
import 'profile_screen.dart';
import '../models/enums.dart';
import 'cart_screen.dart';
import '../widgets/item_list_tile.dart';
import '../widgets/bottom_action_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PizzApp'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: '🍕 Pizzalar'),
              Tab(text: '🥙 Kebaplar'),
              Tab(text: '🥤 İçecekler'),
              Tab(text: '🍰 Tatlılar'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildItemList('Pizzalar'),
            _buildItemList('Kebaplar'),
            _buildItemList('İçecekler'),
            _buildItemList('Tatlılar'),
          ],
        ),
        bottomNavigationBar: Consumer<CartProvider>(
          builder: (context, cart, child) {
            if (cart.items.isEmpty) return const SizedBox();
            return BottomActionButton(
              label: 'Sepete Git: ${cart.totalAmount.toStringAsFixed(2)} ₺',
              icon: Icons.shopping_cart,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemList(String category) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final items = MockData.items
            .where((item) => item.category == _categoryFromTab(category))
            .toList();
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, i) => ItemListTile(
            item: items[i],
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                enableDrag: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (ctx) => DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.4,
                  maxChildSize: 0.9,
                  expand: false,
                  builder: (context, scrollController) => SingleChildScrollView(
                    controller: scrollController,
                    child: ItemBottomSheet(
                      item: items[i].copyWith(quantity: 1),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Category _categoryFromTab(String tab) {
    switch (tab) {
      case 'Pizzalar':
        return Category.pizza;
      case 'Kebaplar':
        return Category.kebab;
      case 'İçecekler':
        return Category.drink;
      case 'Tatlılar':
        return Category.dessert;
      default:
        return Category.pizza;
    }
  }
}
