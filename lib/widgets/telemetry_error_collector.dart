// lib/widgets/telemetry_error_collector.dart
import 'package:flutter/material.dart';

class TelemetryErrorCollector extends StatefulWidget {
  const TelemetryErrorCollector({super.key});

  @override
  State<TelemetryErrorCollector> createState() => _TelemetryErrorCollectorState();
}

class _TelemetryErrorCollectorState extends State<TelemetryErrorCollector> {
  bool _isLogging = false;
  String _logOutput = 'No telemetry payload dispatched yet.';

  Future<void> _dispatchTelemetryPayload() async {
    setState(() => _isLogging = true);
    await Future.delayed(const Duration(milliseconds: 450));
    setState(() {
      _isLogging = false;
      _logOutput = 'Payload Ingested:\n'
          'error_stack_string: StateError: Bad state in telemetry listener\n'
          'failed_component_id: COMP-ERR-8421\n'
          'device_info: Pixel 8 Pro (Android 14 API 34)';
    });
  }

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
            Text('Error Telemetry Collection Engine', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _logOutput,
                style: theme.textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: _isLogging ? null : _dispatchTelemetryPayload,
                icon: _isLogging
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.bug_report),
                label: Text(_isLogging ? 'DISPATCHING TELEMETRY...' : 'DISPATCH ERROR PAYLOAD'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
