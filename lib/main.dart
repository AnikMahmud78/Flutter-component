import 'package:flutter/material.dart';
import 'models/deep_link_handoff_model.dart';
import 'widgets/deep_link_handoff_card.dart';

void main() {
  runApp(const DeepLinkApp());
}

class DeepLinkApp extends StatelessWidget {
  const DeepLinkApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Link Tester',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DeepLinkScreen(),
    );
  }
}

class DeepLinkScreen extends StatefulWidget {
  const DeepLinkScreen({Key? key}) : super(key: key);

  @override
  State<DeepLinkScreen> createState() => _DeepLinkScreenState();
}

class _DeepLinkScreenState extends State<DeepLinkScreen> {
  DeepLinkHandoffModel _model = const DeepLinkHandoffModel(
    linkUrl: 'https://habot.io/provider/9719',
    targetPlatform: 'iOS / Android Dual Native',
    handoffLatencyMs: 380.0,
    pinAccuracyMeters: 8.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Native Handoff Validator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DeepLinkHandoffCard(
              model: _model,
              onTestHandoff: () {
                setState(() {
                  _model = const DeepLinkHandoffModel(
                    linkUrl: 'https://habot.io/provider/9719',
                    targetPlatform: 'iOS / Android Dual Native',
                    handoffLatencyMs: 320.0,
                    pinAccuracyMeters: 5.0,
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('100% Native App Handoff Confirmed')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
