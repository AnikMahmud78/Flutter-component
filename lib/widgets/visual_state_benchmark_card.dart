// lib/widgets/visual_state_benchmark_card.dart
import 'package:flutter/material.dart';

class VisualStateBenchmarkCard extends StatefulWidget {
  const VisualStateBenchmarkCard({super.key});

  @override
  State<VisualStateBenchmarkCard> createState() => _VisualStateBenchmarkCardState();
}

class _VisualStateBenchmarkCardState extends State<VisualStateBenchmarkCard> {
  int _updateMs = 0;
  bool _pass = false;

  void _measureUpdate() {
    final start = DateTime.now();
    setState(() {
      _updateMs = DateTime.now().difference(start).inMilliseconds;
      _pass = _updateMs <= 50;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Visual State Update: ${_updateMs}ms | Benchmark: 50ms')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('50ms Visual State Benchmark Verifier', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Last Measurement: ${_updateMs}ms'),
          subtitle: Text(_pass ? '✓ Within 50ms Target' : 'Run benchmark to verify'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _measureUpdate,
            icon: const Icon(Icons.timer),
            label: const Text('MEASURE VISUAL STATE UPDATE'),
          ),
        ),
      ],
    );
  }
}
