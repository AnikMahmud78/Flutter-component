// lib/widgets/triangular_check_decorator.dart
import 'package:flutter/material.dart';

class TriangularCheckDecoratorWidget extends StatefulWidget {
  const TriangularCheckDecoratorWidget({super.key});

  @override
  State<TriangularCheckDecoratorWidget> createState() => _TriangularCheckDecoratorWidgetState();
}

class _TriangularCheckDecoratorWidgetState extends State<TriangularCheckDecoratorWidget> {
  final TextEditingController _amountACtrl = TextEditingController(text: '150.00');
  final TextEditingController _amountBCtrl = TextEditingController(text: '150.00');
  bool _checkPassed = true;

  void _runTriangularCheck() {
    final a = double.tryParse(_amountACtrl.text) ?? 0.0;
    final b = double.tryParse(_amountBCtrl.text) ?? 0.0;
    setState(() {
      _checkPassed = (a - b).abs() < 0.001;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('@triangular_check Wrapper Visualizer', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amountACtrl,
                decoration: const InputDecoration(labelText: 'Ingress Revenue (A)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: TextField(
                controller: _amountBCtrl,
                decoration: const InputDecoration(labelText: 'Booked Revenue (B)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _checkPassed ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            _checkPassed ? 'A - B = 0.00 (Revenue Reconciled Pass)' : 'MISMATCH DETECTED: Rollback Triggered',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _checkPassed ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _runTriangularCheck,
            icon: const Icon(Icons.sync_alt),
            label: const Text('EXECUTE @triangular_check DECORATOR'),
          ),
        ),
      ],
    );
  }
}
