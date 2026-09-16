// lib/widgets/privacy_sandbox_gate.dart
import 'package:flutter/material.dart';

class PrivacySandboxGate extends StatefulWidget {
  const PrivacySandboxGate({super.key});

  @override
  State<PrivacySandboxGate> createState() => _PrivacySandboxGateState();
}

class _PrivacySandboxGateState extends State<PrivacySandboxGate> {
  bool _topicsConsent = true;
  bool _protectedAudienceConsent = true;

  bool checkCompliance() {
    return _topicsConsent && _protectedAudienceConsent;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompliant = checkCompliance();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('check_compliance() Privacy Gate Node', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Android Topics API Consent'),
          value: _topicsConsent,
          onChanged: (val) => setState(() => _topicsConsent = val),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Protected Audience API Consent'),
          value: _protectedAudienceConsent,
          onChanged: (val) => setState(() => _protectedAudienceConsent = val),
        ),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isCompliant ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            isCompliant ? 'PRIVACY GATE PASSED: Ingress Allowed' : 'PRIVACY GATE BLOCKED: Ad Signals Stripped',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isCompliant ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            ),
          ),
        ),
      ],
    );
  }
}
