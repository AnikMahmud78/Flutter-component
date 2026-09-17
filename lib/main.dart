// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/md3_bottom_sheet_card.dart';
import 'widgets/touch_target_banner.dart';

void main() {
  runApp(const Md3BottomSheetScreenApp());
}

class Md3BottomSheetScreenApp extends StatelessWidget {
  const Md3BottomSheetScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MD3 Bottom-Sheet UI (GEN-00956)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const Md3BottomSheetScreen(),
    );
  }
}

class Md3BottomSheetScreen extends StatelessWidget {
  const Md3BottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MD3 Bottom-Sheet UI (GEN-00956)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TouchTargetBanner(status: 'Pass', minTouchTarget: 48.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Md3BottomSheetCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
