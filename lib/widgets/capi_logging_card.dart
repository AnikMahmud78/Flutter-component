// lib/widgets/capi_logging_card.dart
import 'package:flutter/material.dart';

class CapiLoggingCard extends StatelessWidget {
  const CapiLoggingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CAPI Dispatch Telemetry Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('event_id: EVT-META-8840129', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('emq_score: 8.7 / 10.0 (High Precision)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('deduplication_status: DEDUP_MATCH_PASSED', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.analytics),
            label: const Text('DISPATCH & LOG CAPI EVENT'),
          ),
        ),
      ],
    );
  }
}
