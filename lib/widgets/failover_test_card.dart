// lib/widgets/failover_test_card.dart
import 'package:flutter/material.dart';

class FailoverTestCard extends StatefulWidget {
  const FailoverTestCard({super.key});

  @override
  State<FailoverTestCard> createState() => _FailoverTestCardState();
}

class _FailoverTestCardState extends State<FailoverTestCard> {
  bool _isTesting = false;
  double _lastTakeoverSecs = 24.5;

  Future<void> _runFailoverSimulation() async {
    setState(() => _isTesting = true);
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      _lastTakeoverSecs = 22.1;
      _isTesting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Regional Failover Test Harness', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Primary Zone: us-central1-a -> us-central1-b'),
          subtitle: Text('Last Failover Time: ${_lastTakeoverSecs.toStringAsFixed(1)} seconds'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
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
            onPressed: _isTesting ? null : _runFailoverSimulation,
            icon: _isTesting
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.swap_calls),
            label: Text(_isTesting ? 'SIMULATING REGIONAL FAILOVER...' : 'EXECUTE SIMULATED REGIONAL FAILOVER'),
          ),
        ),
      ],
    );
  }
}
