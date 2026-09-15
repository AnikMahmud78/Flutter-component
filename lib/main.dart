import 'package:flutter/material.dart';
import 'widgets/adoption_metrics_logger_widget_7871FEBFL005A18.dart';

void main() {
  runApp(const AdoptionMetricsApp7871FEBFL005A18());
}

class AdoptionMetricsApp7871FEBFL005A18 extends StatelessWidget {
  const AdoptionMetricsApp7871FEBFL005A18({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adoption Metrics Logger App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AdoptionMetricsLoggerWidget7871FEBFL005A18(),
    );
  }
}
