import 'package:flutter/material.dart';
import 'models/message_age_alert_model.dart';
import 'widgets/message_age_alert_card.dart';

void main() {
  runApp(const MessageAgeAlertApp());
}

class MessageAgeAlertApp extends StatelessWidget {
  const MessageAgeAlertApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message Age Alert Monitor',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MessageAgeAlertScreen(),
    );
  }
}

class MessageAgeAlertScreen extends StatefulWidget {
  const MessageAgeAlertScreen({Key? key}) : super(key: key);

  @override
  State<MessageAgeAlertScreen> createState() => _MessageAgeAlertScreenState();
}

class _MessageAgeAlertScreenState extends State<MessageAgeAlertScreen> {
  MessageAgeAlertModel _model = MessageAgeAlertModel(
    queueTopic: 'habot-events-v1',
    maxUnacknowledgedAgeSeconds: 8,
    lastChecked: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Queue SLA Monitor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MessageAgeAlertCard(
              model: _model,
              onTriggerPoll: () {
                setState(() {
                  _model = MessageAgeAlertModel(
                    queueTopic: 'habot-events-v1',
                    maxUnacknowledgedAgeSeconds: 5,
                    lastChecked: DateTime.now(),
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Queue Polled: SLA Compliant (5s)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
