import 'package:flutter/material.dart';

class ScrollHeapProfiler7035CPNCA006A14 extends StatefulWidget {
  const ScrollHeapProfiler7035CPNCA006A14({super.key});

  @override
  State<ScrollHeapProfiler7035CPNCA006A14> createState() =>
      _ScrollHeapProfiler7035CPNCA006A14State();
}

class _ScrollHeapProfiler7035CPNCA006A14State
    extends State<ScrollHeapProfiler7035CPNCA006A14> {
  double _scrollOffset = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Scroll Heap Profiler')),
    body: NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        setState(() => _scrollOffset = notification.metrics.pixels);
        return false;
      },
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (_, index) =>
            ListTile(title: Text('Profiled row ${index + 1}')),
      ),
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Scroll offset: ${_scrollOffset.toStringAsFixed(0)}px • heap profiling active',
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
