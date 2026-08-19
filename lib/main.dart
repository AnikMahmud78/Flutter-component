// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/nullable_fallback_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nullable Field Rendering Fallbacks',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const NullableFallbackScreen(),
    );
  }
}
