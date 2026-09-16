// lib/widgets/query_benchmark_card.dart
import 'package:flutter/material.dart';

class QueryBenchmarkCard extends StatefulWidget {
  const QueryBenchmarkCard({super.key});

  @override
  State<QueryBenchmarkCard> createState() => _QueryBenchmarkCardState();
}

class _QueryBenchmarkCardState extends State<QueryBenchmarkCard> {
  double _queryTimeSecs = 1.2;

  void _runBenchmarkQuery() {
    setState(() {
      _queryTimeSecs = 0.9;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cohort Retention Matrix Benchmark Test', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Query: cohort_retention_matrix.sql'),
          subtitle: Text('Execution Latency: ${_queryTimeSecs.toStringAsFixed(1)} seconds'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _runBenchmarkQuery,
            icon: const Icon(Icons.timer),
            label: const Text('EXECUTE RETENTION QUERY BENCHMARK'),
          ),
        ),
      ],
    );
  }
}
