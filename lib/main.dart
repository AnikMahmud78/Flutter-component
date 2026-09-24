import 'package:flutter/material.dart';
import 'models/citation_model.dart';
import 'widgets/citation_chip.dart';

void main() {
  runApp(const CitationApp());
}

class CitationApp extends StatelessWidget {
  const CitationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M3 Citation Chips',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const CitationScreen(),
    );
  }
}

class CitationScreen extends StatefulWidget {
  const CitationScreen({Key? key}) : super(key: key);

  @override
  State<CitationScreen> createState() => _CitationScreenState();
}

class _CitationScreenState extends State<CitationScreen> {
  final List<CitationModel> _citations = [
    CitationModel(id: 'c1', sourceTitle: 'NIST 800-207 Zero Trust', url: 'https://nist.gov', index: 1),
    CitationModel(id: 'c2', sourceTitle: 'ISO/IEC 27001 Security', url: 'https://iso.org', index: 2),
    CitationModel(id: 'c3', sourceTitle: 'M3 Design Guidelines', url: 'https://m3.material.io', index: 3),
  ];

  void _onCitationTap(CitationModel citation) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening Citation [${citation.index}]: ${citation.url}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('M3 Citation Input Chips')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _citations
              .map((c) => CitationChip(citation: c, OnSelected: _onCitationTap))
              .toList(),
        ),
      ),
    );
  }
}
