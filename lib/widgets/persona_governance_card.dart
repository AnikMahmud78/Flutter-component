import 'package:flutter/material.dart';
import '../models/persona_config_model.dart';

class PersonaGovernanceCard extends StatelessWidget {
  final PersonaConfigModel model;
  final VoidCallback onConfirm;

  const PersonaGovernanceCard({
    Key? key,
    required this.model,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Persona Governance', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Notebook ID: ${model.notebookId}'),
            Text('Assigned Persona: ${model.personaName}'),
            Text('Tone Guidelines: ${model.toneGuideline}'),
            Text('Prompt Reuse Rate: ${model.reuseRate}%'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onConfirm,
              child: const Text('Confirm Governance Policy'),
            ),
          ],
        ),
      ),
    );
  }
}
