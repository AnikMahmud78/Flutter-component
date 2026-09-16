import 'package:flutter/material.dart';

class SilentHesitationTracker extends StatefulWidget {
  const SilentHesitationTracker({super.key});

  @override
  State<SilentHesitationTracker> createState() => _SilentHesitationTrackerState();
}

class _SilentHesitationTrackerState extends State<SilentHesitationTracker> {
  final FocusNode _fieldFocusNode = FocusNode();
  DateTime? _focusStartTime;
  int _lastHesitationDurationMs = 0;

  @override
  void initState() {
    super.initState();
    _fieldFocusNode.addListener(() {
      if (_fieldFocusNode.hasFocus) {
        _focusStartTime = DateTime.now();
      } else {
        if (_focusStartTime != null) {
          final duration = DateTime.now().difference(_focusStartTime!).inMilliseconds;
          setState(() {
            _lastHesitationDurationMs = duration;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hesitation Telemetry Input Node', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: TextField(
            focusNode: _fieldFocusNode,
            decoration: const InputDecoration(
              labelText: 'Focus Field (Silent Hesitation Monitoring)',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Silent Background Tracked Duration: ${_lastHesitationDurationMs}ms',
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
        ),
      ],
    );
  }
}
