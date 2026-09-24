import 'package:flutter/material.dart';
import 'models/atomic_byt_model.dart';
import 'widgets/atomic_byt_card.dart';

void main() {
  runApp(const AtomicBytApp());
}

class AtomicBytApp extends StatelessWidget {
  const AtomicBytApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atomic Byt Enforcer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const AtomicBytScreen(),
    );
  }
}

class AtomicBytScreen extends StatelessWidget {
  const AtomicBytScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bytModel = AtomicBytModel(
      bytName: 'Md3StatusChipByt',
      isAtomicCompliant: true,
      completionRate: 100.0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Atomic Byt Governance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AtomicBytCard(
              model: bytModel,
              onInspectByt: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Atomic Component Standard Verified')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
