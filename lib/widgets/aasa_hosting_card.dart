// lib/widgets/aasa_hosting_card.dart
import 'package:flutter/material.dart';

class AasaHostingCard extends StatelessWidget {
  const AasaHostingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Universal Link AASA File Endpoint', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('https://link.habot.io/.well-known/apple-app-site-association'),
          subtitle: const Text('Header: Content-Type: application/json | SSL: Valid'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.link),
            label: const Text('TEST DEFERRED DEEP LINK HANDSHAKE'),
          ),
        ),
      ],
    );
  }
}
