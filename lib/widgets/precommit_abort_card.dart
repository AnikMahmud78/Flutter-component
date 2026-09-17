// lib/widgets/precommit_abort_card.dart
import 'package:flutter/material.dart';

class PrecommitAbortCard extends StatelessWidget {
  const PrecommitAbortCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Git Pre-Commit Hook Abort Interlock', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Hook: hooks/pre-commit-dcdf-linter.sh'),
          subtitle: const Text('Physically aborts commit if staged files contain banned terms'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.block),
            label: const Text('TEST PRE-COMMIT ABORT INTERLOCK'),
          ),
        ),
      ],
    );
  }
}
