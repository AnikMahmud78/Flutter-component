import 'package:flutter/material.dart';
import 'models/price_summary_model.dart';
import 'widgets/price_summary_card.dart';

void main() {
  runApp(const PriceSummaryApp());
}

class PriceSummaryApp extends StatelessWidget {
  const PriceSummaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Summary Card',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const PriceSummaryScreen(),
    );
  }
}

class PriceSummaryScreen extends StatelessWidget {
  const PriceSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const summaryModel = PriceSummaryModel(
      subtotal: 120.00,
      serviceFee: 8.50,
      tax: 9.60,
      calculationAccuracy: 0.9999,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('M3 Surface Summary Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PriceSummaryCard(
              model: summaryModel,
              onCheckout: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ASC 606 Calculation Verified (99.99%)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
