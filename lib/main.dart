import 'package:flutter/material.dart';
import 'widgets/persistent_header_scroll_widget.dart';

void main() {
  runApp(const PersistentHeaderScrollApp());
}

class PersistentHeaderScrollApp extends StatelessWidget {
  const PersistentHeaderScrollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Persistent Header Scroll Visibility',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const PersistentHeaderScrollWidget(),
    );
  }
}
