import 'package:flutter/material.dart';
import '../models/npm_token_config.dart';

class TokenExecutionCard extends StatelessWidget {
  final NpmTokenConfig config;
  final VoidCallback onRefresh;

  const TokenExecutionCard({
    super.key,
    required this.config,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPassing = config.processExecutionAccuracy >= 0.90;

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NPM Token Integration',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  avatar: Icon(
                    isPassing ? Icons.check_circle : Icons.error,
                    color: isPassing ? Colors.green : Colors.red,
                    size: 18,
                  ),
                  label: Text(
                    isPassing ? 'Pass' : 'Fail',
                    style: TextStyle(color: isPassing ? Colors.green : Colors.red),
                  ),
                  backgroundColor: isPassing ? Colors.green.shade50 : Colors.red.shade50,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Package: ${config.packageName}', style: theme.textTheme.bodyMedium),
            Text('Registry: ${config.registryUrl}', style: theme.textTheme.bodySmall),
            Text('Version: ${config.version}', style: theme.textTheme.bodySmall),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: config.processExecutionAccuracy,
              backgroundColor: Colors.grey.shade200,
              color: isPassing ? Colors.blue : Colors.red,
            ),
            const SizedBox(height: 8),
            Text(
              'Accuracy: ${(config.processExecutionAccuracy * 100).toStringAsFixed(1)}% (Floor: 90%)',
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.sync),
                label: const Text('Re-validate NPM Tokens'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
