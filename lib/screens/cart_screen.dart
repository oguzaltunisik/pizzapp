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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.item.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                if (item.item.category == 'Pizzalar' &&
                                    item.item.toppings != null) ...[
                                  const SizedBox(height: 4),
                                  Wrap(
                                    spacing: 4,
                                    children: [
                                      ...item.item.toppings!
                                          .where(
                                            (t) =>
                                                !(item.item.removedToppings
                                                        ?.contains(t) ??
                                                    false),
                                          )
                                          .map(
                                            (t) => Chip(
                                              label: Text(
                                                t.label,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              padding: EdgeInsets.zero,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                          ),
                                      if (item.item.extraToppings?.isNotEmpty ??
                                          false) ...[
                                        const Text(
                                          ' + ',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        ...item.item.extraToppings!.map(
                                          (t) => Chip(
                                            label: Text(
                                              t.label,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            padding: EdgeInsets.zero,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${item.item.totalPrice.toStringAsFixed(2)} ₺',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      cart.updateQuantity(
                                        item.item.id,
                                        item.quantity - 1,
                                      );
                                    },
                                  ),
                                  Text('${item.quantity}'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      cart.updateQuantity(
                                        item.item.id,
                                        item.quantity + 1,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (item.item.category == 'Pizzalar' &&
                          item.item.removedToppings != null &&
                          item.item.removedToppings!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Çıkarılan: ${item.item.removedToppings!.map((t) => t.label).join(', ')}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                        ),
                      ],
                    ],
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
