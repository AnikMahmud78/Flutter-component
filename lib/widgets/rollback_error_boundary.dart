// lib/widgets/rollback_error_boundary.dart
import 'package:flutter/material.dart';

class RollbackErrorBoundary extends StatefulWidget {
  const RollbackErrorBoundary({super.key});

  @override
  State<RollbackErrorBoundary> createState() => _RollbackErrorBoundaryState();
}

class _RollbackErrorBoundaryState extends State<RollbackErrorBoundary> {
  int _counter = 0;
  int _lastSafeState = 0;
  bool _hasError = false;

  void _incrementAndCheck() {
    setState(() {
      _lastSafeState = _counter;
      _counter++;
    });
  }

  void _triggerSimulatedRuntimeError() {
    setState(() {
      _hasError = true;
      _counter = _lastSafeState; // Restore to last safe state
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Runtime error intercepted! Restored to last safe state.'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('UI Safe State Recovery Engine', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Text('Current Active Counter: $_counter', style: theme.textTheme.bodyMedium),
            Text('Last Safe Snapshot: $_lastSafeState', style: theme.textTheme.bodySmall),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: OutlinedButton(
                      onPressed: _incrementAndCheck,
                      child: const Text('UPDATE STATE'),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                        foregroundColor: theme.colorScheme.onError,
                      ),
                      onPressed: _triggerSimulatedRuntimeError,
                      child: const Text('TRIGGER FAULT'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
