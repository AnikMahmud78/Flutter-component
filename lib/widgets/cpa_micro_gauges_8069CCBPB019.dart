import 'package:flutter/material.dart';

class CpaMicroGauges8069CCBPB019 extends StatelessWidget {
  const CpaMicroGauges8069CCBPB019({super.key});

  static const _gauges = [
    (label: 'Cost per action', value: 0.64, detail: '\$12.80 / action'),
    (label: 'Budget consumed', value: 0.82, detail: '82% of allocation'),
    (label: 'Action completion', value: 0.91, detail: '91% successful'),
  ];

  Color _statusColor(BuildContext context, double value) {
    final scheme = Theme.of(context).colorScheme;
    if (value >= 1) return scheme.error;
    if (value >= 0.8) return Colors.deepOrange;
    if (value >= 0.5) return Colors.amber.shade800;
    return scheme.primary;
  }

  String _statusLabel(double value) {
    if (value >= 1) return 'CRITICAL';
    if (value >= 0.8) return 'ELEVATED';
    if (value >= 0.5) return 'EARLY';
    return 'NORMAL';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('CPA Micro-Gauges')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card.filled(
            color: colorScheme.surfaceContainerHighest,
            child: const ListTile(
              leading: Icon(Icons.speed_rounded),
              title: Text('8069CCBPB-019'),
              subtitle: Text(
                'Implementation Step 10: CPA (Cost-Per-Action) Micro-Gauges',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Cost-Per-Action Health',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ..._gauges.map(
            (gauge) => Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 64,
                      height: 64,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: gauge.value,
                            strokeWidth: 7,
                            color: _statusColor(context, gauge.value),
                            backgroundColor: colorScheme.surfaceContainerHighest,
                          ),
                          Text(
                            '${(gauge.value * 100).round()}%',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gauge.label,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(gauge.detail),
                        ],
                      ),
                    ),
                    Chip(
                      label: Text(_statusLabel(gauge.value)),
                      backgroundColor: _statusColor(context, gauge.value)
                          .withAlpha(35),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Card.outlined(
            child: ListTile(
              title: Text('Budget Variance Alert Thresholds'),
              subtitle: Text('50% Early  |  80% Elevated  |  100% Critical'),
            ),
          ),
          const SizedBox(height: 8),
          const Card.outlined(
            child: ListTile(
              title: Text('Widget Specification: Material 3'),
              subtitle: Text('Lightweight micro-visualizations for standard list items.'),
            ),
          ),
        ],
      ),
    );
  }
}
