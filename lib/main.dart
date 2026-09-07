import 'package:flutter/material.dart';
import 'widgets/inverted_pyramid_dashboard_widget.dart';

void main() {
  runApp(const InvertedPyramidDashboardApp());
}

class InvertedPyramidDashboardApp extends StatelessWidget {
  const InvertedPyramidDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inverted Pyramid Dashboard App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const InvertedPyramidDashboardWidget(),
    );
  }
}
