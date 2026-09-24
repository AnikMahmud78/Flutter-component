import 'package:flutter/material.dart';
import 'widgets/semantic_swipe_container.dart';

void main() {
  runApp(const SemanticDomApp());
}

class SemanticDomApp extends StatelessWidget {
  const SemanticDomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: Scaffold(
        appBar: AppBar(title: const Text('Semantic Gesture Navigation')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SemanticSwipeContainer(),
        ),
      ),
    );
  }
}
