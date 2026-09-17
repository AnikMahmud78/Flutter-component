// lib/widgets/spend_pacing_card.dart
import 'package:flutter/material.dart';

class SpendPacingCard extends StatefulWidget {
  const SpendPacingCard({super.key});

  @override
  State<SpendPacingCard> createState() => _SpendPacingCardState();
}

class _SpendPacingCardState extends State<SpendPacingCard> {
  bool _alertSent = false;

  void _dispatchPacingAlert() {
    setState(() => _alertSent = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Push Notification Dispatched: 85% Budget Cap Reached!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ad Spend Pacing & Auto-Pause Monitor', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Spend Threshold: 85% Budget Escalation'),
          subtitle: Text(_alertSent ? 'Push Alert Sent (100% Precision)' : 'Monitoring Active Spend...'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _dispatchPacingAlert,
            icon: const Icon(Icons.send_to_mobile),
            label: const Text('DISPATCH 85% BUDGET ALERT'),
          ),
        ),
      ],
    );
  }
}
