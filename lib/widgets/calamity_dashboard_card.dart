import 'package:flutter/material.dart';
import '../models/calamity_alert_model.dart';

class CalamityDashboardCard extends StatelessWidget {
  final CalamityAlertModel model;
  final ValueChanged<String> OnResolveSubmitted;

  const CalamityDashboardCard({
    Key? key,
    required this.model,
    required this.OnResolveSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController codeController = TextEditingController();

    return Card(
      color: model.isCleared ? theme.colorScheme.surface : theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  model.isCleared ? Icons.check_circle : Icons.warning,
                  color: model.isCleared ? Colors.green : theme.colorScheme.error,
                ),
                const SizedBox(width: 8),
                Text('CALAMITY ALERT: ${model.alertId}', style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            Text(model.description),
            const SizedBox(height: 12),
            if (!model.isCleared) ...[
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Enter Verified Logic Fix',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => OnResolveSubmitted(codeController.text),
                child: const Text('Submit Fix & Clear Alert'),
              ),
            ] else
              const Text('Alert Cleared via Validated Technical Logic Rewrite.',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
