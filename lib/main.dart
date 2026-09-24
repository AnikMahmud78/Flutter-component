import 'package:flutter/material.dart';
import 'models/qr_expand_model.dart';
import 'widgets/qr_expand_card.dart';

void main() {
  runApp(const QRExpandApp());
}

class QRExpandApp extends StatelessWidget {
  const QRExpandApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Pass Expand Gesture',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const QRExpandScreen(),
    );
  }
}

class QRExpandScreen extends StatelessWidget {
  const QRExpandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const passModel = QRExpandModel(passId: 'PASS-9807-FULL', scanSuccessRate: 0.999);

    return Scaffold(
      appBar: AppBar(title: const Text('QR Pass Gesture View')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: QRExpandCard(
            model: passModel,
            onTapExpand: () {
              showDialog(
                context: context,
                builder: (ctx) => Dialog.fullscreen(
                  child: Scaffold(
                    appBar: AppBar(title: const Text('Full-Screen QR Pass')),
                    body: const Center(
                      child: Icon(Icons.qr_code_2, size: 280.0),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
