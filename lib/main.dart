import 'package:flutter/material.dart';
import 'models/form_lock_model.dart';
import 'widgets/form_lock_card.dart';

void main() {
  runApp(const FormLockApp());
}

class FormLockApp extends StatelessWidget {
  const FormLockApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Lock Verification',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FormLockScreen(),
    );
  }
}

class FormLockScreen extends StatefulWidget {
  const FormLockScreen({Key? key}) : super(key: key);

  @override
  State<FormLockScreen> createState() => _FormLockScreenState();
}

class _FormLockScreenState extends State<FormLockScreen> {
  FormLockModel _model = const FormLockModel(isFormValid: false, lockRatePercentage: 100.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit State Lock Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FormLockCard(
              model: _model,
              onToggleValidity: (valid) {
                setState(() {
                  _model = FormLockModel(isFormValid: valid, lockRatePercentage: 100.0);
                });
              },
              onSubmit: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form Submitted Successfully')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
