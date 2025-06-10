import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductBottomSheet extends StatefulWidget {
  final Product product;

  const ProductBottomSheet({super.key, required this.product});

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.product.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _quantity > 1
                    ? () => setState(() => _quantity--)
                    : null,
              ),
              Text('$_quantity', style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() => _quantity++),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(widget.product.price * _quantity).toStringAsFixed(2)} ₺',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  final cart = Provider.of<CartProvider>(
                    context,
                    listen: false,
                  );
                  for (var i = 0; i < _quantity; i++) {
                    cart.addItem(widget.product);
                  }
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ürün sepete eklendi')),
                  );
                },
                child: const Text('Sepete Ekle'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
