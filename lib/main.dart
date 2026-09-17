// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/financial_reconciliation_card.dart';
import 'widgets/reconciliation_variance_banner.dart';

void main() {
  runApp(const FinancialReconciliationScreenApp());
}

class FinancialReconciliationScreenApp extends StatelessWidget {
  const FinancialReconciliationScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Reconciliation (GEN-00934)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const FinancialReconciliationScreen(),
    );
  }
}

class FinancialReconciliationScreen extends StatelessWidget {
  const FinancialReconciliationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financial Reconciliation (GEN-00934)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ReconciliationVarianceBanner(status: 'Pass', varianceAed: 0.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: FinancialReconciliationCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
