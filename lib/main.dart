import 'package:flutter/material.dart';
import 'widgets/medium_side_rail_scaffold_widget.dart';

void main() {
  runApp(const MediumSideRailApp());
}

class MediumSideRailApp extends StatelessWidget {
  const MediumSideRailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medium Screen Navigation Rail Shell',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const MediumSideRailScaffoldWidget(),
    );
  }
}
