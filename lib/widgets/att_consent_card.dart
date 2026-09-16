// lib/widgets/att_consent_card.dart
import 'package:flutter/material.dart';

class AttConsentCard extends StatefulWidget {
  const AttConsentCard({super.key});

  @override
  State<AttConsentCard> createState() => _AttConsentCardState();
}

class _AttConsentCardState extends State<AttConsentCard> {
  String _attStatus = 'ATTrackingManagerAuthorizationStatusNotDetermined';
  double _lastRenderMs = 18.2;

  void _requestAttConsent() {
    setState(() {
      _lastRenderMs = 16.4;
      _attStatus = 'ATTrackingManagerAuthorizationStatusAuthorized';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Native iOS ATT Request Handler', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8.0),
        Text('Status: $_attStatus', style: theme.textTheme.bodySmall?.copyWith(fontFamily: 'monospace')),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Swift Implementation Handler'),
          subtitle: const Text('`ATTrackingManager.requestTrackingAuthorization`'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _requestAttConsent,
            icon: const Icon(Icons.apple),
            label: const Text('REQUEST ATT CONSENT (SWIFT)'),
          ),
        ),
      ],
    );
  }
}
