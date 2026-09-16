// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/md3_theme_provider.dart';
import 'widgets/framework_theme_banner.dart';

void main() {
  runApp(
    const MD3ThemeProvider(
      child: RootAppShell(),
    ),
  );
}

class RootAppShell extends StatelessWidget {
  const RootAppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HABOT MD3 Root Theme (GEN-00601)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              MD3ThemeProvider.of(context)?.toggleThemeMode();
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FrameworkThemeBanner(status: 'Pass', coverage: 1.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('MD3ThemeProvider active at root level.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
