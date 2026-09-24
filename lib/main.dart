import 'package:flutter/material.dart';
import 'models/provider_latency_model.dart';
import 'widgets/provider_latency_card.dart';

void main() {
  runApp(const ProviderLatencyApp());
}

class ProviderLatencyApp extends StatelessWidget {
  const ProviderLatencyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Communication Dashboard',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
      home: const ProviderLatencyScreen(),
    );
  }
}

class ProviderLatencyScreen extends StatefulWidget {
  const ProviderLatencyScreen({Key? key}) : super(key: key);

  @override
  State<ProviderLatencyScreen> createState() => _ProviderLatencyScreenState();
}

class _ProviderLatencyScreenState extends State<ProviderLatencyScreen> {
  late ProviderLatencyModel _model;

  @override
  void initState() {
    super.initState();
    _model = ProviderLatencyModel(
      providerId: 'PRV-9521',
      responseSlaMinutes: 2.4,
      engagementRate: 0.92,
      lastRefreshed: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Engagement Monitor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProviderLatencyCard(
              model: _model,
              onRefresh: () {
                setState(() {
                  _model = ProviderLatencyModel(
                    providerId: 'PRV-9521',
                    responseSlaMinutes: 2.1,
                    engagementRate: 0.94,
                    lastRefreshed: DateTime.now(),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
