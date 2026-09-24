import 'package:flutter/material.dart';
import '../models/grouped_metric.dart';

class MetricProximityGroup extends StatelessWidget {
  final String groupTitle;
  final List<GroupedMetric> metrics;

  const MetricProximityGroup({
    Key? key,
    required this.groupTitle,
    required this.metrics,
  }) : super(key: key);

  // English Code (EC): Render-Proximity-Card-Group
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // 16px metric increment
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(groupTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(height: 16.0),
            Wrap(
              spacing: 12.0, // Internal proximity spacing
              runSpacing: 12.0,
              children: metrics.map((metric) {
                return Container(
                  width: 140,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(metric.title, style: theme.textTheme.labelSmall),
                      const SizedBox(height: 4.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(metric.value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 2.0),
                          Text(metric.unit, style: theme.textTheme.labelSmall),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        metric.status,
                        style: TextStyle(
                          fontSize: 10,
                          color: metric.status == 'Real-time' ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
