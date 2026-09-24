import 'package:flutter/material.dart';
import 'models/mobile_funnel_model.dart';
import 'widgets/mobile_funnel_card.dart';

void main() {
  runApp(const MobileFunnelApp());
}

class MobileFunnelApp extends StatelessWidget {
  const MobileFunnelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Mobile Funnel',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      home: const MobileFunnelScreen(),
    );
  }
}

class MobileFunnelScreen extends StatefulWidget {
  const MobileFunnelScreen({Key? key}) : super(key: key);

  @override
  State<MobileFunnelScreen> createState() => _MobileFunnelScreenState();
}

class _MobileFunnelScreenState extends State<MobileFunnelScreen> {
  MobileFunnelModel _model = const MobileFunnelModel(funnelStage: 'Vendor Profile Setup', completionRate: 0.82);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marketplace Onboarding Funnel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MobileFunnelCard(
              model: _model,
              onProceedNextStep: () {
                setState(() {
                  _model = const MobileFunnelModel(funnelStage: 'Identity Verification', completionRate: 0.88);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
