// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/mto_data_isolation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MTO Data Block Visual Isolation Engine',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const MtoDataIsolationWidget(),
    );
  }
}
