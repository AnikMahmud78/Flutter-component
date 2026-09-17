// lib/widgets/deferred_deep_link_card.dart
import 'package:flutter/material.dart';

class DeferredDeepLinkCard extends StatefulWidget {
  const DeferredDeepLinkCard({super.key});

  @override
  State<DeferredDeepLinkCard> createState() => _DeferredDeepLinkCardState();
}

class _DeferredDeepLinkCardState extends State<DeferredDeepLinkCard> {
  String _interceptedRoute = '/checkout/cart?promo=VIP';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Unauthenticated Deep Link Interception', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Captured Route for Post-Auth Restoration'),
          subtitle: Text('Target: $_interceptedRoute'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Context preserved for $_interceptedRoute!')),
              );
            },
            icon: const Icon(Icons.restore_page),
            label: const Text('VERIFY CONTEXT RESTORATION'),
          ),
        ),
      ],
    );
  }
}
