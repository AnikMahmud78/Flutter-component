import 'package:flutter/material.dart';
import 'widgets/cpa_micro_gauges_8069CCBPB019.dart';

void main() {
  runApp(const CpaMicroGauges8069CCBPB019App());
}

class CpaMicroGauges8069CCBPB019App extends StatelessWidget {
  const CpaMicroGauges8069CCBPB019App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CPA Micro-Gauges App',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const CpaMicroGauges8069CCBPB019(),
  );
}
