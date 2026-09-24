import 'package:flutter/material.dart';
import '../models/circuit_breaker_model.dart';

class CircuitStatusCard extends StatelessWidget {
  final CircuitBreakerModel model;
  final VoidCallback onSimulateErrorSpike;
  final VoidCallback onReset;

  const CircuitStatusCard({
    Key? key,
    required this.model,
    required this.onSimulateErrorSpike,
    required this.onReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOpen = model.circuitState == 'OPEN';

    return Card(
      elevation: 3,
      color: isOpen ? theme.colorScheme.errorContainer : theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Circuit Breaker Status', style: theme.textTheme.titleMedium),
                Chip(
                  label: Text(model.circuitState),
                  backgroundColor: isOpen ? Colors.red : Colors.green.shade100,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Rolling Window: ${model.windowMinutes} Minutes'),
            Text('Current Error Rate: ${model.errorRatePercentage.toStringAsFixed(2)}%'),
            Text('Threshold: ${model.thresholdPercentage}%'),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: onSimulateErrorSpike,
                  child: const Text('Simulate >2% Error Spike'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: onReset,
                  child: const Text('Reset Circuit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
