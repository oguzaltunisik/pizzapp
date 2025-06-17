import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../models/enums.dart';
import '../providers/cart_provider.dart';
import '../widgets/bottom_action_button.dart';
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

  void _toggleExtraTopping(Toppings t, bool? checked) {
    setState(() {
      if (checked == true) {
        widget.item.extraToppings?.add(t);
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
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                        leading: Checkbox(
                          value: widget.item.extraToppings?.contains(t) == true,
                          onChanged: (checked) =>
                              _toggleExtraTopping(t, checked),
                        ),
                        title: Text(t.label),
                        trailing: Text(
                          '+${Item.extraToppingPrice.toStringAsFixed(2)}€',
                          style: TextStyle(
                            fontSize: 13,
                            color:
                                widget.item.extraToppings?.contains(t) == true
                                ? primaryColor
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                        onTap: () => _toggleExtraTopping(
                          t,
                          !(widget.item.extraToppings?.contains(t) ?? false),
                        ),
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
            Spacer(),
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
            Spacer(),
          ],
        ),
        BottomActionButton(
          label:
              '${widget.cartItemId != null ? 'Güncelle' : 'Sepete Ekle'} ${(widget.item.totalPrice * _quantity).toStringAsFixed(2)}€',
          icon: widget.cartItemId != null
              ? Icons.edit
              : Icons.add_shopping_cart,
          onPressed: widget.cartItemId != null && !_hasChanged
              ? null
              : () {
                  final cart = Provider.of<CartProvider>(
                    context,
                    listen: false,
                  );
                  if (widget.cartItemId != null) {
                    cart.updateItem(widget.cartItemId!, widget.item, _quantity);
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
      ],
    );
  }
}
