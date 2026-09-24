import 'package:flutter/material.dart';
import 'models/review_exception_model.dart';
import 'widgets/review_exception_card.dart';

void main() {
  runApp(const ReviewExceptionApp());
}

class ReviewExceptionApp extends StatelessWidget {
  const ReviewExceptionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ops Exception View',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const ReviewExceptionScreen(),
    );
  }
}

class ReviewExceptionScreen extends StatelessWidget {
  const ReviewExceptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const exceptionModel = ReviewExceptionModel(
      exceptionId: 'EXC-9796-01',
      flaggedReason: 'Suspicious IP/Review Velocity Spike',
      verificationRate: 0.99,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Ops Exception View Package')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ReviewExceptionCard(
              model: exceptionModel,
              onResolveException: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exception Audited Under ISO 20488')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
