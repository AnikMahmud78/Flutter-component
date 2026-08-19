// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/master_view_layout_widget.dart';

void main() {
  runApp(const MasterViewLayoutApp());
}

class MasterViewLayoutApp extends StatelessWidget {
  const MasterViewLayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Master View Component Layout Shell',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const MasterViewLayoutWidget(),
    );
  }
}
