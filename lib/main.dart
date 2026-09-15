import 'package:flutter/material.dart';
import 'widgets/empty_state_verifier_widget_7684FEBFL002A16.dart';

void main() {
  runApp(const EmptyStateApp7684FEBFL002A16());
}

class EmptyStateApp7684FEBFL002A16 extends StatelessWidget {
  const EmptyStateApp7684FEBFL002A16({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Empty State Verification App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const EmptyStateVerifierWidget7684FEBFL002A16(),
    );
  }
}
