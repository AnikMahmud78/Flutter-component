import 'package:flutter/material.dart';
import 'models/commercial_analytics_model.dart';
import 'widgets/commercial_analytics_card.dart';

void main() {
  runApp(const CommercialAnalyticsApp());
}

class CommercialAnalyticsApp extends StatelessWidget {
  const CommercialAnalyticsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commercial Analytics App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const CommercialAnalyticsScreen(),
    );
  }
}

class CommercialAnalyticsScreen extends StatelessWidget {
  const CommercialAnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const commercialModel = CommercialAnalyticsModel(
      walletSharePercentage: 34.2,
      topSpendCategory: 'Childcare & Education',
      refreshLatencyMinutes: 2.5,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Commercial BI Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CommercialAnalyticsCard(
              model: commercialModel,
              onRefresh: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Commercial BI Synced (<5m SLA)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
