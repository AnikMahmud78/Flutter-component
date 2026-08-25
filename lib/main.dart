import 'package:flutter/material.dart';
import 'widgets/print_header_report_widget.dart';

void main() {
  runApp(const PrintHeaderApp());
}

class PrintHeaderApp extends StatelessWidget {
  const PrintHeaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Report Matrix Compiler',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const PrintHeaderReportWidget(),
    );
  }
}
