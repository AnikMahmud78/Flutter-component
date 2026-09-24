import 'package:flutter/material.dart';
import 'models/fcm_priority_model.dart';
import 'widgets/fcm_priority_card.dart';

void main() {
  runApp(const FcmPriorityApp());
}

class FcmPriorityApp extends StatelessWidget {
  const FcmPriorityApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCM Priority Alert',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const FcmPriorityScreen(),
    );
  }
}

class FcmPriorityScreen extends StatelessWidget {
  const FcmPriorityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const fcmModel = FcmPriorityModel(
      channelId: 'HABOT_CRITICAL_ALERTS',
      isHighPriority: true,
      mttdMinutes: 1,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('FCM Alert Configuration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FcmPriorityCard(
              model: fcmModel,
              onTestAlert: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lock Screen High-Priority Alert Sent (MTTD <2m)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
