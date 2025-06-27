import 'package:flutter/material.dart';

class QuantityBadge extends StatelessWidget {
  final int quantity;
  final bool showButtons;
  final void Function(int)? onQuantityChanged;
  final String? cartId;
  final VoidCallback? onDelete;

  const QuantityBadge({
    super.key,
    required this.quantity,
    this.showButtons = false,
    this.onQuantityChanged,
    this.cartId,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const badgeColor = Color(0xFFFFE0B2); // Açık turuncu
    const textColor = Color(0xFFEF6C00); // Deep orange
    return Container(
      padding: showButtons
          ? const EdgeInsets.symmetric(horizontal: 2, vertical: 1)
          : const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showButtons)
            IconButton(
              icon: Icon(
                cartId != null && quantity == 1
                    ? Icons.delete
                    : Icons.remove_circle_outline,
                size: 16,
              ),
              color: textColor,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: cartId != null && quantity == 1
                  ? onDelete
                  : quantity > 1 && onQuantityChanged != null
                  ? () => onQuantityChanged!(quantity - 1)
                  : null,
              tooltip: 'Azalt',
            ),
          Padding(
            padding: showButtons
                ? const EdgeInsets.symmetric(horizontal: 4)
                : EdgeInsets.zero,
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: textColor,
                letterSpacing: 0.2,
              ),
            ),
          ),
          if (showButtons)
            IconButton(
              icon: const Icon(Icons.add_circle_outline, size: 16),
              color: textColor,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onQuantityChanged != null
                  ? () => onQuantityChanged!(quantity + 1)
                  : null,
              tooltip: 'Arttır',
            ),
        ],
      ),
    );
  }
}
