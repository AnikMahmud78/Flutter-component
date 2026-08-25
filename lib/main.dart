import 'package:flutter/material.dart';
import 'widgets/bottom_inset_navigation_widget.dart';

void main() {
  runApp(const BottomInsetApp());
}

class BottomInsetApp extends StatelessWidget {
  const BottomInsetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M3 Bottom Inset Navigation',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const BottomInsetNavigationWidget(),
    );
  }
}
