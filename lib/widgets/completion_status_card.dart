import 'package:flutter/material.dart';

class CompletionStatusCard extends StatelessWidget {
  final double rate;
  final String activeMode;

  const CompletionStatusCard({
    super.key,
    required this.rate,
    required this.activeMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Active Breakpoint Mode: \$activeMode', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Step Completion Rate: \$rate% (Floor: 90.0%)'),
          ],
        ),
      ),
    );
  }
}
