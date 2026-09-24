import 'package:flutter/material.dart';
import 'widgets/wizard_layout_widget.dart';
import 'widgets/auto_focus_search_bar.dart';

void main() {
  runApp(const HabotEnterpriseApp());
}

class HabotEnterpriseApp extends StatelessWidget {
  const HabotEnterpriseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Design System Console',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HABOT Mobile Infrastructure Console'),
        ),
        body: SafeArea(
          child: Column(
            children: const [
              AutoFocusSearchBar(),
              Expanded(child: WizardLayoutWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
