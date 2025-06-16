import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../models/enums.dart';
import '../providers/cart_provider.dart';

class ItemBottomSheet extends StatefulWidget {
  final Item item;

  const ItemBottomSheet({super.key, required this.item});

  @override
  State<ItemBottomSheet> createState() => _ItemBottomSheetState();
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (widget.item.category == Category.pizzas &&
                widget.item.toppings != null)
              Column(
                children: [
                  const Text(
                    'Malzemeler:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children: widget.item.toppings!
                        .map(
                          (t) => ChoiceChip(
                            label: Text(
                              t.label,
                              style: TextStyle(
                                decoration:
                                    (widget.item.removedToppings?.contains(t) ??
                                        false)
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            selected:
                                !(widget.item.removedToppings?.contains(t) ??
                                    false),
                            onSelected: (selected) {
                              setState(() {
                                if (!selected) {
                                  widget.item.removedToppings?.add(t);
                                } else {
                                  widget.item.removedToppings?.remove(t);
                                }
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ekstra Malzemeler:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children: Toppings.values
                        .where(
                          (t) => !(widget.item.toppings?.contains(t) ?? false),
                        )
                        .map(
                          (t) => ChoiceChip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(t.label),
                                const SizedBox(width: 4),
                                Text(
                                  '+${Item.extraToppingPrice.toStringAsFixed(2)}₺',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        (widget.item.extraToppings?.contains(
                                              t,
                                            ) ??
                                            false)
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            selected:
                                widget.item.extraToppings?.contains(t) ?? false,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  widget.item.extraToppings?.add(t);
                                } else {
                                  widget.item.extraToppings?.remove(t);
                                }
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              )
            else
              Text(
                widget.item.description,
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
                Text(
                  '$_quantity',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
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
                  '${(widget.item.totalPrice * _quantity).toStringAsFixed(2)} ₺',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton(
                  onPressed: () {
                    final cart = Provider.of<CartProvider>(
                      context,
                      listen: false,
                    );
                    for (var i = 0; i < _quantity; i++) {
                      cart.addItem(widget.item);
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
      ),
    );
  }
}
