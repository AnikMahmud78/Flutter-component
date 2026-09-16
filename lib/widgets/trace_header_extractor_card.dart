// lib/widgets/trace_header_extractor_card.dart
import 'package:flutter/material.dart';

class TraceHeaderExtractorCard extends StatefulWidget {
  const TraceHeaderExtractorCard({super.key});

  @override
  State<TraceHeaderExtractorCard> createState() => _TraceHeaderExtractorCardState();
}

class _TraceHeaderExtractorCardState extends State<TraceHeaderExtractorCard> {
  String _traceId = 'TRACE-X-8840192-2026';
  double _latency = 0.08;

  void _extractHeader() {
    setState(() {
      _latency = 0.06;
      _traceId = 'TRACE-X-${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('HTTP Header Middleware Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Header: X-Trace-ID'),
          subtitle: Text('Extracted Value: $_traceId\nLatency: ${_latency.toStringAsFixed(2)} ms'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _extractHeader,
            icon: const Icon(Icons.subtitles),
            label: const Text('EXTRACT X-Trace-ID HEADER'),
          ),
        ),
      ],
    );
  }
}
