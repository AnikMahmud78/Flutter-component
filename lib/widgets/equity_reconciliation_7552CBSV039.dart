import 'package:flutter/material.dart';

class EquityReconciliation7552CBSV039 extends StatelessWidget {
  const EquityReconciliation7552CBSV039({super.key});

  void _showProofs(BuildContext context) => showDialog<void>(context: context, barrierDismissible: false, builder: (context) => AlertDialog(title: const Text('Mandatory Equity Legal Proofs'), content: const Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Bank Credit Note: Uploaded & Verified'), Text('Board Resolution: Uploaded & Verified'), SizedBox(height: 12), Text('Gain Share payout suspended by policy.', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))]), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('ACKNOWLEDGE'))]));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Shareholder Equity Reconciliation')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.account_balance_rounded), title: Text('7552CBSV-039'), subtitle: Text('Legal proofs are required before equity validation can be acknowledged.')),
          const SizedBox(height: 16),
          Card.outlined(child: ListTile(title: const Text('Gain Share Bonus Status'), trailing: InkWell(onTap: () => _showProofs(context), child: const Chip(label: Text('SUSPENDED'), backgroundColor: Colors.red, labelStyle: TextStyle(color: Colors.white))))),
          const SizedBox(height: 8),
          const SizedBox(height: 48, child: FilledButton(onPressed: null, child: Text('SUBMIT PAYOUT (BLOCKED)'))),
          const SizedBox(height: 16),
          const Card.outlined(child: ListTile(title: Text('Financial Reconciliation Accuracy: Pass (100%)'), subtitle: Text('IFAC/IIA reconciliation benchmark'))),
        ],
      );
}
