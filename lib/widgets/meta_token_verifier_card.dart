// lib/widgets/meta_token_verifier_card.dart
import 'package:flutter/material.dart';

class MetaTokenVerifierCard extends StatefulWidget {
  const MetaTokenVerifierCard({super.key});

  @override
  State<MetaTokenVerifierCard> createState() => _MetaTokenVerifierCardState();
}

class _MetaTokenVerifierCardState extends State<MetaTokenVerifierCard> {
  bool _isVerified = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Meta Events Manager Credentials', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Dataset ID: 884029311029'),
          subtitle: const Text('System User Access Token Scope: ads_management, events_delivery'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.vpn_key),
            label: const Text('RE-VERIFY CAPI SYSTEM TOKEN'),
          ),
        ),
      ],
    );
  }
}
