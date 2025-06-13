import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../data/mock_data.dart';
import '../widgets/item_bottom_sheet.dart';
import 'profile_screen.dart';

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
          bottom: const TabBar(
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
      ),
    );
  }

  Widget _buildItemList(String category) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final items = MockData.items
            .where((item) => item.category == category)
            .toList();
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, i) => Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(items[i].name),
              subtitle: Text(
                items[i].category == 'Pizzalar' && items[i].toppings != null
                    ? items[i].toppings!.map((t) => t.label).join(', ')
                    : items[i].description,
              ),
              trailing: Text(
                '${items[i].price.toStringAsFixed(2)} ₺',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => ItemBottomSheet(item: items[i].copy()),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
