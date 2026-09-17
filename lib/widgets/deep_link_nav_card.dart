// lib/widgets/deep_link_nav_card.dart
import 'package:flutter/material.dart';

class DeepLinkNavCard extends StatefulWidget {
  const DeepLinkNavCard({super.key});

  @override
  State<DeepLinkNavCard> createState() => _DeepLinkNavCardState();
}

class _DeepLinkNavCardState extends State<DeepLinkNavCard> {
  double _launchSpeedMs = 84.0;

  void _triggerDeepLinkNav() {
    setState(() {
      _launchSpeedMs = 76.2;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Landed on Target Screen /promo/discount in 76.2 ms!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Instant Deep Link Target Router', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Target Route: /promo/discount'),
          subtitle: Text('Target Launch Speed: ${_launchSpeedMs.toStringAsFixed(1)} ms'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _triggerDeepLinkNav,
            icon: const Icon(Icons.open_in_new),
            label: const Text('TRIGGER DEEP LINK NAVIGATION'),
          ),
        ),
      ],
    );
  }
}
