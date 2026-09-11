import 'package:flutter/material.dart';

class TelemetryHealthSheet4703BTPM019A06 extends StatelessWidget {
  const TelemetryHealthSheet4703BTPM019A06({super.key});

  void _openSheet(BuildContext context) => showModalBottomSheet<void>(context: context, showDragHandle: true, builder: (context) => SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, children: const [Text('BigQuery Throughput Contextual Analytics', style: TextStyle(fontWeight: FontWeight.bold)), Divider(), ListTile(title: Text('Ingress Rate'), trailing: Chip(label: Text('HEALTHY'))), SizedBox(height: 8)]))));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Telemetry Throughput Health')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.health_and_safety_rounded), title: Text('4703BTPM-019-A06'), subtitle: Text('Health colors map throughput states to contextual analytics.')),
          const SizedBox(height: 16),
          Card.outlined(child: ListTile(title: const Text('Ingress Throughput'), subtitle: const Text('14,200 events/sec'), trailing: const Chip(label: Text('HEALTHY')))),
          const SizedBox(height: 16),
          SizedBox(height: 48, child: FilledButton.icon(onPressed: () => _openSheet(context), icon: const Icon(Icons.swipe_vertical_rounded), label: const Text('OPEN ANALYTICS SHEET'))),
          const SizedBox(height: 16),
          const Card.outlined(child: ListTile(title: Text('Process Execution Fidelity: Complete (100%)'), subtitle: Text('Green #086C44 • Amber #B56C00 • Red #E31B23'))),
        ],
      );
}
