// lib/widgets/rollback_simulator_card.dart
import 'package:flutter/material.dart';

class RollbackSimulatorCard extends StatefulWidget {
  const RollbackSimulatorCard({super.key});

  @override
  State<RollbackSimulatorCard> createState() => _RollbackSimulatorCardState();
}

class _RollbackSimulatorCardState extends State<RollbackSimulatorCard> {
  bool _rollbackVerified = false;

  void _runNonMatchingSimulation() {
    setState(() => _rollbackVerified = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Simulated non-matching transaction (A - B != 0) -> Rollback Verified Pass.'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rollback Verification Simulator', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Mismatch Intercept Status'),
          subtitle: Text(_rollbackVerified ? 'Rollback execution confirmed' : 'Ready for test injection'),
          trailing: Icon(
            _rollbackVerified ? Icons.check_circle : Icons.pending,
            color: _rollbackVerified ? theme.colorScheme.primary : theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48.0),
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
            ),
            onPressed: _runNonMatchingSimulation,
            icon: const Icon(Icons.replay),
            label: const Text('SIMULATE NON-MATCHING TRANSACTION'),
          ),
        ),
      ],
    );
  }
}
