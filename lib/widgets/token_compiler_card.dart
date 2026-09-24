import 'package:flutter/material.dart';
import '../models/token_compiler_model.dart';

class TokenCompilerCard extends StatelessWidget {
  final TokenCompilerModel model;
  final VoidCallback onCompile;

  const TokenCompilerCard({
    Key? key,
    required this.model,
    required this.onCompile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Design Token Pipeline: \${model.compilationJobId}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Success Rate: \${(model.successRate * 100).toStringAsFixed(1)}%', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onCompile,
                icon: const Icon(Icons.transform),
                label: const Text('Compile CSS Modules (W3C Spec)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
