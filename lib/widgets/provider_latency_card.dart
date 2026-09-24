import 'package:flutter/material.dart';
import '../models/provider_latency_model.dart';

class ProviderLatencyCard extends StatelessWidget {
  final ProviderLatencyModel model;
  final VoidCallback onRefresh;

  const ProviderLatencyCard({
    Key? key,
    required this.model,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Provider SLA: \${model.providerId}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Avg Latency', style: theme.textTheme.bodySmall),
                    Text('\${model.responseSlaMinutes.toStringAsFixed(1)} min', style: theme.textTheme.titleLarge),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Engagement', style: theme.textTheme.bodySmall),
                    Text('\${(model.engagementRate * 100).toStringAsFixed(1)}%', style: theme.textTheme.titleLarge),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: OutlinedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh Dashboard Telemetry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
