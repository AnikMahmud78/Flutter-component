import 'package:flutter/material.dart';
import 'widgets/lead_conversion_listener_widget.dart';

void main() {
  runApp(const LeadConversionListenerApp());
}

class LeadConversionListenerApp extends StatelessWidget {
  const LeadConversionListenerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lead Conversion Listener App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LeadConversionListenerWidget(),
    );
  }
}
