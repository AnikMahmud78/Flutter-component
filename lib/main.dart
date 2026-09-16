import 'package:flutter/material.dart';
import 'widgets/input_field_group.dart';
import 'widgets/review_rigor_status_banner.dart';

void main() {
  runApp(const MolecularFormApp());
}

class MolecularFormApp extends StatelessWidget {
  const MolecularFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Molecular Form Components',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const MolecularFormScreen(),
    );
  }
}

class MolecularFormScreen extends StatefulWidget {
  const MolecularFormScreen({super.key});

  @override
  State<MolecularFormScreen> createState() => _MolecularFormScreenState();
}

class _MolecularFormScreenState extends State<MolecularFormScreen> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Molecular Form Elements (FIEVR-034)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const ReviewRigorStatusBanner(
              status: 'Pass',
              reviewLevel: '2 Senior Approvals + Security Scan Pass',
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputFieldGroup(
                  labelText: 'Molecular Component Identifier',
                  hintText: 'e.g., input_field_group_01',
                  helperText: 'Must comply with Design System token standards.',
                  controller: _ctrl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
