import 'package:flutter/material.dart';
import 'widgets/responsive_grid_wrapper.dart';
import 'widgets/w3c_quality_banner.dart';

void main() {
  runApp(const GridWrapperApp());
}

class GridWrapperApp extends StatelessWidget {
  const GridWrapperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Grid Layout',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const GridScreen(),
    );
  }
}

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Grid Wrapper (GEN-00024)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const W3cQualityBanner(status: 'Pass'),
            ResponsiveGridWrapper(
              children: List.generate(
                4,
                (i) => Card(
                  child: Center(
                    child: Text('Responsive Grid Cell #${i + 1}'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
