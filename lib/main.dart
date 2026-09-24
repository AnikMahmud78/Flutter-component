import 'package:flutter/material.dart';
import 'models/websocket_badge_model.dart';
import 'widgets/websocket_badge_card.dart';

void main() {
  runApp(const WebSocketBadgeApp());
}

class WebSocketBadgeApp extends StatelessWidget {
  const WebSocketBadgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket Badge App',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const WebSocketBadgeScreen(),
    );
  }
}

class WebSocketBadgeScreen extends StatefulWidget {
  const WebSocketBadgeScreen({Key? key}) : super(key: key);

  @override
  State<WebSocketBadgeScreen> createState() => _WebSocketBadgeScreenState();
}

class _WebSocketBadgeScreenState extends State<WebSocketBadgeScreen> {
  WebSocketBadgeModel _model = const WebSocketBadgeModel(unreadCount: 3, syncSuccessRate: 0.999);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebSocket Badge Controller')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            WebSocketBadgeCard(
              model: _model,
              onSimulateMessage: () {
                setState(() {
                  _model = WebSocketBadgeModel(
                    unreadCount: _model.unreadCount + 1,
                    syncSuccessRate: 0.999,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
