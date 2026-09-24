import 'package:flutter/material.dart';
import 'models/qr_pass_model.dart';
import 'widgets/qr_pass_card.dart';

void main() {
  runApp(const QRPassApp());
}

class QRPassApp extends StatelessWidget {
  const QRPassApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT QR Pass',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const QRPassScreen(),
    );
  }
}

class QRPassScreen extends StatelessWidget {
  const QRPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const passModel = QRPassModel(
      passId: 'PASS-9499-XYZ',
      holderName: 'Enterprise Operator',
      payload: 'HABOT::TOKEN::9499::SECURE',
      scanSuccessRate: 0.998,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('M3 QR Container Pass')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: QRPassCard(
            model: passModel,
            onRefreshScan: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ISO/IEC 18004 Verification Passed (99.8%)')),
              );
            },
          ),
        ),
      ),
    );
  }
}
