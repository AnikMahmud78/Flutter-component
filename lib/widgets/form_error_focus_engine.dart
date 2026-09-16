import 'package:flutter/material.dart';

class FormErrorFocusEngine extends StatefulWidget {
  const FormErrorFocusEngine({super.key});

  @override
  State<FormErrorFocusEngine> createState() => _FormErrorFocusEngineState();
}

class _FormErrorFocusEngineState extends State<FormErrorFocusEngine> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _fieldKeys = List.generate(10, (_) => GlobalKey()).asMap();
  final Map<int, TextEditingController> _controllers = List.generate(10, (_) => TextEditingController()).asMap();
  final Set<int> _invalidIndices = {};

  void _validateAndScrollToFirstError() {
    _invalidIndices.clear();
    for (int i = 0; i < 10; i++) {
      if (_controllers[i]!.text.trim().isEmpty) {
        _invalidIndices.add(i);
      }
    }

    setState(() {});

    if (_invalidIndices.isNotEmpty) {
      final firstErrorIdx = _invalidIndices.first;
      final targetContext = _fieldKeys[firstErrorIdx]!.currentContext;
      if (targetContext != null) {
        Scrollable.ensureVisible(
          targetContext,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          alignment: 0.1, // Clear header row
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 400,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: 10,
            itemBuilder: (context, index) {
              final isInvalid = _invalidIndices.contains(index);
              return Padding(
                key: _fieldKeys[index],
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isInvalid ? theme.colorScheme.errorContainer.withOpacity(0.3) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 48.0),
                        child: TextField(
                          controller: _controllers[index],
                          decoration: InputDecoration(
                            labelText: 'Form Field Input Entry #${index + 1}',
                            border: const OutlineInputBorder(),
                            suffixIcon: isInvalid ? Icon(Icons.error, color: theme.colorScheme.error) : null,
                          ),
                        ),
                      ),
                      if (isInvalid)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                          child: Text(
                            'Validation failure: Target field cannot be empty.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 48.0,
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48.0),
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
            ),
            onPressed: _validateAndScrollToFirstError,
            icon: const Icon(Icons.center_focus_strong),
            label: const Text('TRIGGER ERROR POSITIONING SCROLL'),
          ),
        ),
      ],
    );
  }
}
