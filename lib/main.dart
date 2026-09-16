import 'package:flutter/material.dart';
import 'widgets/progressive_step1_form.dart';
import 'widgets/onboarding_completeness_banner.dart';

void main() {
  runApp(const ProgressiveProfilingApp());
}

class ProgressiveProfilingApp extends StatelessWidget {
  const ProgressiveProfilingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progressive Profiling Step 1',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Onboarding (FLADE-027)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            OnboardingCompletenessBanner(status: 'Complete', coverage: 1.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ProgressiveStep1Form(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
