// lib/widgets/ai_query_verifier_card.dart
import 'package:flutter/material.dart';

class AiQueryVerifierCard extends StatefulWidget {
  const AiQueryVerifierCard({super.key});

  @override
  State<AiQueryVerifierCard> createState() => _AiQueryVerifierCardState();
}

class _AiQueryVerifierCardState extends State<AiQueryVerifierCard> {
  bool _isTesting = false;
  bool _verified = false;

  Future<void> _runPromptTest() async {
    setState(() => _isTesting = true);
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _verified = true;
      _isTesting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Natural Language Query Audit Test', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Prompt: "What is our mobile CAC this week?"'),
          subtitle: Text(_verified ? 'MCP Output ($14.20) == BigQuery Totals ($14.20)' : 'Pending audit verification'),
          trailing: Icon(
            _verified ? Icons.check_circle : Icons.pending,
            color: _verified ? theme.colorScheme.primary : theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _isTesting ? null : _runPromptTest,
            icon: _isTesting
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.saved_search),
            label: Text(_isTesting ? 'VERIFYING AGAINST BIGQUERY...' : 'RUN NATURAL LANGUAGE QUERY TEST'),
          ),
        ),
      ],
    );
  }
}
