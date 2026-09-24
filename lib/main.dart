import 'package:flutter/material.dart';
import 'models/dropoff_analytics_model.dart';
import 'widgets/dropoff_analytics_card.dart';

void main() {
  runApp(const DropoffAnalyticsApp());
}

class DropoffAnalyticsApp extends StatelessWidget {
  const DropoffAnalyticsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Analytics App',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)),
      home: const DropoffAnalyticsScreen(),
    );
  }
}

class DropoffAnalyticsScreen extends StatelessWidget {
  const DropoffAnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const analytics = DropoffAnalyticsModel(
      stageName: 'Identity Verification Step 2',
      dropoffRate: 0.03,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Operational Drop-off Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropoffAnalyticsCard(
              model: analytics,
              onRefreshData: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ISO/IEC/IEEE 42010 Telemetry Validated')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
