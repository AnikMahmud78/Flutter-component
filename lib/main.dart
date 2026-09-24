import 'package:flutter/material.dart';
import 'models/review_sla_model.dart';
import 'widgets/review_sla_timer_card.dart';

void main() {
  runApp(const ReviewSLAApp());
}

class ReviewSLAApp extends StatelessWidget {
  const ReviewSLAApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT SLA Timer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ReviewSLAScreen(),
    );
  }
}

class ReviewSLAScreen extends StatefulWidget {
  const ReviewSLAScreen({Key? key}) : super(key: key);

  @override
  State<ReviewSLAScreen> createState() => _ReviewSLAScreenState();
}

class _ReviewSLAScreenState extends State<ReviewSLAScreen> {
  late ReviewSLAModel _sampleModel;

  @override
  void initState() {
    super.initState();
    _sampleModel = ReviewSLAModel(
      reviewId: 'REV-9488-001',
      riskLevel: 'HIGH',
      createdAt: DateTime.now(),
      verificationScore: 0.95,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HABOT SLA Risk Monitor')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ReviewSLATimerCard(
              model: _sampleModel,
              onResolve: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Risk successfully resolved within SLA!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
