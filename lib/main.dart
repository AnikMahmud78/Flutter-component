import 'package:flutter/material.dart';
import 'widgets/ai_reviewer_verification_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Reviewer Cross-Verification',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AiReviewerVerificationWidget(),
    );
  }
}
