import 'package:flutter/material.dart';
import 'models/persona_config_model.dart';
import 'widgets/persona_governance_card.dart';

void main() {
  runApp(const PersonaGovernanceApp());
}

class PersonaGovernanceApp extends StatelessWidget {
  const PersonaGovernanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persona Governance Audit',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const PersonaScreen(),
    );
  }
}

class PersonaScreen extends StatefulWidget {
  const PersonaScreen({Key? key}) : super(key: key);

  @override
  State<PersonaScreen> createState() => _PersonaScreenState();
}

class _PersonaScreenState extends State<PersonaScreen> {
  late PersonaConfigModel _model;

  @override
  void initState() {
    super.initState();
    _model = PersonaConfigModel(
      notebookId: 'NB-HABOT-2026',
      personaName: 'Lead Systems Architect & Automation Engineer',
      toneGuideline: 'Rigorous, Technical, Direct, Concise',
      reuseRate: 92.5,
      status: 'Good',
    );
  }

  void _confirmPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Domain persona & tone guidelines confirmed for notebook.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prompt Persona Governance')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PersonaGovernanceCard(
              model: _model,
              onConfirm: _confirmPolicy,
            ),
          ),
        ),
      ),
    );
  }
}
