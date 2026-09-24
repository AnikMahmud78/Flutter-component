import 'package:flutter/material.dart';
import 'models/fat_finger_padding_model.dart';
import 'widgets/fat_finger_padding_card.dart';

void main() {
  runApp(const FatFingerPaddingApp());
}

class FatFingerPaddingApp extends StatelessWidget {
  const FatFingerPaddingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fat Finger Padding Protection',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const FatFingerPaddingScreen(),
    );
  }
}

class FatFingerPaddingScreen extends StatelessWidget {
  const FatFingerPaddingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const paddingModel = FatFingerPaddingModel(minTouchTargetDp: 48.0, prRejectionRate: 99.5);

    return Scaffold(
      appBar: AppBar(title: const Text('Padding Strategy Enforcer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FatFingerPaddingCard(
              model: paddingModel,
              onValidatePadding: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Touch Target Enforcement Passed (≥48x48dp)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
