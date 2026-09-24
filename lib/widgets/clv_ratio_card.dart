import 'package:flutter/material.dart';
import '../models/clv_economics_model.dart';

class ClvRatioCard extends StatelessWidget {
  final ClvEconomicsModel model;
  final VoidCallback onRefresh;

  const ClvRatioCard({
    super.key,
    required this.model,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CLV: \\$\${model.clvValue.toStringAsFixed(2)} | CAC: \\$\${model.cacValue.toStringAsFixed(2)}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('CLV:CAC Ratio: \${model.ratio.toStringAsFixed(2)}:1 (Target: ≥3.0:1)'),
            Text('Status: \${model.status.name.toUpperCase()}'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Recalculate Unit Economics'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
