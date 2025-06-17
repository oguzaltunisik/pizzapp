import 'package:flutter/material.dart';

class QuantityBadge extends StatelessWidget {
  final int quantity;
  const QuantityBadge({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    const badgeColor = Color(0xFFFFE0B2); // Açık turuncu
    const textColor = Color(0xFFEF6C00); // Deep orange
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$quantity adet',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: textColor,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
