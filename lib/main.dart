import 'package:flutter/material.dart';
import 'widgets/shakti_alert_panel.dart';
import 'widgets/breach_status_banner.dart';

void main() {
  runApp(const ShaktiAlertApp());
}

class ShaktiAlertApp extends StatelessWidget {
  const ShaktiAlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shakti Alert Panel',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: ShaktiAlertPanel(
        child: Scaffold(
          appBar: AppBar(title: const Text('System Workspace')),
          body: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 180), // Offset for top panel
                BreachStatusBanner(status: 'Good (100%)', qualityScore: 1.0),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Main Workspace Active - Protected by Shakti Handler'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
