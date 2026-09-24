import 'package:flutter/material.dart';
import 'models/uri_context_model.dart';
import 'services/uri_parser_engine.dart';
import 'widgets/uri_context_card.dart';
import 'widgets/routing_banner.dart';

void main() {
  runApp(const HABOTUriApp());
}

class HABOTUriApp extends StatelessWidget {
  const HABOTUriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10313GEN-02084 URI Context',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF535D7E)),
      ),
      home: const UriScreen(),
    );
  }
}

class UriScreen extends StatefulWidget {
  const UriScreen({super.key});

  @override
  State<UriScreen> createState() => _UriScreenState();
}

class _UriScreenState extends State<UriScreen> {
  late UriContextModel _model;

  @override
  void initState() {
    super.initState();
    _parse();
  }

  void _parse() {
    setState(() {
      _model = UriParserEngine.parseUri(
        'habot://console/execution?task_id=10313GEN-02084&trace_id=TRACE-992-2026',
        'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('URI Context Deep-Link Engine')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RoutingBanner(rate: _model.completionRate),
            const SizedBox(height: 16.0),
            UriContextCard(model: _model, onParseNewUri: _parse),
          ],
        ),
      ),
    );
  }
}
