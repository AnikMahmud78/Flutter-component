// lib/widgets/anomaly_detector_card.dart
import 'package:flutter/material.dart';

class AnomalyDetectorCard extends StatefulWidget {
  const AnomalyDetectorCard({super.key});

  @override
  State<AnomalyDetectorCard> createState() => _AnomalyDetectorCardState();
}

class _AnomalyDetectorCardState extends State<AnomalyDetectorCard> {
  bool _anomalyDetected = false;

  void _simulateSpendAnomaly() {
    setState(() => _anomalyDetected = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Simulated spend anomaly detected in 12 minutes!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Spend Anomaly Detection Rules Engine', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Rule: Spend Variance > 25% in 1 Hour'),
          subtitle: Text(_anomalyDetected ? 'Anomaly Identified (12m)' : 'Monitoring Active'),
          trailing: Icon(
            _anomalyDetected ? Icons.warning : Icons.check_circle,
            color: _anomalyDetected ? theme.colorScheme.error : theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _simulateSpendAnomaly,
            icon: const Icon(Icons.bolt),
            label: const Text('SIMULATE SPEND ANOMALY'),
          ),
        ),
      ],
    );
  }
}
