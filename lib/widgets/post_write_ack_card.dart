// lib/widgets/post_write_ack_card.dart
import 'package:flutter/material.dart';

class PostWriteAckCard extends StatefulWidget {
  const PostWriteAckCard({super.key});

  @override
  State<PostWriteAckCard> createState() => _PostWriteAckCardState();
}

class _PostWriteAckCardState extends State<PostWriteAckCard> {
  bool _isProcessing = false;
  bool _isWrittenToDb = false;
  bool _isAcked = false;

  Future<void> _processMessage() async {
    setState(() {
      _isProcessing = true;
      _isWrittenToDb = false;
      _isAcked = false;
    });

    // Step 1: Write to DB
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() => _isWrittenToDb = true);

    // Step 2: Post-Write Ack
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      _isAcked = true;
      _isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pub/Sub Consumer Handler', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('1. Persistence Write Check'),
          trailing: Icon(
            _isWrittenToDb ? Icons.check_circle : Icons.radio_button_unchecked,
            color: _isWrittenToDb ? theme.colorScheme.primary : theme.colorScheme.outline,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('2. Post-Write Ack Signal'),
          trailing: Icon(
            _isAcked ? Icons.check_circle : Icons.radio_button_unchecked,
            color: _isAcked ? theme.colorScheme.primary : theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _isProcessing ? null : _processMessage,
            icon: _isProcessing
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.mark_email_read),
            label: Text(_isProcessing ? 'PROCESSING PAYLOAD...' : 'CONSUME MESSAGE (POST-WRITE ACK)'),
          ),
        ),
      ],
    );
  }
}
