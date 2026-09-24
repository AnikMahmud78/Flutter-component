import 'package:flutter/material.dart';
import 'models/adaptive_layout_model.dart';
import 'services/layout_breakpoint_engine.dart';
import 'widgets/adaptive_navigation_shell.dart';
import 'widgets/completion_status_card.dart';

void main() {
  runApp(const HABOTAdaptiveLayoutApp());
}

class HABOTAdaptiveLayoutApp extends StatelessWidget {
  const HABOTAdaptiveLayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10236GEN-02005 Layout Router',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
      ),
      home: const LayoutRouterScreen(),
    );
  }
}

class LayoutRouterScreen extends StatelessWidget {
  const LayoutRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final AdaptiveLayoutModel model = LayoutBreakpointEngine.evaluateWidth(
      width,
      '10236GEN-02005',
      'USER-ANIK-8821',
    );

    return AdaptiveNavigationShell(
      model: model,
      child: Scaffold(
        appBar: AppBar(title: const Text('Dynamic Component Mount/Unmount Router')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CompletionStatusCard(
            rate: model.completionRate,
            activeMode: model.currentMode.name.toUpperCase(),
          ),
        ),
      ),
    );
  }
}
