import 'package:flutter/material.dart';
import 'widgets/sms_ingress_input_widget.dart';

void main() {
  runApp(const SmsIngressApp());
}

class SmsIngressApp extends StatelessWidget {
  const SmsIngressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMS Ingress Gateway App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      restorationScopeId: 'root_sms_app',
      home: const SmsIngressInputWidget(),
    );
  }
}
