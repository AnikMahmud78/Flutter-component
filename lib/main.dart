// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/notification_preference_card.dart';
import 'widgets/preference_capture_banner.dart';

void main() {
  runApp(const NotificationPreferenceScreenApp());
}

class NotificationPreferenceScreenApp extends StatelessWidget {
  const NotificationPreferenceScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Preferences (GEN-01100)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const NotificationPreferenceScreen(),
    );
  }
}

class NotificationPreferenceScreen extends StatelessWidget {
  const NotificationPreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Preferences (GEN-01100)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            PreferenceCaptureBanner(status: 'Complete', completeness: 0.99),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: NotificationPreferenceCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
