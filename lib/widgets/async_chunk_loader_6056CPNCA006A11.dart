import 'package:flutter/material.dart';

class AsyncChunkLoader6056CPNCA006A11 extends StatefulWidget {
  const AsyncChunkLoader6056CPNCA006A11({super.key});

  @override
  State<AsyncChunkLoader6056CPNCA006A11> createState() => _AsyncChunkLoader6056CPNCA006A11State();
}

class _AsyncChunkLoader6056CPNCA006A11State extends State<AsyncChunkLoader6056CPNCA006A11> {
  final _items = <String>[];
  bool _loading = false;

  Future<void> _load() async {
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() { _items.addAll(List.generate(10, (index) => 'Prefetched record ${_items.length + index + 1}')); _loading = false; });
  }

  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Async Data Chunk Loader')), body: ListView(padding: const EdgeInsets.all(16), children: [const ListTile(title: Text('6056CPNCA-006-A11'), subtitle: Text('Chunks load ahead of scroll actions.')), const SizedBox(height: 12), ..._items.map((item) => ListTile(title: Text(item))), SizedBox(height: 48, child: FilledButton.icon(onPressed: _loading ? null : _load, icon: const Icon(Icons.download_rounded), label: Text(_loading ? 'LOADING CHUNK' : 'LOAD NEXT CHUNK')))]));
}
