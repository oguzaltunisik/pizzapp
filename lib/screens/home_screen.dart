import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../data/mock_data.dart';
import '../widgets/product_bottom_sheet.dart';
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
            _buildProductList('Pizzalar'),
            _buildProductList('Kebaplar'),
            _buildProductList('İçecekler'),
            _buildProductList('Tatlılar'),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(String category) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final products = MockData.products
            .where((product) => product.category == category)
            .toList();
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, i) => Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(products[i].name),
              subtitle: Text(products[i].description),
              trailing: Text(
                '${products[i].price.toStringAsFixed(2)} ₺',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => ProductBottomSheet(product: products[i]),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
