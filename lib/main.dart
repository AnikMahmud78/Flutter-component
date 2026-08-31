import 'package:flutter/material.dart';
import 'widgets/marketplace_search_console_widget.dart';

void main() {
  runApp(const MarketplaceSearchApp());
}

class MarketplaceSearchApp extends StatelessWidget {
  const MarketplaceSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketplace Search Console',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const MarketplaceSearchConsoleWidget(),
    );
  }
}
