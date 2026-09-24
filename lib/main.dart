import 'package:flutter/material.dart';
import 'widgets/infinite_dashboard_list.dart';

void main() {
  runApp(const InfiniteScrollApp());
}

class InfiniteScrollApp extends StatelessWidget {
  const InfiniteScrollApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.cyan),
      home: Scaffold(
        appBar: AppBar(title: const Text('Infinite Scroll Dashboard Engine')),
        body: const InfiniteDashboardList(),
      ),
    );
  }
}
