import 'package:flutter/material.dart';
import 'widgets/lineage_status_panel_widget.dart';

void main() {
  runApp(const LineagePanelApp());
}

class LineagePanelApp extends StatelessWidget {
  const LineagePanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lineage Panel App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LineageStatusPanelWidget(),
    );
  }
}
