import 'package:flutter/material.dart';
import 'widgets/biometric_fallback_prompt_widget.dart';

void main() {
  runApp(const BiometricFallbackApp());
}

class BiometricFallbackApp extends StatelessWidget {
  const BiometricFallbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebAuthn Biometric Fallback App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const BiometricFallbackPromptWidget(),
    );
  }
}
