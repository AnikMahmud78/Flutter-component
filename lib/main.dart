import 'package:flutter/material.dart';
import 'widgets/tree_element_sizing_widget.dart';

void main() {
  runApp(const TreeSizingApp());
}

class TreeSizingApp extends StatelessWidget {
  const TreeSizingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tree Element Sizing App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const TreeElementSizingWidget(),
    );
  }
}
