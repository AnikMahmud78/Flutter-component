import 'package:flutter/material.dart';
import '../models/plain_language_model.dart';

class PlainTextCard extends StatelessWidget {
  final PlainLanguageModel model;
  final VoidCallback onReCheck;

  const PlainTextCard({
    super.key,
    required this.model,
    required this.onReCheck,
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
            Text('Sample UI Text:', style: theme.textTheme.titleSmall),
            const SizedBox(height: 4.0),
            Text('"\${model.sampleText}"', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8.0),
            Text('Readability Score: \${model.readabilityScore}'),
            Text('MD3 Plain Language Standard: \${model.satisfiesMd3Guidelines ? "PASSED" : "FAILED"}'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onReCheck,
                icon: const Icon(Icons.spellcheck),
                label: const Text('Re-evaluate Definitions'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
