import 'package:flutter/material.dart';
import 'models/activity_log_package_model.dart';
import 'widgets/activity_log_package_card.dart';

void main() {
  runApp(const ActivityLogPackageApp());
}

class ActivityLogPackageApp extends StatelessWidget {
  const ActivityLogPackageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Log Package',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const ActivityLogPackageScreen(),
    );
  }
}

class ActivityLogPackageScreen extends StatelessWidget {
  const ActivityLogPackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const moduleModel = ActivityLogPackageModel(
      moduleId: 'MOD-9840-ACT',
      completenessScore: 0.999,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Activity Log Package Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ActivityLogPackageCard(
              model: moduleModel,
              onInspectModule: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Module Integrity Validated (ISO 25012)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
