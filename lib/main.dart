import 'package:flutter/material.dart';
import 'widgets/recruiter_response_widget.dart';

void main() => runApp(const RecruiterCaptureApp());

class RecruiterCaptureApp extends StatelessWidget {
  const RecruiterCaptureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recruiter Response System',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      home: Scaffold(
        appBar: AppBar(title: const Text('Recruiter Response Capture')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RecruiterResponseWidget(
            onCaptured: (resp) {},
          ),
        ),
      ),
    );
  }
}
