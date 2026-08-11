import 'package:flutter/material.dart';
import 'widgets/inactivity_monitor_wrapper.dart';

// Global Navigator Key attached to MaterialApp
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Attached here
      debugShowCheckedModeBanner: false,
      title: 'Platform Inactivity Monitor',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      builder: (context, child) {
        return InactivityMonitorWrapper(
          navigatorKey: navigatorKey, // Passed to wrapper
          inactivityTimeout: const Duration(seconds: 10),
          warningDuration: const Duration(seconds: 5),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const WorkstationHomeScreen(),
    );
  }
}

class WorkstationHomeScreen extends StatelessWidget {
  const WorkstationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operator Workstation'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.shield_rounded,
                      color: Colors.blue.shade800,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Passive Inactivity Safety Active',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Touch or click anywhere on screen to maintain active session timer.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
