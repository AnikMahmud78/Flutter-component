import 'package:flutter/material.dart';
import 'widgets/reconnecting_indicator.dart';

void main() {
  runApp(const ReconnectApp());
}

class ReconnectApp extends StatelessWidget {
  const ReconnectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: Scaffold(
        appBar: AppBar(title: const Text('Network Continuity Console')),
        body: Column(
          children: const [
            ReconnectingIndicator(isReconnecting: true),
            Expanded(
              child: Center(
                child: Text('Dashboard operational during partial recovery.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
