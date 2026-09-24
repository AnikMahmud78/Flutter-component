import 'package:flutter/material.dart';
import 'models/bigquery_stream_model.dart';
import 'widgets/bigquery_stream_card.dart';

void main() {
  runApp(const BigQueryStreamApp());
}

class BigQueryStreamApp extends StatelessWidget {
  const BigQueryStreamApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BigQuery Streamer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const BigQueryStreamScreen(),
    );
  }
}

class BigQueryStreamScreen extends StatefulWidget {
  const BigQueryStreamScreen({Key? key}) : super(key: key);

  @override
  State<BigQueryStreamScreen> createState() => _BigQueryStreamScreenState();
}

class _BigQueryStreamScreenState extends State<BigQueryStreamScreen> {
  BigQueryStreamModel _model = const BigQueryStreamModel(
    traceId: 'TRC-9862-BQ',
    queuedEvents: 12,
    streamLatencyMinutes: 1.2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BigQuery Stream Monitor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BigQueryStreamCard(
              model: _model,
              onSimulateTileTap: () {
                setState(() {
                  _model = BigQueryStreamModel(
                    traceId: _model.traceId,
                    queuedEvents: _model.queuedEvents + 1,
                    streamLatencyMinutes: 1.2,
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Impression Event Streamed to BigQuery')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
