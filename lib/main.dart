// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/cohort_sql_card.dart';
import 'widgets/ansi_sql_banner.dart';

void main() {
  runApp(const CohortSqlApp());
}

class CohortSqlApp extends StatelessWidget {
  const CohortSqlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cohort Retention SQL Engine',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CohortSqlScreen(),
    );
  }
}

class CohortSqlScreen extends StatelessWidget {
  const CohortSqlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cohort Retention SQL (GEN-00745)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AnsiSqlBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CohortSqlCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
