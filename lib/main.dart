import 'package:flutter/material.dart';
import 'widgets/scroll_heap_profiler_7035CPNCA006A14.dart';

void main() {
  runApp(const ScrollHeapProfiler7035CPNCA006A14App());
}

class ScrollHeapProfiler7035CPNCA006A14App extends StatelessWidget {
  const ScrollHeapProfiler7035CPNCA006A14App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Scroll Heap Profiler App',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const ScrollHeapProfiler7035CPNCA006A14(),
  );
}
