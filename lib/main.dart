import 'package:flutter/material.dart';
import 'widgets/shakti_blocking_banner_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shakti Alert Dismissal Prerequisite',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const ShaktiBlockingBannerWidget(),
    );
  }
}
