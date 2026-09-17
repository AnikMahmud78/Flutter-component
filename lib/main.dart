// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/service_ctr_card.dart';
import 'widgets/dashboard_refresh_banner.dart';

void main() {
  runApp(const ServiceCtrScreenApp());
}

class ServiceCtrScreenApp extends StatelessWidget {
  const ServiceCtrScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service CTR Dashboard (GEN-01156)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ServiceCtrScreen(),
    );
  }
}

class ServiceCtrScreen extends StatelessWidget {
  const ServiceCtrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service CTR Dashboard (GEN-01156)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DashboardRefreshBanner(status: 'Good', refreshLatency: '<5 minutes'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ServiceCtrCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
