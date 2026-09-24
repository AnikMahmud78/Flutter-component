import 'package:flutter/material.dart';
import 'models/linter_rule_model.dart';
import 'widgets/linter_status_card.dart';

void main() {
  runApp(const LinterApp());
}

class LinterApp extends StatelessWidget {
  const LinterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Static Linter',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
      home: const LinterScreen(),
    );
  }
}

class LinterScreen extends StatefulWidget {
  const LinterScreen({Key? key}) : super(key: key);

  @override
  State<LinterScreen> createState() => _LinterScreenState();
}

class _LinterScreenState extends State<LinterScreen> {
  LinterRuleModel _rule = const LinterRuleModel(
    ruleId: 'M3-TOKEN-ENFORCER-01',
    detectionAccuracy: 0.985,
    totalViolationsBlocked: 142,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design System Governance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinterStatusCard(
              model: _rule,
              onRunLinter: () {
                setState(() {
                  _rule = LinterRuleModel(
                    ruleId: 'M3-TOKEN-ENFORCER-01',
                    detectionAccuracy: 0.992,
                    totalViolationsBlocked: _rule.totalViolationsBlocked + 3,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
