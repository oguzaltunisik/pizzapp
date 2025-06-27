import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/cart_provider.dart';
import 'quantity_badge.dart';
import 'item_bottom_sheet.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final VoidCallback? onTap;

  const ItemListTile({super.key, required this.item, this.onTap});

  void _showBottomSheet(BuildContext context) {
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
            item: item.copyWith(quantity: 1),
            cartItemId: item.cartId,
            initialQuantity: item.quantity > 0 ? item.quantity : 1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showQuantity = item.quantity > 0;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 52,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Text(item.image, style: const TextStyle(fontSize: 30)),
      ),
      title: Text(
        item.name,
        style:
            Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ) ??
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
      ),
      subtitle: !showQuantity
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.toppings != null && item.toppings!.isNotEmpty)
                  Text(
                    item.toppings!.map((t) => t.label).join(', '),
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.65),
                          fontSize: 13,
                        ) ??
                        TextStyle(color: Colors.grey[600], fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (item.description != null && item.description!.isNotEmpty)
                  Text(
                    item.description!,
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.5),
                          fontSize: 12,
                        ) ??
                        TextStyle(color: Colors.grey[500], fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.toppings != null && item.toppings!.isNotEmpty)
                  Text(
                    item.toppings!
                        .where(
                          (t) => !(item.removedToppings?.contains(t) ?? false),
                        )
                        .map((t) => t.label)
                        .join(', '),
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.8),
                          fontSize: 13,
                        ) ??
                        TextStyle(color: Colors.grey[700], fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (item.removedToppings != null &&
                    item.removedToppings!.isNotEmpty)
                  Text(
                    item.removedToppings!.map((t) => t.label).join(', '),
                    style: const TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.redAccent,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (item.extraToppings != null &&
                    item.extraToppings!.isNotEmpty)
                  Text(
                    item.extraToppings!.entries
                        .map((entry) => '${entry.key.label} x${entry.value}')
                        .join(', '),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
      trailing: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (showQuantity)
              QuantityBadge(
                quantity: item.quantity,
                showButtons: item.cartId != null,
                onQuantityChanged: item.cartId != null
                    ? (quantity) {
                        final cart = Provider.of<CartProvider>(
                          context,
                          listen: false,
                        );
                        cart.updateItem(item.cartId!, item, quantity);
                      }
                    : null,
                onDelete: item.cartId != null
                    ? () {
                        final cart = Provider.of<CartProvider>(
                          context,
                          listen: false,
                        );
                        cart.removeItem(item.cartId!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ürün sepetten silindi'),
                          ),
                        );
                      }
                    : null,
              ),
            if (showQuantity) const SizedBox(height: 4),
            Text(
              showQuantity
                  ? '${item.totalPrice.toStringAsFixed(2)}₺'
                  : '${item.price.toStringAsFixed(2)}₺',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      onTap: onTap ?? () => _showBottomSheet(context),
    );
  }
}
