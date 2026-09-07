import 'package:flutter/material.dart';
import 'widgets/lead_conversion_color_token_widget.dart';

void main() {
  runApp(const LeadConversionTokenApp());
}

class LeadConversionTokenApp extends StatelessWidget {
  const LeadConversionTokenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M3 Lead Conversion Token App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LeadConversionColorTokenWidget(),
    );
  }
}
