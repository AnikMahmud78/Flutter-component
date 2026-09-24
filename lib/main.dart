import 'package:flutter/material.dart';
import 'models/dispute_bi_model.dart';
import 'widgets/dispute_bi_card.dart';

void main() {
  runApp(const DisputeBiApp());
}

class DisputeBiApp extends StatelessWidget {
  const DisputeBiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dispute BI Support',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const DisputeBiScreen(),
    );
  }
}

class DisputeBiScreen extends StatelessWidget {
  const DisputeBiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const biModel = DisputeBiModel(
      totalDisputes: 14,
      topCategory: 'Billing Discrepancy',
      resolutionCycleHours: 36,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Operational Support Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DisputeBiCard(
              model: biModel,
              onRefresh: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ODR ISO 20488 SLA Verified (<48 Hours)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
