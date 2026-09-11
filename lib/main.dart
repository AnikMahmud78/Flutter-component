import 'package:flutter/material.dart';
import 'widgets/signature_pad_verification_6364CKCKM022A12.dart';

void main() {
  runApp(const SignaturePadVerification6364CKCKM022A12App());
}

class SignaturePadVerification6364CKCKM022A12App extends StatelessWidget {
  const SignaturePadVerification6364CKCKM022A12App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Signature Pad Verification App',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const SignaturePadVerification6364CKCKM022A12(),
  );
}
