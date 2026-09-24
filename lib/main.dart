import 'package:flutter/material.dart';
import 'models/fulfillment_bi_model.dart';
import 'widgets/fulfillment_bi_card.dart';

void main() {
  runApp(const FulfillmentBiApp());
}

class FulfillmentBiApp extends StatelessWidget {
  const FulfillmentBiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fulfillment BI App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const FulfillmentBiScreen(),
    );
  }
}

class FulfillmentBiScreen extends StatelessWidget {
  const FulfillmentBiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const biModel = FulfillmentBiModel(
      avgFulfillmentHours: 1.4,
      transitionSpeedSeconds: 12.5,
      activeBottlenecks: 0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Fulfillment BI Console')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FulfillmentBiCard(
              model: biModel,
              onRefresh: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Operational Metrics Synced (<5 mins SLA)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
