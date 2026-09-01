import 'package:flutter/material.dart';
import 'widgets/persistent_header_status_widget.dart';

void main() {
  runApp(const PersistentHeaderStatusApp());
}

class PersistentHeaderStatusApp extends StatelessWidget {
  const PersistentHeaderStatusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Persistent Header Status Anchors',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const PersistentHeaderStatusWidget(),
    );
  }
}
