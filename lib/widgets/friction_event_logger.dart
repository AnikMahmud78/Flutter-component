// lib/widgets/friction_event_logger.dart
import 'package:flutter/material.dart';

class FrictionEventLogger extends StatefulWidget {
  const FrictionEventLogger({super.key});

  @override
  State<FrictionEventLogger> createState() => _FrictionEventLoggerState();
}

class _FrictionEventLoggerState extends State<FrictionEventLogger> {
  bool _isLogging = false;

  void _dispatchFrictionEvent() {
    setState(() => _isLogging = true);
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => _isLogging = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Friction Event Logged to BigQuery!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Friction Capture Node Inspector', style: theme.textTheme.titleMedium),
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
              Text('data_packet_id: PKT-8840192', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('station_id: STN-MOBILE-01', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('action_hash: HASH-771029A', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('processing_time_ms: 142', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('friction_type: HESITATION_STALL', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _isLogging ? null : _dispatchFrictionEvent,
            icon: _isLogging
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.bug_report),
            label: Text(_isLogging ? 'LOGGING...' : 'DISPATCH FRICTION LOG PAYLOAD'),
          ),
        ),
      ],
    );
  }
}
