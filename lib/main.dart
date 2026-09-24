import 'package:flutter/material.dart';
import 'models/age_verification_model.dart';
import 'widgets/age_verification_gate_card.dart';

void main() {
  runApp(const AgeVerificationApp());
}

class AgeVerificationApp extends StatelessWidget {
  const AgeVerificationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Verification Gate',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const AgeVerificationScreen(),
    );
  }
}

class AgeVerificationScreen extends StatefulWidget {
  const AgeVerificationScreen({Key? key}) : super(key: key);

  @override
  State<AgeVerificationScreen> createState() => _AgeVerificationScreenState();
}

class _AgeVerificationScreenState extends State<AgeVerificationScreen> {
  AgeVerificationModel _model = const AgeVerificationModel(
    childAgeYears: 6,
    providerMinAgeYears: 5,
    providerMaxAgeYears: 12,
    captureAccuracy: 0.999,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service Age Gate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AgeVerificationGateCard(
              model: _model,
              onAgeChanged: (newAge) {
                if (newAge >= 0) {
                  setState(() {
                    _model = AgeVerificationModel(
                      childAgeYears: newAge,
                      providerMinAgeYears: 5,
                      providerMaxAgeYears: 12,
                      captureAccuracy: 0.999,
                    );
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
