import 'package:flutter/material.dart';
import 'models/badge_config_model.dart';
import 'widgets/badge_inspector_card.dart';

void main() {
  runApp(const BadgeConfigApp());
}

class BadgeConfigApp extends StatelessWidget {
  const BadgeConfigApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inline Badge Configurator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const BadgeConfigScreen(),
    );
  }
}

class BadgeConfigScreen extends StatefulWidget {
  const BadgeConfigScreen({Key? key}) : super(key: key);

  @override
  State<BadgeConfigScreen> createState() => _BadgeConfigScreenState();
}

class _BadgeConfigScreenState extends State<BadgeConfigScreen> {
  late BadgeConfigModel _config;

  @override
  void initState() {
    super.initState();
    _config = BadgeConfigModel(
      badgeHeight: 24.0,
      touchTargetSize: 48.0,
      statusText: 'SECURE',
      validationResult: 'Pass',
    );
  }

  void _onBadgeTapped() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Security Badge Touch Target Triggered (48x48dp)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design System Token Audit')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: BadgeInspectorCard(
              config: _config,
              onTrigger: _onBadgeTapped,
            ),
          ),
        ),
      ),
    );
  }
}
