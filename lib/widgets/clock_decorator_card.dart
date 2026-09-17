// lib/widgets/clock_decorator_card.dart
import 'package:flutter/material.dart';

class ClockDecoratorCard extends StatelessWidget {
  const ClockDecoratorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Clock Decorator Engine', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('clock_decorator.py'),
          subtitle: const Text('PEP 8 Validated | Latency SLA Monitor Active'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.speed),
            label: const Text('VERIFY DECORATOR SYNTAX'),
          ),
        ),
      ],
    );
  }
}
