import 'package:flutter/material.dart';
import 'widgets/biometric_enrollment_definition_widget.dart';

void main() {
  runApp(const BiometricEnrollmentApp());
}

class BiometricEnrollmentApp extends StatelessWidget {
  const BiometricEnrollmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biometric Enrollment App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const BiometricEnrollmentDefinitionWidget(),
    );
  }
}
