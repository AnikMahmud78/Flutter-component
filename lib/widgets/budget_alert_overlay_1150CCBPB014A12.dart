import 'package:flutter/material.dart';

class BudgetAlertOverlay1150CCBPB014A12 extends StatefulWidget {
  const BudgetAlertOverlay1150CCBPB014A12({super.key});

  @override
  State<BudgetAlertOverlay1150CCBPB014A12> createState() =>
      _BudgetAlertOverlay1150CCBPB014A12State();
}

class _BudgetAlertOverlay1150CCBPB014A12State
    extends State<BudgetAlertOverlay1150CCBPB014A12> {
  double _budget = 100;

  @override
  Widget build(BuildContext context) {
    final critical = _budget >= 100;
    final elevated = _budget >= 85;
    final early = _budget >= 70;
    final color = critical
        ? Colors.red
        : elevated
        ? Colors.deepOrange
        : early
        ? Colors.amber.shade800
        : Colors.green;
    final message = critical
        ? 'CRITICAL 100% BUDGET LOCK: MTO queues frozen'
        : elevated
        ? 'ELEVATED 85% ALERT: impending capacity hard-stop'
        : early
        ? 'EARLY 70% WARNING: capacity threshold approaching'
        : 'Normal operations';
    return Scaffold(
      appBar: AppBar(title: const Text('Budget Capacity Alert Overlay')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(
              critical ? Icons.lock_rounded : Icons.warning_rounded,
              color: color,
            ),
            title: Text('1150CCBPB-014-A12'),
            subtitle: Text(message),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Budget utilization: ${_budget.toStringAsFixed(0)}%',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Slider(
            value: _budget,
            min: 50,
            max: 100,
            divisions: 10,
            onChanged: (value) => setState(() => _budget = value),
          ),
          const SizedBox(height: 16),
          Card.outlined(
            child: ListTile(
              title: Text(
                critical
                    ? 'Lock Status: LOCKED_CRITICAL'
                    : 'Lock Status: UNLOCKED_MONITORING',
              ),
              subtitle: Text(
                critical
                    ? 'Auto-scaling and MTO queues are frozen.'
                    : 'FinOps watchdog is monitoring thresholds.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
