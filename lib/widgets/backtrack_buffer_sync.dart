import 'package:flutter/material.dart';

class BacktrackBufferSync extends StatefulWidget {
  const BacktrackBufferSync({super.key});

  @override
  State<BacktrackBufferSync> createState() => _BacktrackBufferSyncState();
}

class _BacktrackBufferSyncState extends State<BacktrackBufferSync> {
  final List<String> _bufferedPayloads = [];
  bool _isSyncing = false;
  int _syncDuration = 120;
  int _conflicts = 0;

  void _addPayloadToBuffer() {
    setState(() {
      _bufferedPayloads.add('PAYLOAD_BACKTRACK_${DateTime.now().millisecondsSinceEpoch}');
    });
  }

  Future<void> _flushBufferToNetwork() async {
    if (_bufferedPayloads.isEmpty) return;

    setState(() => _isSyncing = true);
    await Future.delayed(const Duration(milliseconds: 350));

    setState(() {
      _bufferedPayloads.clear();
      _isSyncing = false;
      _syncDuration = 145;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Asynchronous Network Buffer Queue', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8.0),
        Text('Pending Packets in Buffer: ${_bufferedPayloads.length}', style: theme.textTheme.bodyMedium),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48.0,
                child: OutlinedButton.icon(
                  onPressed: _addPayloadToBuffer,
                  icon: const Icon(Icons.add_alert),
                  label: const Text('ENQUEUE EVENT'),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: SizedBox(
                height: 48.0,
                child: ElevatedButton.icon(
                  onPressed: _isSyncing ? null : _flushBufferToNetwork,
                  icon: _isSyncing
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.sync),
                  label: Text(_isSyncing ? 'SYNCING...' : 'FLUSH BUFFER'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Last Sync Duration: ${_syncDuration}ms', style: theme.textTheme.bodySmall),
              Text('Conflicts: $_conflicts', style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
