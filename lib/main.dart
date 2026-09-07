import 'package:flutter/material.dart';
import 'widgets/table_slicing_widget.dart';

void main() {
  runApp(const TableSlicingApp());
}

class TableSlicingApp extends StatelessWidget {
  const TableSlicingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Table Slicing App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const TableSlicingWidget(),
    );
  }
}
