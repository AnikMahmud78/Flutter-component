import 'package:flutter/material.dart';
import 'models/prompt_style_model.dart';
import 'widgets/monospace_prompt_block.dart';

void main() {
  runApp(const PromptStyleApp());
}

class PromptStyleApp extends StatelessWidget {
  const PromptStyleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monospace Text Component',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const PromptStyleScreen(),
    );
  }
}

class PromptStyleScreen extends StatefulWidget {
  const PromptStyleScreen({Key? key}) : super(key: key);

  @override
  State<PromptStyleScreen> createState() => _PromptStyleScreenState();
}

class _PromptStyleScreenState extends State<PromptStyleScreen> {
  late PromptStyleModel _model;

  @override
  void initState() {
    super.initState();
    _model = PromptStyleModel(
      rawPromptText: 'SYSTEM PROMPT: Enforce corporate mobile egress IP security tokens on all API requests.',
      fontFamily: 'monospace',
      consistencyScore: 100.0,
      qualityRating: 'Good',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Design System Monospace Audit')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Prompt Block Preview', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                MonospacePromptBlock(promptText: _model.rawPromptText),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Font Family: ${_model.fontFamily}'),
                        Text('Consistency Score: ${_model.consistencyScore}%'),
                        Text('Quality Rating: ${_model.qualityRating}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
