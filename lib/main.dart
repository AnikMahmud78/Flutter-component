import 'package:flutter/material.dart';
import 'models/tactile_feedback_model.dart';
import 'widgets/tactile_feedback_card.dart';

void main() {
  runApp(const TactileFeedbackApp());
}

class TactileFeedbackApp extends StatelessWidget {
  const TactileFeedbackApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tactile Feedback App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const TactileFeedbackScreen(),
    );
  }
}

class TactileFeedbackScreen extends StatefulWidget {
  const TactileFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<TactileFeedbackScreen> createState() => _TactileFeedbackScreenState();
}

class _TactileFeedbackScreenState extends State<TactileFeedbackScreen> {
  TactileFeedbackModel _model = const TactileFeedbackModel(isSelected: false, completionRate: 100.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tactile Selection Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TactileFeedbackCard(
              model: _model,
              onSelectionChanged: (selected) {
                setState(() {
                  _model = TactileFeedbackModel(isSelected: selected, completionRate: 100.0);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
