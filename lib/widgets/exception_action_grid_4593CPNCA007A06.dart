import 'package:flutter/material.dart';

class ExceptionActionGrid4593CPNCA007A06 extends StatelessWidget {
  const ExceptionActionGrid4593CPNCA007A06({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('5x5 Exception Actions')), body: ListView(padding: const EdgeInsets.all(16), children: [const ListTile(title: Text('4593CPNCA-007-A06'), subtitle: Text('Maximum five distinct touch actions keep resolution paths clear.')), const SizedBox(height: 16), Card.outlined(child: Wrap(spacing: 12, runSpacing: 12, children: ['Retry', 'Escalate', 'Defer', 'Resolve', 'Dismiss'].map((label) => SizedBox(width: 140, height: 48, child: OutlinedButton(onPressed: () {}, child: Text(label))).toList()))), const SizedBox(height: 16), const Card.outlined(child: ListTile(title: Text('Interaction Rule: 5 x 5'), subtitle: Text('Five action options maximum with touch-safe bounds.')))]));
}
