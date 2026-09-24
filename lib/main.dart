import 'package:flutter/material.dart';
import 'models/progressive_disclosure_model.dart';
import 'widgets/progressive_disclosure_card.dart';

void main() {
  runApp(const ProgressiveDisclosureApp());
}

class ProgressiveDisclosureApp extends StatelessWidget {
  const ProgressiveDisclosureApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progressive Disclosure Gate',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ProgressiveDisclosureScreen(),
    );
  }
}

class ProgressiveDisclosureScreen extends StatefulWidget {
  const ProgressiveDisclosureScreen({Key? key}) : super(key: key);

  @override
  State<ProgressiveDisclosureScreen> createState() => _ProgressiveDisclosureScreenState();
}

class _ProgressiveDisclosureScreenState extends State<ProgressiveDisclosureScreen> {
  ProgressiveDisclosureModel _model = const ProgressiveDisclosureModel(isExpanded: false, prRejectionRate: 99.5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progressive Disclosure Console')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProgressiveDisclosureCard(
              model: _model,
              onExpansionChanged: (expanded) {
                setState(() {
                  _model = ProgressiveDisclosureModel(isExpanded: expanded, prRejectionRate: 99.5);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
