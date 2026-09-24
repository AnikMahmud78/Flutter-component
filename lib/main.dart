import 'package:flutter/material.dart';
import 'models/calamity_alert_model.dart';
import 'widgets/calamity_dashboard_card.dart';

void main() {
  runApp(const CalamityAlertApp());
}

class CalamityAlertApp extends StatelessWidget {
  const CalamityAlertApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calamity Alert Management',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const CalamityScreen(),
    );
  }
}

class CalamityScreen extends StatefulWidget {
  const CalamityScreen({Key? key}) : super(key: key);

  @override
  State<CalamityScreen> createState() => _CalamityScreenState();
}

class _CalamityScreenState extends State<CalamityScreen> {
  late CalamityAlertModel _alert;

  @override
  void initState() {
    super.initState();
    _alert = CalamityAlertModel(
      alertId: 'CALAMITY-9901',
      description: 'API egress logic failure detected. Requires Tech to rewrite routing logic.',
      isCleared: false,
      requiredFixLogic: 'return egressIp.isCorporate;',
    );
  }

  void _resolveAlert(String submittedCode) {
    if (submittedCode.trim() == _alert.requiredFixLogic) {
      setState(() {
        _alert = CalamityAlertModel(
          alertId: _alert.alertId,
          description: _alert.description,
          isCleared: true,
          requiredFixLogic: _alert.requiredFixLogic,
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logic check failed. Incorrect code rewrite.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team Engineering Console')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: CalamityDashboardCard(
              model: _alert,
              OnResolveSubmitted: _resolveAlert,
            ),
          ),
        ),
      ),
    );
  }
}
