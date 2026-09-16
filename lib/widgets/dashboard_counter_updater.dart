// lib/widgets/dashboard_counter_updater.dart
import 'package:flutter/material.dart';

class DashboardCounterUpdater extends StatefulWidget {
  const DashboardCounterUpdater({super.key});

  @override
  State<DashboardCounterUpdater> createState() => _DashboardCounterUpdaterState();
}

class _DashboardCounterUpdaterState extends State<DashboardCounterUpdater> {
  int _counterValue = 1420;
  int _lastLatencyMs = 180;
  bool _isRefreshing = false;

  Future<void> _simulateIngestionEvent() async {
    setState(() => _isRefreshing = true);
    final stopwatch = Stopwatch()..start();
    await Future.delayed(const Duration(milliseconds: 180));
    stopwatch.stop();

    setState(() {
      _counterValue += 1;
      _lastLatencyMs = stopwatch.elapsedMilliseconds;
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mobile Dashboard Live Counter', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$_counterValue',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Chip(
                  label: Text('${_lastLatencyMs}ms'),
                  backgroundColor: theme.colorScheme.surfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: _isRefreshing ? null : _simulateIngestionEvent,
                icon: _isRefreshing
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.refresh),
                label: Text(_isRefreshing ? 'INGESTING EVENT...' : 'SIMULATE EVENT INGESTION'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
