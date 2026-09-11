import 'package:flutter/material.dart';

class ExceptionActionSpacing5187CPNCA007A08 extends StatelessWidget {
  const ExceptionActionSpacing5187CPNCA007A08({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Exception Action Spacing')), body: ListView(padding: const EdgeInsets.all(24), children: [const ListTile(title: Text('5187CPNCA-007-A08'), subtitle: Text('Generous negative space reduces cognitive fatigue on stress paths.')), const SizedBox(height: 24), ...['Review evidence', 'Assign owner', 'Mark resolved'].map((label) => Padding(padding: const EdgeInsets.only(bottom: 24), child: SizedBox(height: 56, child: FilledButton(onPressed: () {}, child: Text(label)))), const Card.outlined(child: ListTile(title: Text('Spacing Rule: 24dp'), subtitle: Text('Clear action separation for focused mobile interaction.')))]));
}
