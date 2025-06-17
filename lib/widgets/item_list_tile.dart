import 'package:flutter/material.dart';
import '../models/item.dart';
import 'quantity_badge.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final VoidCallback? onTap;

  const ItemListTile({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool showQuantity = item.quantity > 0;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ) ??
                          const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                    ),
                    const SizedBox(height: 4),
                    if (!showQuantity) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.toppings != null &&
                              item.toppings!.isNotEmpty)
                            Text(
                              item.toppings!.map((t) => t.label).join(', '),
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.65),
                                    fontSize: 13,
                                  ) ??
                                  TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (item.description != null &&
                              item.description!.isNotEmpty)
                            Text(
                              item.description!,
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.5),
                                    fontSize: 12,
                                  ) ??
                                  TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ] else ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.toppings != null &&
                              item.toppings!.isNotEmpty)
                            Text(
                              item.toppings!
                                  .where(
                                    (t) =>
                                        !(item.removedToppings?.contains(t) ??
                                            false),
                                  )
                                  .map((t) => t.label)
                                  .join(', '),
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.8),
                                    fontSize: 13,
                                  ) ??
                                  TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 13,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (item.removedToppings != null &&
                              item.removedToppings!.isNotEmpty)
                            Text(
                              item.removedToppings!
                                  .map((t) => t.label)
                                  .join(', '),
                              style: const TextStyle(
                                fontSize: 13,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.redAccent,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (item.extraToppings != null &&
                              item.extraToppings!.isNotEmpty)
                            Text(
                              item.extraToppings!
                                  .map((t) => t.label)
                                  .join(', '),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    showQuantity
                        ? '${item.totalPrice.toStringAsFixed(2)} ₺'
                        : '${item.price.toStringAsFixed(2)} ₺',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  if (showQuantity) ...[
                    const SizedBox(height: 4),
                    QuantityBadge(quantity: item.quantity),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
