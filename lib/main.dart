import 'package:flutter/material.dart';
import 'theme/app_typography_tokens.dart';
import 'widgets/typography_scale_demo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Typography Scale Mapping & Scaling Strategy',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        // REQUIREMENT: Application-wide MD3 Typography Scale Token Mapping
        textTheme: AppTypographyTokens.buildMd3TextTheme(),
      ),
      home: const TypographyScaleDemoScreen(),
    );
  }
}
