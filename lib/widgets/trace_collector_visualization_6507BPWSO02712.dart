import 'package:flutter/material.dart';

class TraceCollectorVisualization6507BPWSO02712 extends StatelessWidget {
  const TraceCollectorVisualization6507BPWSO02712({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Production Trace Collectors')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.monitor_heart_rounded), title: Text('6507BPWSO-027-12'), subtitle: Text('Material trace health canvas with complete alert coverage.')),
          const SizedBox(height: 16),
          Card.outlined(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Production Node #01', style: TextStyle(fontWeight: FontWeight.bold)), Chip(label: Text('HEALTHY'))]),
            const SizedBox(height: 12),
            const LinearProgressIndicator(value: .18, minHeight: 8),
            const SizedBox(height: 8),
            const Text('Trace latency: 18ms (threshold: 200ms)', style: TextStyle(fontFamily: 'monospace')),
          ]))),
          const SizedBox(height: 16),
          const Card.outlined(child: ListTile(title: Text('Observability / Alert Coverage: Good (100%)'), subtitle: Text('Google SRE monitoring standard'))),
        ]),
      );
}
