import 'package:flutter/material.dart';
import 'widgets/md3_responsive_navigation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MD3 Responsive Navigation & BDD Engine',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const Md3ResponsiveNavigationWidget(),
    );
  }
}
