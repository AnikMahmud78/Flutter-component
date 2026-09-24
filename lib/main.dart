import 'package:flutter/material.dart';
import 'models/notification_prompt_model.dart';
import 'widgets/notification_prompt_card.dart';

void main() {
  runApp(const NotificationPromptApp());
}

class NotificationPromptApp extends StatelessWidget {
  const NotificationPromptApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Notification Preferences',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const NotificationPromptScreen(),
    );
  }
}

class NotificationPromptScreen extends StatelessWidget {
  const NotificationPromptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const promptModel = NotificationPromptModel(frequencySetting: 'Daily Digest', verificationScore: 0.95);

    return Scaffold(
      appBar: AppBar(title: const Text('Notification Prompts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            NotificationPromptCard(
              model: promptModel,
              onOpenPreferences: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text('M3 Notification Frequency Selection Sheet'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
