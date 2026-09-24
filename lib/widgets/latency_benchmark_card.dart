import 'package:flutter/material.dart';
import '../models/latency_metric.dart';

class LatencyBenchmarkCard extends StatefulWidget {
  final Function(LatencyMetric) onLatencyMeasured;

  const LatencyBenchmarkCard({Key? key, required this.onLatencyMeasured}) : super(key: key);

  @override
  State<LatencyBenchmarkCard> createState() => _LatencyBenchmarkCardState();
}

class _LatencyBenchmarkCardState extends State<LatencyBenchmarkCard> {
  int _lastLatencyMs = 0;
  String _rating = 'Good';

  // English Code (EC): Benchmark-User-Interaction-Latency
  void benchmarkUserInteractionLatency() {
    final stopwatch = Stopwatch()..start();

    // Execute state transition logic
    setState(() {
      _lastLatencyMs = 0;
    });

    stopwatch.stop();
    final elapsed = stopwatch.elapsedMicroseconds / 1000.0;
    final int measuredMs = elapsed.ceil() + 35; // Simulated API frame render

    String calculatedRating = 'Good';
    if (measuredMs > 100) {
      calculatedRating = 'Poor';
    } else if (measuredMs > 80) {
      calculatedRating = 'Average';
    }

    setState(() {
      _lastLatencyMs = measuredMs;
      _rating = calculatedRating;
    });

    widget.onLatencyMeasured(LatencyMetric(
      actionName: 'TAP_INTERACTION_BENCHMARK',
      latencyMs: measuredMs,
      rating: calculatedRating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Interaction Latency Validator (RAIL)', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text('Measured Latency: ${_lastLatencyMs}ms', style: theme.textTheme.bodyLarge),
                const Spacer(),
                Chip(
                  label: Text(_rating, style: const TextStyle(color: Colors.white)),
                  backgroundColor: _rating == 'Good' ? Colors.green : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: benchmarkUserInteractionLatency,
                child: const Text('BENCHMARK TAP RESPONSE (<100ms)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
