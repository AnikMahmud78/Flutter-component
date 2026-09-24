import 'package:flutter/material.dart';
import 'models/swipe_progression_model.dart';
import 'widgets/swipe_progression_card.dart';

void main() {
  runApp(const SwipeProgressionApp());
}

class SwipeProgressionApp extends StatelessWidget {
  const SwipeProgressionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Progression Gate',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const SwipeProgressionScreen(),
    );
  }
}

class SwipeProgressionScreen extends StatefulWidget {
  const SwipeProgressionScreen({Key? key}) : super(key: key);

  @override
  State<SwipeProgressionScreen> createState() => _SwipeProgressionScreenState();
}

class _SwipeProgressionScreenState extends State<SwipeProgressionScreen> {
  SwipeProgressionModel _model = const SwipeProgressionModel(isSingleActionValid: false, lockRatePercentage: 100.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swipe Progression Gate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwipeProgressionCard(
              model: _model,
              onToggleActionState: (valid) {
                setState(() {
                  _model = SwipeProgressionModel(isSingleActionValid: valid, lockRatePercentage: 100.0);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
