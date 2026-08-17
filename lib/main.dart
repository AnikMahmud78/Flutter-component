import 'package:flutter/material.dart';
import 'widgets/triangular_check_widget.dart';

void main() {
  runApp(const TriangularReconciliationApp());
}

class TriangularReconciliationApp extends StatelessWidget {
  const TriangularReconciliationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real-Time Reconciliation Engine',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const TriangularCheckWidget(),
    );
  }
}
