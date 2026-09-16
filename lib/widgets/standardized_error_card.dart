// lib/widgets/standardized_error_card.dart
// Task GEN-00136: Error Payload Schema Standardization Engine
import 'package:flutter/material.dart';

class StandardizedErrorCard extends StatelessWidget {
  const StandardizedErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Standardized Error Payload Sample', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: theme.colorScheme.error),
              ),
              child: const Text(
                '{\n  "errorCode": "ERR_VALIDATION_FAILED",\n  "message": "Field target cannot be null",\n  "timestamp": "2026-09-16T11:33:26.000Z"\n}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                icon: const Icon(Icons.code),
                label: const Text('PARSE ERROR PAYLOAD'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
