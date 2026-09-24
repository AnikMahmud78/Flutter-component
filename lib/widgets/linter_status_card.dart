import 'package:flutter/material.dart';
import '../models/linter_rule_model.dart';

class LinterStatusCard extends StatelessWidget {
  final LinterRuleModel model;
  final VoidCallback onRunLinter;

  const LinterStatusCard({
    Key? key,
    required this.model,
    required this.onRunLinter,
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
            Text('Linter Engine Rule: \${model.ruleId}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Detection Accuracy: \${(model.detectionAccuracy * 100).toStringAsFixed(1)}%', style: theme.textTheme.bodyMedium),
            Text('Hardcoded Violations Blocked: \${model.totalViolationsBlocked}', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onRunLinter,
                icon: const Icon(Icons.cleaning_services),
                label: const Text('Execute Linter Inspection'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
