// lib/widgets/cart_integrity_banner.dart
import 'package:flutter/material.dart';

class CartIntegrityBanner extends StatelessWidget {
  final String status;
  final double integrityRate;

  const CartIntegrityBanner({
    super.key,
    required this.status,
    required this.integrityRate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPass ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            isPass ? Icons.shopping_cart : Icons.error,
            color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cart Integrity: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Integrity Rate: ${(integrityRate * 100).toInt()}% (ISO/IEC 25010 Reliability)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
