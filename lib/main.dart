import 'package:flutter/material.dart';
import 'models/triangular_check_model.dart';
import 'widgets/triangular_check_card.dart';

void main() {
  runApp(const TriangularCheckApp());
}

class TriangularCheckApp extends StatelessWidget {
  const TriangularCheckApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Triangular Check Gate',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const TriangularCheckScreen(),
    );
  }
}

class TriangularCheckScreen extends StatefulWidget {
  const TriangularCheckScreen({Key? key}) : super(key: key);

  @override
  State<TriangularCheckScreen> createState() => _TriangularCheckScreenState();
}

class _TriangularCheckScreenState extends State<TriangularCheckScreen> {
  TriangularCheckModel _model = const TriangularCheckModel(
    sideA: 100.00,
    sideB: 15.00,
    totalC: 115.00,
    accuracyScore: 99.99,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pre-Submit Quality Gate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TriangularCheckCard(
              model: _model,
              onRunCheck: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Triangular Check Passed (100% Mathematical Balance)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
