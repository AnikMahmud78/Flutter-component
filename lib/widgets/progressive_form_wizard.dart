import 'package:flutter/material.dart';

class ProgressiveFormWizard extends StatefulWidget {
  const ProgressiveFormWizard({super.key});

  @override
  State<ProgressiveFormWizard> createState() => _ProgressiveFormWizardState();
}

class _ProgressiveFormWizardState extends State<ProgressiveFormWizard> {
  bool _showAdvancedParameters = false;
  final TextEditingController _primaryController = TextEditingController();
  final TextEditingController _advancedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Primary Action Field', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: TextField(
            controller: _primaryController,
            decoration: const InputDecoration(
              labelText: 'Core Metric Parameter',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 48.0,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48.0),
            ),
            onPressed: () {
              setState(() {
                _showAdvancedParameters = !_showAdvancedParameters;
              });
            },
            icon: Icon(_showAdvancedParameters ? Icons.expand_less : Icons.expand_more),
            label: Text(_showAdvancedParameters ? 'HIDE ADVANCED SETTINGS' : 'SHOW ADVANCED SETTINGS'),
          ),
        ),
        if (_showAdvancedParameters) ...[
          const SizedBox(height: 16.0),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Advanced Parameters (Progressive Reveal)', style: theme.textTheme.labelLarge),
                const SizedBox(height: 12.0),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48.0),
                  child: TextField(
                    controller: _advancedController,
                    decoration: const InputDecoration(
                      labelText: 'Secondary Calibration Key',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
