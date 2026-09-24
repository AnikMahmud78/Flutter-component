import 'package:flutter/material.dart';
import 'models/virtual_node_model.dart';
import 'services/node_lifecycle_manager.dart';
import 'widgets/virtual_node_item.dart';
import 'widgets/memory_health_banner.dart';

void main() {
  runApp(const HABOTUnmountApp());
}

class HABOTUnmountApp extends StatelessWidget {
  const HABOTUnmountApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10203GEN-01972 Aggressive Unmount',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF386A20)),
      ),
      home: const UnmountScreen(),
    );
  }
}

class UnmountScreen extends StatefulWidget {
  const UnmountScreen({super.key});

  @override
  State<UnmountScreen> createState() => _UnmountScreenState();
}

class _UnmountScreenState extends State<UnmountScreen> {
  late VirtualNodeModel _model;

  @override
  void initState() {
    super.initState();
    _refreshMetrics();
  }

  void _refreshMetrics() {
    setState(() {
      _model = NodeLifecycleManager.evaluateNodeUnmounting(
        taskId: '10203GEN-01972',
        totalElements: 10000,
        visibleElements: 8,
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aggressive DOM/UI Node Unmounter')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MemoryHealthBanner(completionRate: _model.completionRate),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Active Nodes in Heap: \${_model.activeNodesInMemory} | Unmounted: \${_model.unmountedNodesCount}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: 10000,
              itemBuilder: (context, index) {
                return VirtualNodeItem(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
