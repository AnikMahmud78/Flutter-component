import 'dart:async';

import 'package:flutter/material.dart';

import '../models/lead_conversion_color_telemetry_model.dart';

class LeadConversionColorTokenWidget extends StatefulWidget {
  const LeadConversionColorTokenWidget({super.key});

  @override
  State<LeadConversionColorTokenWidget> createState() => _LeadConversionColorTokenWidgetState();
}

class _LeadConversionColorTokenWidgetState extends State<LeadConversionColorTokenWidget> {
  bool _processing = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _simulateConversion() {
    setState(() => _processing = true);
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() => _processing = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lead conversion success: token status updated.')));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    const telemetry = LeadConversionColorTelemetryRecord(
      colorCodeHex: 'TOKEN_PRIMARY_SUCCESS',
      colorName: 'MD3_SYSTEM_TOKEN_PRIMARY_SUCCESS',
      colorScheme: 'MATERIAL_3_LOCKED_SCHEME',
      contrastRatio: 7.1,
      colorApplicationMap: 'md.sys.color.primary -> StatefulStatusIndicator',
      completionStatus: 'Pass',
      actionEventTimestamp: '2026-09-04T08:30:00Z',
      userSessionId: 'SESS-2026-ANIK-0050',
    );
    return Scaffold(
      appBar: AppBar(title: const Text('M3 Theme Tokens & Micro-UX States')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card.filled(color: Colors.green.shade50, child: const ListTile(
            leading: Icon(Icons.palette_rounded, color: Color(0xFF086C44)),
            title: Text('WCAG Contrast Ratio: Pass (WCAG AAA 7.1:1)'),
            subtitle: Text('Semantic Material 3 color tokens are locked for the status indicator.'),
          )),
          const SizedBox(height: 16),
          Opacity(
            opacity: _processing ? .38 : 1,
            child: Card.outlined(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
              Expanded(child: Text(_processing ? 'PROCESSING (38% OPACITY)' : 'ACTIVE_CONVERTED', style: const TextStyle(fontWeight: FontWeight.bold))),
              Icon(_processing ? Icons.sync_rounded : Icons.check_circle_rounded, color: colors.primary),
            ]))),
          ),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, height: 48, child: FilledButton.icon(
            onPressed: _processing ? null : _simulateConversion,
            icon: const Icon(Icons.sync_rounded), label: const Text('SIMULATE ASYNC LEAD CONVERSION'),
          )),
          const SizedBox(height: 24),
          Card.outlined(child: ListTile(title: Text(telemetry.colorName), subtitle: Text('${telemetry.colorApplicationMap} • ${telemetry.completionStatus}'))),
        ]),
      ),
    );
  }
}
