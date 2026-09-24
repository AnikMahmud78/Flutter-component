import 'package:flutter/material.dart';
import 'models/calamity_gap_model.dart';
import 'services/calamity_channel_service.dart';
import 'widgets/calamity_alert_card.dart';
import 'widgets/escalation_header.dart';

void main() {
  runApp(const HABOTCalamityApp());
}

class HABOTCalamityApp extends StatelessWidget {
  const HABOTCalamityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10181GEN-01949 Calamity Channel',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB3261E)),
      ),
      home: const CalamityScreen(),
    );
  }
}

class CalamityScreen extends StatefulWidget {
  const CalamityScreen({super.key});

  @override
  State<CalamityScreen> createState() => _CalamityScreenState();
}

class _CalamityScreenState extends State<CalamityScreen> {
  late CalamityGapModel _model;

  @override
  void initState() {
    super.initState();
    _loadGap();
  }

  void _loadGap() {
    setState(() {
      _model = CalamityChannelService.fetchActiveGap(
        taskId: '10181GEN-01949',
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calamity Channel Governance')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EscalationHeader(rate: _model.completionRate),
            const SizedBox(height: 16.0),
            CalamityAlertCard(model: _model, onAcknowledge: _loadGap),
          ],
        ),
      ),
    );
  }
}
