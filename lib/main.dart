import 'package:flutter/material.dart';
import 'models/achievement_badge_model.dart';
import 'services/badge_award_engine.dart';
import 'widgets/achievement_badge_widget.dart';
import 'widgets/gamified_banner.dart';

void main() {
  runApp(const HABOTGamifiedApp());
}

class HABOTGamifiedApp extends StatelessWidget {
  const HABOTGamifiedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10335GEN-02106 MD3 Gamified Badges',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7B5300)),
      ),
      home: const GamifiedScreen(),
    );
  }
}

class GamifiedScreen extends StatefulWidget {
  const GamifiedScreen({super.key});

  @override
  State<GamifiedScreen> createState() => _GamifiedScreenState();
}

class _GamifiedScreenState extends State<GamifiedScreen> {
  late AchievementBadgeModel _model;

  @override
  void initState() {
    super.initState();
    _model = BadgeAwardEngine.fetchUserBadge(
      taskId: '10335GEN-02106',
      userId: 'USER-ANIK-8821',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MD3 Gamified Achievement Badges')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GamifiedBanner(rate: _model.completionRate),
            const SizedBox(height: 16.0),
            AchievementBadgeWidget(model: _model),
          ],
        ),
      ),
    );
  }
}
