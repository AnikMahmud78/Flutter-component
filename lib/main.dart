import 'package:flutter/material.dart';
import 'models/secure_lock_model.dart';
import 'widgets/secure_lock_badge_card.dart';

void main() {
  runApp(const SecureLockApp());
}

class SecureLockApp extends StatelessWidget {
  const SecureLockApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Lock Chassis',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SecureLockScreen(),
    );
  }
}

class SecureLockScreen extends StatelessWidget {
  const SecureLockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const lockModel = SecureLockModel(isEncrypted: true, recognitionAccuracy: 0.96);

    return Scaffold(
      appBar: AppBar(title: const Text('Card Form Chassis')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SecureLockBadgeCard(
              model: lockModel,
              onFormSubmitted: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment Method Saved (ISO 9186 Verified)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
