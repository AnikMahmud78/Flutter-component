// lib/widgets/mta_identity_join_card.dart
import 'package:flutter/material.dart';

class MtaIdentityJoinCard extends StatelessWidget {
  const MtaIdentityJoinCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BigQuery MTA Identity Resolution Model', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('member_id: MBR-ANIK-8842'),
          subtitle: const Text('Mapped Tokens: FCM-TOK-99021, APNS-TOK-11029'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.merge_type),
            label: const Text('RUN BIGQUERY IDENTITY JOIN'),
          ),
        ),
      ],
    );
  }
}
