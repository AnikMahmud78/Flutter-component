import 'package:flutter/material.dart';
import 'widgets/persistent_bottom_nav_widget.dart';

void main() {
  runApp(const PersistentBottomNavApp());
}

class PersistentBottomNavApp extends StatelessWidget {
  const PersistentBottomNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Persistent Bottom Navigation Container',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const PersistentBottomNavWidget(),
    );
  }
}
