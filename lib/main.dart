import 'package:flutter/material.dart';
import 'widgets/contextual_header_analytics_widget.dart';

void main() {
  runApp(const ContextualHeaderAnalyticsApp());
}

class ContextualHeaderAnalyticsApp extends StatelessWidget {
  const ContextualHeaderAnalyticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contextual Header Analytics Engine',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const ContextualHeaderAnalyticsWidget(),
    );
  }
}
