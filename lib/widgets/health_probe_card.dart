// lib/widgets/health_probe_card.dart
import 'package:flutter/material.dart';

class HealthProbeCard extends StatelessWidget {
  const HealthProbeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Automated System Health Probe (health_probes.py)', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Liveness & Readiness Handshake'),
          subtitle: const Text('health_probes.py verified under PEP 8 Conventions'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.verified),
            label: const Text('VERIFY HEALTH PROBES SYNTAX'),
          ),
        ),
      ],
    );
  }
}
