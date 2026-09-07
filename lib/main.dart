import 'package:flutter/material.dart';
import 'widgets/f_pattern_dashboard_widget.dart';

void main() {
  runApp(const FPatternDashboardApp());
}

class FPatternDashboardApp extends StatelessWidget {
  const FPatternDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F-Pattern Executive Dashboard',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const FPatternDashboardWidget(),
    );
  }
}
