import 'package:flutter/material.dart';
import '../models/poka_yoke_telemetry.dart';

class PokaYokeGuardCard extends StatefulWidget {
  final Function(PokaYokeTelemetry) onExecutionLogged;

  const PokaYokeGuardCard({Key? key, required this.onExecutionLogged}) : super(key: key);

  @override
  State<PokaYokeGuardCard> createState() => _PokaYokeGuardCardState();
}

class _PokaYokeGuardCardState extends State<PokaYokeGuardCard> {
  final TextEditingController _amountController = TextEditingController(text: '12500.00');
  String _status = 'Complete';
  bool _blocked = false;
  String _reason = 'Algorithmic limits strictly enforced. Zero manual override.';

  // English Code (EC): Execute-Algorithmic-Fraud-Check
  void executeAlgorithmicFraudCheck() {
    final double value = double.tryParse(_amountController.text) ?? 0.0;
    // Hardcoded Poka-Yoke Rule: Single transaction ceiling $10,000.00 hard stop
    if (value > 10000.00) {
      setState(() {
        _blocked = true;
        _status = 'Not Complete';
        _reason = 'HARD LIMIT VIOLATION: Transaction amount \$${value.toStringAsFixed(2)} exceeds hardcoded threshold (\$10,000.00).';
      });
    } else {
      setState(() {
        _blocked = false;
        _status = 'Complete';
        _reason = 'Transaction validated cleanly against algorithmic rules.';
      });
    }

    widget.onExecutionLogged(PokaYokeTelemetry(
      transactionId: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
      amount: value,
      completionStatus: _status,
      isFraudBlocked: _blocked,
      violationReason: _reason,
      timestamp: DateTime.now(),
      userId: 'ENG-ANIK-001',
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Poka-Yoke Fraud Engine', style: theme.textTheme.titleMedium),
                Chip(
                  label: Text(_status, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  backgroundColor: _blocked ? theme.colorScheme.error : theme.colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Transaction Amount (\$)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0, // Strict touch target
              child: ElevatedButton(
                onPressed: executeAlgorithmicFraudCheck,
                child: const Text('VERIFY TRANSACTION ALGORITHM'),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(_reason, style: TextStyle(color: _blocked ? theme.colorScheme.error : theme.colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
