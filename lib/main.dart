import 'package:flutter/material.dart';
import 'widgets/global_app_shell_widget.dart';

void main() {
  runApp(const AppShellApplication());
}

class AppShellApplication extends StatelessWidget {
  const AppShellApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Global Corporate App Shell',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const GlobalAppShellWidget(),
    );
  }
}
