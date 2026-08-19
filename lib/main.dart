// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/source_input_diff_comparator_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Source vs Input Diff Comparator',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const SourceInputDiffComparatorWidget(),
    );
  }
}
