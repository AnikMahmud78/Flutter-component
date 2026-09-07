import 'package:flutter/material.dart';
import 'widgets/lineage_render_optimization_widget.dart';

void main() {
  runApp(const LineageRenderApp());
}

class LineageRenderApp extends StatelessWidget {
  const LineageRenderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lineage Diagram Render Optimization',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LineageRenderOptimizationWidget(),
    );
  }
}
