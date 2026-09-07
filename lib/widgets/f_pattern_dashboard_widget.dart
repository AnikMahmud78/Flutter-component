import 'package:flutter/material.dart';

import '../models/f_pattern_telemetry_model.dart';

class FPatternDashboardWidget extends StatefulWidget {
  const FPatternDashboardWidget({super.key});

  @override
  State<FPatternDashboardWidget> createState() => _FPatternDashboardWidgetState();
}

class _FPatternDashboardWidgetState extends State<FPatternDashboardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  final _telemetry = FPatternTelemetryRecord(
    importSource: 'Executive Dashboard F-Pattern Template',
    importStatus: 'IMPORTED_RIGID_F_PATTERN',
    importDate: '2026-09-04',
    importValidation: 'FIELD_ELEMENT_IDENTIFICATION_ACCURACY_PASSED',
    importRecordsCount: 4,
    completionStatus: 'Pass',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3625',
  );

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 600;
    return Scaffold(
      appBar: AppBar(title: const Text('F-Pattern Executive Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card.filled(color: Colors.green.shade50, child: const ListTile(
            leading: Icon(Icons.grid_view_rounded, color: Color(0xFF086C44)),
            title: Text('Field/Element Identification Accuracy: Pass'),
            subtitle: Text('Rigid F-pattern hierarchy imported from the governing UX inventory.'),
          )),
          const SizedBox(height: 16),
          if (mobile) ...[
            _primaryKpi(), const SizedBox(height: 12), _alerts(), const SizedBox(height: 12), _sparklines(),
          ] else ...[
            Row(children: [Expanded(child: _primaryKpi()), const SizedBox(width: 12), Expanded(child: _alerts())]),
            const SizedBox(height: 12), _sparklines(),
          ],
          const SizedBox(height: 24),
          const Card.outlined(child: ListTile(
            leading: Icon(Icons.lock_rounded),
            title: Text('Drag-and-drop disabled'),
            subtitle: Text('Top-left KPI, top-right alerts, center performance sparklines.'),
          )),
          const SizedBox(height: 12),
          Card.outlined(child: ListTile(title: const Text('Atomic Step Execution Telemetry'), subtitle: Text('${_telemetry.importStatus} • ${_telemetry.completionStatus}'))),
        ]),
      ),
    );
  }

  Widget _primaryKpi() => AnimatedBuilder(
        animation: _pulseController,
        builder: (_, __) => Card.outlined(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Color.lerp(Colors.red.shade300, Colors.red.shade700, _pulseController.value)!, width: 2)),
          child: const Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('TOP-LEFT F-PATTERN KPI (LOCKED)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            SizedBox(height: 8), Text('\$4,892,100.00', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
            Text('Primary Enterprise Margin (+14.2% YoY)', style: TextStyle(color: Color(0xFF086C44))),
          ])),
        ),
      );

  Widget _alerts() => Card.filled(color: const Color(0xFFF9DEDC), child: const Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('TOP-RIGHT CRITICAL ALERTS (LOCKED)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF8B0811))),
    SizedBox(height: 8), Row(children: [Icon(Icons.warning_amber_rounded, color: Color(0xFFE31B23)), SizedBox(width: 8), Expanded(child: Text('3 High-Priority SLA Breaches', style: TextStyle(fontWeight: FontWeight.bold)))]),
  ]));

  Widget _sparklines() => Card.outlined(child: const Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('CENTER F-PATTERN: PERFORMANCE SPARKLINES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
    SizedBox(height: 12), LinearProgressIndicator(value: .78, minHeight: 8), SizedBox(height: 6), Text('Throughput Capacity: 78% Utilization', style: TextStyle(fontFamily: 'monospace')),
  ]));
}
