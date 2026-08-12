import 'package:flutter/material.dart';
import 'widgets/friction_listener_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Friction & Hesitation Listener',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const FrictionListenerWrapper(child: FrictionDemoForm()),
    );
  }
}
