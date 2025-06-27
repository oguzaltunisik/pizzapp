import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../models/enums.dart';
import '../providers/cart_provider.dart';
import 'quantity_badge.dart';

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
      extraToppings: widget.item.extraToppings != null
          ? Map.from(widget.item.extraToppings!)
          : null,
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
    final currentExtra = widget.item.extraToppings ?? {};
    final originalExtra = _originalItem.extraToppings ?? {};

    if (currentExtra.length != originalExtra.length) {
      return true;
    }

    for (final entry in currentExtra.entries) {
      if (originalExtra[entry.key] != entry.value) {
        return true;
      }
    }

    for (final entry in originalExtra.entries) {
      if (currentExtra[entry.key] != entry.value) {
        return true;
      }
    }

    return false;
  }

  void _toggleExtraTopping(Toppings t, bool? checked) {
    setState(() {
      if (checked == true) {
        widget.item.extraToppings?[t] =
            (widget.item.extraToppings?[t] ?? 0) + 1;
      } else {
        widget.item.extraToppings?.remove(t);
      }
    });
  }

  void _showDeleteDialog() {
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
              final cart = Provider.of<CartProvider>(context, listen: false);
              cart.removeItem(widget.cartItemId!);
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ürün sepetten silindi')),
              );
            },
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: IconButton(
              icon: const Icon(Icons.close, size: 24),
              onPressed: () => Navigator.of(context).pop(),
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                shape: const CircleBorder(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(widget.item.image, style: const TextStyle(fontSize: 44)),
        ),
        const SizedBox(height: 12),
        Text(
          widget.item.name,
          style:
              Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ) ??
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          textAlign: TextAlign.center,
        ),
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
                        showCheckmark: false,
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
                        backgroundColor:
                            (widget.item.removedToppings?.contains(t) ?? false)
                            ? Colors.red.shade50
                            : null,
                        selectedColor:
                            (widget.item.removedToppings?.contains(t) ?? false)
                            ? Colors.red.shade100
                            : null,
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
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: Toppings.values
                    .where((t) => !(widget.item.toppings?.contains(t) ?? false))
                    .map(
                      (t) => ListTile(
                        title: Text(
                          t.label,
                          style: TextStyle(
                            color: widget.item.extraToppings?[t] != null
                                ? Colors.green.shade700
                                : null,
                            fontWeight: widget.item.extraToppings?[t] != null
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          '+${t.price.toStringAsFixed(1)}₺',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        trailing: (widget.item.extraToppings?[t] ?? 0) > 0
                            ? QuantityBadge(
                                quantity: widget.item.extraToppings![t]!,
                                showButtons: true,
                                onQuantityChanged: (val) {
                                  setState(() {
                                    if (val > 0) {
                                      widget.item.extraToppings?[t] = val;
                                    } else {
                                      widget.item.extraToppings?.remove(t);
                                    }
                                  });
                                },
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.check_box_outline_blank,
                                  size: 24,
                                ),
                                onPressed: () => _toggleExtraTopping(t, true),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                        onTap: () {
                          if ((widget.item.extraToppings?[t] ?? 0) > 0) {
                            _toggleExtraTopping(t, false);
                          } else {
                            _toggleExtraTopping(t, true);
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          )
        else
          Text(
            widget.item.description ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        const SizedBox(height: 16),
        Row(
          children: [
            QuantityBadge(
              quantity: _quantity,
              showButtons: true,
              cartId: widget.cartItemId,
              onDelete: _showDeleteDialog,
              onQuantityChanged: (val) {
                setState(() {
                  _quantity = val;
                });
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                label: Text(
                  '${widget.cartItemId != null ? 'Güncelle' : 'Sepete Ekle'} ${(widget.item.totalPrice * _quantity).toStringAsFixed(2)}₺',
                ),
                icon: Icon(
                  widget.cartItemId != null
                      ? Icons.edit
                      : Icons.add_shopping_cart,
                ),
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}
