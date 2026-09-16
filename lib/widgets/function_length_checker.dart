// lib/widgets/function_length_checker.dart
import 'package:flutter/material.dart';

class FunctionLengthChecker extends StatelessWidget {
  const FunctionLengthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Atomic Function AST Verification', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('// Atomic function definition (8 lines)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('void parseIngressByt(BytPayload payload) {', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('  if (payload.isEmpty) return;', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('  final token = payload.extractToken();', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('  telemetry.logByt(token);', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('}', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.spellcheck),
            label: const Text('RUN TKI 3 AST INSPECTION'),
          ),
        ),
      ],
    );
  }
}
