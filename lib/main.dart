// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/tablet_navigation_rail_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tablet Navigation Rail',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const TabletNavigationRailWidget(),
    );
  }
}
