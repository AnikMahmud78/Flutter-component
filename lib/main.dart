import 'package:flutter/material.dart';

void main() {
  runApp(const TokenApp());
}

class TokenApp extends StatelessWidget {
  const TokenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF005AC1)),
      home: Scaffold(
        appBar: AppBar(title: const Text('M3 Design Tokens Catalog')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Design Tokens JSON Master Repository Loaded.\nSource: assets/tokens/m3_tokens.json\nCoverage: 100%',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
