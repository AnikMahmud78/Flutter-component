import 'package:flutter/material.dart';
import 'widgets/query_placeholder_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Query Skeleton Placeholder UI',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const SkeletonDemoScreen(),
    );
  }
}

class SkeletonDemoScreen extends StatefulWidget {
  const SkeletonDemoScreen({super.key});

  @override
  State<SkeletonDemoScreen> createState() => _SkeletonDemoScreenState();
}

class _SkeletonDemoScreenState extends State<SkeletonDemoScreen> {
  // Simulated normal query (Resolves in 2 seconds)
  Future<Map<String, String>> _fetchFastQuery() async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'title': 'BigQuery Log Stream #0348',
      'subtitle': 'Latency: 240ms | Rows: 20',
      'status': '200 OK',
    };
  }

  // Simulated hung query (Will trigger 10-second timeout error)
  Future<Map<String, String>> _fetchSlowQuery() async {
    await Future.delayed(const Duration(seconds: 15));
    return {'title': 'Should not reach'};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Query Placeholder Skeleton Loaders'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Normal Query (Resolves in 2s)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            QueryPlaceholderCard(queryFuture: _fetchFastQuery()),

            const SizedBox(height: 28),

            const Text(
              '2. High Latency Query (>10s Timeout Safeguard)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            QueryPlaceholderCard(queryFuture: _fetchSlowQuery()),
          ],
        ),
      ),
    );
  }
}
