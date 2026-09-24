import 'package:flutter/material.dart';
import 'models/strict_input_model.dart';
import 'widgets/strict_input_card.dart';

void main() {
  runApp(const StrictInputApp());
}

class StrictInputApp extends StatelessWidget {
  const StrictInputApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strict Input Component',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const StrictInputScreen(),
    );
  }
}

class StrictInputScreen extends StatefulWidget {
  const StrictInputScreen({Key? key}) : super(key: key);

  @override
  State<StrictInputScreen> createState() => _StrictInputScreenState();
}

class _StrictInputScreenState extends State<StrictInputScreen> {
  StrictInputModel _model = const StrictInputModel(numericValue: '', completionRate: 100.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Type Rejection Gate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StrictInputCard(
              model: _model,
              onChanged: (val) {
                setState(() {
                  _model = StrictInputModel(numericValue: val, completionRate: 100.0);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
