// lib/widgets/banned_terms_card.dart
import 'package:flutter/material.dart';

class BannedTermsCard extends StatelessWidget {
  const BannedTermsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Master Banned Terminology Compliance', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Banned Dictionary: 8 Core Terms'),
          subtitle: const Text('workflow, actor, step_owner, manager_id, approved_by, user_journey, user_clicks, manager_approves'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.rule),
            label: const Text('VERIFY BANNED TERM DICTIONARY'),
          ),
        ),
      ],
    );
  }
}
