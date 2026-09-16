// lib/widgets/md3_theme_provider.dart
import 'package:flutter/material.dart';

class MD3ThemeProvider extends StatefulWidget {
  final Widget child;

  const MD3ThemeProvider({super.key, required this.child});

  static _MD3ThemeProviderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MD3ThemeProviderState>();
  }

  @override
  State<MD3ThemeProvider> createState() => _MD3ThemeProviderState();
}

class _MD3ThemeProviderState extends State<MD3ThemeProvider> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleThemeMode() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Mobile Ecosystem',
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: widget.child,
    );
  }
}
