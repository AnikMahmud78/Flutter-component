import 'package:flutter/material.dart';

class LatencyContrastDashboard2635BTPM031A05 extends StatelessWidget {
  const LatencyContrastDashboard2635BTPM031A05({super.key});

  void _openDetails(BuildContext context) => showDialog<void>(context: context, builder: (context) => AlertDialog(title: const Text('Detailed Latency Timing Steps'), content: const Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Edge Gateway Handshake: 12ms'), Text('RLS Auth Validation: 18ms'), Text('BigQuery Query: 42ms'), Text('Client Render: 8ms')]), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('CLOSE'))]));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Centralized Latency Monitoring')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.accessibility_new_rounded), title: Text('2635BTPM-031-A05'), subtitle: Text('High-contrast latency flags keep detail graphs hidden until requested.')),
          const SizedBox(height: 16),
          GestureDetector(onLongPress: () => _openDetails(context), child: Card.outlined(child: const ListTile(title: Text('Network Latency Index'), subtitle: Text('80ms (NORMAL) • Long-press for timing details'), trailing: Chip(label: Text('NORMAL'))))),
          const SizedBox(height: 16),
          const Card.outlined(child: ListTile(title: Text('WCAG Compliance: Pass (7.1:1)'), subtitle: Text('WCAG 2.1 AA high-contrast palette'))),
        ],
      );
}
