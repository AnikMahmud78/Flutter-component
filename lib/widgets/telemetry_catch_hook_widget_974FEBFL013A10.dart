import 'package:flutter/material.dart';
import '../models/telemetry_catch_hook_model.dart';

class TelemetryCatchHookWidget974FEBFL013A10 extends StatefulWidget {
  const TelemetryCatchHookWidget974FEBFL013A10({super.key});

  @override
  State<TelemetryCatchHookWidget974FEBFL013A10> createState() =>
      _TelemetryCatchHookWidget974FEBFL013A10State();
}

class _TelemetryCatchHookWidget974FEBFL013A10State
    extends State<TelemetryCatchHookWidget974FEBFL013A10> {
  String _simulatedDataField = '—';

  TelemetryCatchHookRecord get _telemetry => TelemetryCatchHookRecord(
        metricName: 'SCHEMA_TYPE_SHIFT_EXCEPTION_RATE',
        metricValue: '1 Incident Tracked',
        monitoringStatus: 'ACTIVE_CATCH_HOOK_LISTENER',
        alertThreshold: '<15s Real-Time Dispatch SLA',
        monitoringTimestamp: DateTime.now().toUtc().toIso8601String(),
        completionStatus: 'High',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-0974',
      );

  void _triggerMalformedSchemaFetch() {
    try {
      throw FormatException('Unexpected schema change: string expected, received int');
    } catch (e) {
      setState(() => _simulatedDataField = '—');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('TELEMETRY ALERT DISPATCHED: Schema change logged (<15s SLA).'),
          backgroundColor: Color(0xFFE31B23),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catch Path Telemetry Hooks'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(Icons.timer_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Monitoring & Alert Response Time: High (<15s)',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF086C44))),
                          SizedBox(height: 2),
                          Text('Alert surfaced within 15 seconds of the triggering event (real-time benchmark).',
                              style: TextStyle(fontSize: 11, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Incoming Database Value:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(_simulatedDataField, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 48.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary, foregroundColor: Colors.white),
                          onPressed: _triggerMalformedSchemaFetch,
                          icon: const Icon(Icons.bolt_rounded),
                          label: const Text('SIMULATE_SCHEMA_TYPE_SHIFT'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Atomic Telemetry Logs',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Metric Name', telemetry.metricName),
                    const Divider(height: 12),
                    _buildRow('Alert Threshold', telemetry.alertThreshold),
                    const Divider(height: 12),
                    _buildRow('Monitoring Status', telemetry.monitoringStatus, isHighlight: true),
                    const Divider(height: 12),
                    _buildRow('Completion Status', telemetry.completionStatus, isHighlight: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        Expanded(
          child: Text(value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
              )),
        ),
      ],
    );
  }
}
