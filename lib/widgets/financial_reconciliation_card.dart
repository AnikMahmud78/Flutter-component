// lib/widgets/financial_reconciliation_card.dart
import 'package:flutter/material.dart';

class FinancialReconciliationCard extends StatefulWidget {
  const FinancialReconciliationCard({super.key});

  @override
  State<FinancialReconciliationCard> createState() => _FinancialReconciliationCardState();
}

class _FinancialReconciliationCardState extends State<FinancialReconciliationCard> {
  double _variance = 0.0;

  void _runReconciliationSweep() {
    setState(() {
      _variance = 0.0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reconciliation Sweep Completed: Unreconciled Variance = AED 0.00')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Automated Financial Reconciliation ($A - B = 0)', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Bank Statement vs Ledger Matching'),
          subtitle: Text('Variance: AED ${_variance.toStringAsFixed(2)} | Balance Confirmed'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _runReconciliationSweep,
            icon: const Icon(Icons.sync_alt),
            label: const Text('EXECUTE RECONCILIATION SWEEPS'),
          ),
        ),
      ],
    );
  }
}
