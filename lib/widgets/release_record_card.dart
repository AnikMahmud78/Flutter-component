// lib/widgets/release_record_card.dart
import 'package:flutter/material.dart';

class ReleaseRecordCard extends StatefulWidget {
  const ReleaseRecordCard({super.key});

  @override
  State<ReleaseRecordCard> createState() => _ReleaseRecordCardState();
}

class _ReleaseRecordCardState extends State<ReleaseRecordCard> {
  bool _isCommitted = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('End Document (ED) Production Anchor', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Record: Mobile_Attribution_Release_Record'),
          subtitle: const Text('Target: Cloud SQL App_Store_Release_Record [Committed]'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ED Immutable Record successfully anchored to Cloud SQL!')),
              );
            },
            icon: const Icon(Icons.verified_user),
            label: const Text('VERIFY ED RELEASE ANCHOR'),
          ),
        ),
      ],
    );
  }
}
