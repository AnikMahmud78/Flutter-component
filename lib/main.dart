import 'package:flutter/material.dart';
import 'widgets/async_chunk_loader_6056CPNCA006A11.dart';

void main() {
  runApp(const AsyncChunkLoader6056CPNCA006A11App());
}

class AsyncChunkLoader6056CPNCA006A11App extends StatelessWidget {
  const AsyncChunkLoader6056CPNCA006A11App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Async Data Chunk Loader App',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const AsyncChunkLoader6056CPNCA006A11(),
  );
}
