import 'package:flutter/material.dart';

class OfflineAsyncUi6562CRSSS001A12 extends StatefulWidget {
  const OfflineAsyncUi6562CRSSS001A12({super.key});

  @override
  State<OfflineAsyncUi6562CRSSS001A12> createState() => _OfflineAsyncUi6562CRSSS001A12State();
}

class _OfflineAsyncUi6562CRSSS001A12State extends State<OfflineAsyncUi6562CRSSS001A12> {
  bool _offline = true;

  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Offline Background Sync')), body: ListView(padding: const EdgeInsets.all(16), children: [ListTile(leading: Icon(_offline ? Icons.cloud_off : Icons.cloud_done), title: Text('6562CRSSS-001-A12'), subtitle: Text(_offline ? 'Offline: sync queued locally.' : 'Online: background sync active.')), SwitchListTile(title: const Text('Network simulation'), value: !_offline, onChanged: (value) => setState(() => _offline = !value)), const Card.outlined(child: ListTile(title: Text('UI thread: non-blocking'), subtitle: Text('Background sync state is surfaced without interrupting layout.')))]));
}
