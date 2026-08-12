import 'package:flutter/material.dart';
import 'widgets/security_dashboard_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Gateway Threat Dashboard',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: const SecurityDashboardWidget(),
    );
  }
}
