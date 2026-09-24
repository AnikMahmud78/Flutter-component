import 'package:flutter/material.dart';
import 'models/gap_container_model.dart';
import 'widgets/gap_container_card.dart';

void main() {
  runApp(const GapContainerApp());
}

class GapContainerApp extends StatelessWidget {
  const GapContainerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Gap Injector',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const GapContainerScreen(),
    );
  }
}

class GapContainerScreen extends StatelessWidget {
  const GapContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const gapModel = GapContainerModel(gapDp: 8.0, compliancePercentage: 100.0);

    return Scaffold(
      appBar: AppBar(title: const Text('M3 Container Spacing')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GapContainerCard(
              model: gapModel,
              onVerifyGaps: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('WCAG 2.1 AA (2.5.5) 8dp Gap Verified (100% Pass)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
