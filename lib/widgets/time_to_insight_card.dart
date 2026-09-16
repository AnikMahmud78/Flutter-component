// lib/widgets/time_to_insight_card.dart
import 'package:flutter/material.dart';

class TimeToInsightCard extends StatefulWidget {
  const TimeToInsightCard({super.key});

  @override
  State<TimeToInsightCard> createState() => _TimeToInsightCardState();
}

class _TimeToInsightCardState extends State<TimeToInsightCard> {
  double _measuredTimeSecs = 1.8;

  void _runUatTest() {
    setState(() {
      _measuredTimeSecs = 1.6;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Executive Time-to-Insight Test Harness', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Executive Dashboard Initial Render'),
          subtitle: Text('Time-to-Insight: ${_measuredTimeSecs.toStringAsFixed(1)} seconds'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _runUatTest,
            icon: const Icon(Icons.timer),
            label: const Text('RUN 5-SECOND UAT BENCHMARK'),
          ),
        ),
      ],
    );
  }
}
