import 'package:flutter/material.dart';
import 'widgets/null_filter_focus_engine.dart';
import 'widgets/accuracy_telemetry_banner.dart';

void main() {
  runApp(const NullFilterApp());
}

class NullFilterApp extends StatelessWidget {
  const NullFilterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DCYN Null Filter Engine',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NullFilterScreen(),
    );
  }
}

class NullFilterScreen extends StatelessWidget {
  const NullFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DCYN Focus Shift Engine')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const AccuracyTelemetryBanner(accuracyRate: 0.98, status: 'Good'),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: NullFilterFocusEngine(
                  onValidSubmit: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All payload parameters validated successfully!')),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
