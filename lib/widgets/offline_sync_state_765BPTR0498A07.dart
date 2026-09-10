import 'dart:async';

import 'package:flutter/material.dart';

class OfflineSyncState765BPTR0498A07 extends StatefulWidget {
  const OfflineSyncState765BPTR0498A07({super.key});

  @override
  State<OfflineSyncState765BPTR0498A07> createState() => _OfflineSyncState765BPTR0498A07State();
}

class _OfflineSyncState765BPTR0498A07State extends State<OfflineSyncState765BPTR0498A07> with SingleTickerProviderStateMixin {
  String syncState = 'offline';
  int _queuedCount = 3;
  late final AnimationController _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

  @override
  void dispose() { _pulse.dispose(); super.dispose(); }

  void _toggleSync() {
    setState(() { syncState = syncState == 'offline' ? 'syncing' : 'offline'; if (syncState == 'syncing') _pulse.repeat(reverse: true); else _pulse.stop(); });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Offline Sync State'),
          actions: [
            AnimatedBuilder(animation: _pulse, builder: (_, __) => Badge(label: Text('$_queuedCount'), isLabelVisible: _queuedCount > 0, child: IconButton(onPressed: _toggleSync, icon: Icon(syncState == 'offline' ? Icons.cloud_off_rounded : Icons.sync_rounded)))),
            const SizedBox(width: 12),
          ],
        ),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.cloud_sync_rounded), title: Text('765BPTR-0498-A07'), subtitle: Text('Persistent header state communicates local queue and connection status.')),
          const SizedBox(height: 16),
          Card.outlined(child: ListTile(leading: Icon(syncState == 'offline' ? Icons.cloud_off_rounded : Icons.cloud_done_rounded), title: Text('syncState: $syncState'), subtitle: Text('$_queuedCount item(s) waiting for sync'))),
          const SizedBox(height: 16),
          SizedBox(height: 48, child: FilledButton.icon(onPressed: _toggleSync, icon: const Icon(Icons.wifi_rounded), label: const Text('TOGGLE CONNECTION'))),
        ]),
      );
}
