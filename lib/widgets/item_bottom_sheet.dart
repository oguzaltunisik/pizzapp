import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../models/enums.dart';
import '../providers/cart_provider.dart';

class ItemBottomSheet extends StatefulWidget {
  final Item item;
  final String? cartItemId;
  final int? initialQuantity;

  const ItemBottomSheet({
    super.key,
    required this.item,
    this.cartItemId,
    this.initialQuantity,
  });

  @override
  State<ItemBottomSheet> createState() => _ItemBottomSheetState();
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {
  late int _quantity;
  late Item _originalItem;

  @override
  void initState() {
    super.initState();
    _quantity =
        widget.initialQuantity ??
        (widget.item.quantity != 0 ? widget.item.quantity : 1);
    _originalItem = widget.item.copyWith(
      quantity: _quantity,
      removedToppings: widget.item.removedToppings?.toList(),
      extraToppings: widget.item.extraToppings?.toList(),
    );
  }

  bool get _hasChanged {
    if (_quantity != _originalItem.quantity) {
      return true;
    }
    if ((widget.item.removedToppings ?? []).length !=
        (_originalItem.removedToppings ?? []).length) {
      return true;
    }
    if ((widget.item.extraToppings ?? []).length !=
        (_originalItem.extraToppings ?? []).length) {
      return true;
    }
    if (!(widget.item.removedToppings?.toSet().containsAll(
              _originalItem.removedToppings ?? [],
            ) ??
            true) ||
        !(_originalItem.removedToppings?.toSet().containsAll(
              widget.item.removedToppings ?? [],
            ) ??
            true)) {
      return true;
    }
    if (!(widget.item.extraToppings?.toSet().containsAll(
              _originalItem.extraToppings ?? [],
            ) ??
            true) ||
        !(_originalItem.extraToppings?.toSet().containsAll(
              widget.item.extraToppings ?? [],
            ) ??
            true)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.item.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (widget.item.toppings != null && widget.item.toppings!.isNotEmpty)
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
                                '+${Item.extraToppingPrice.toStringAsFixed(2)}€',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      (widget.item.extraToppings?.contains(t) ??
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
            children: [
              Card(
                child: Row(
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: widget.cartItemId != null && _quantity == 1
                          ? const Icon(Icons.delete, color: Colors.red)
                          : const Icon(Icons.remove_circle_outline),
                      onPressed: widget.cartItemId != null && _quantity == 1
                          ? () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Ürünü Sil'),
                                  content: const Text(
                                    'Bu ürünü sepetten silmek istediğinize emin misiniz?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: const Text('İptal'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final cart = Provider.of<CartProvider>(
                                          context,
                                          listen: false,
                                        );
                                        cart.removeItem(widget.cartItemId!);
                                        Navigator.of(ctx).pop();
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Ürün sepetten silindi',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Sil'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                    ),
                    Text(
                      '$_quantity',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => setState(() => _quantity++),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: widget.cartItemId != null && !_hasChanged
                    ? null
                    : () {
                        final cart = Provider.of<CartProvider>(
                          context,
                          listen: false,
                        );
                        if (widget.cartItemId != null) {
                          cart.updateItem(
                            widget.cartItemId!,
                            widget.item,
                            _quantity,
                          );
                        } else {
                          cart.addItem(widget.item);
                          cart.updateItem(
                            cart.items.keys.last,
                            widget.item,
                            _quantity,
                          );
                        }
                        Navigator.of(context).pop();
                      },
                child: Text(
                  '${widget.cartItemId != null ? 'Güncelle' : 'Sepete Ekle'} ${(widget.item.totalPrice * _quantity).toStringAsFixed(2)}€',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
