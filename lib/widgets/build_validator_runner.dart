// lib/widgets/build_validator_runner.dart
import 'package:flutter/material.dart';

class BuildValidatorRunner extends StatefulWidget {
  const BuildValidatorRunner({super.key});

  @override
  State<BuildValidatorRunner> createState() => _BuildValidatorRunnerState();
}

class _BuildValidatorRunnerState extends State<BuildValidatorRunner> {
  bool _buildPassed = true;
  String _validationLog = 'Build verification active. All source document parameters accounted for.';

  void _simulateMissingParameterError() {
    setState(() {
      _buildPassed = false;
      _validationLog = 'FATAL BUILD ERROR: Missing required source document parameter "schema_id". Compilation blocked.';
    });
  }

  void _resetBuildValidation() {
    setState(() {
      _buildPassed = true;
      _validationLog = 'Build verification active. All source document parameters accounted for.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Source Document Parameter Checker', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: _buildPassed ? theme.colorScheme.surfaceVariant : theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _validationLog,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: _buildPassed ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: OutlinedButton(
                      onPressed: _simulateMissingParameterError,
                      child: const Text('SIMULATE MISSING PARAM'),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: ElevatedButton(
                      onPressed: _resetBuildValidation,
                      child: const Text('RESET BUILD GATE'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
