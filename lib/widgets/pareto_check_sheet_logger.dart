import 'package:flutter/material.dart';

class ParetoCheckSheetLogger extends StatefulWidget {
  const ParetoCheckSheetLogger({super.key});

  @override
  State<ParetoCheckSheetLogger> createState() => _ParetoCheckSheetLoggerState();
}

class _ParetoCheckSheetLoggerState extends State<ParetoCheckSheetLogger> {
  final Map<String, int> _failureCounts = {
    'ERR_NULL_VALUE': 14,
    'ERR_REGEX_MISMATCH': 8,
    'ERR_OUT_OF_BOUNDS': 3,
  };

  void _simulateValidationFailure(String type) {
    setState(() {
      _failureCounts[type] = (_failureCounts[type] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalFailures = _failureCounts.values.fold<int>(0, (a, b) => a + b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Live Validation Fault Classifications', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ..._failureCounts.entries.map((entry) {
          final percentage = totalFailures > 0 ? (entry.value / totalFailures) * 100 : 0.0;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text(entry.key, style: theme.textTheme.bodyMedium)),
                Expanded(
                  flex: 5,
                  child: LinearProgressIndicator(
                    value: totalFailures > 0 ? entry.value / totalFailures : 0,
                    minHeight: 8.0,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text('${percentage.toStringAsFixed(1)}%', style: theme.textTheme.bodySmall),
              ],
            ),
          );
        }),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 48.0,
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () => _simulateValidationFailure('ERR_NULL_VALUE'),
            icon: const Icon(Icons.bug_report),
            label: const Text('DISPATCH TEST FAILURE EVENT'),
          ),
        ),
      ],
    );
  }
}
