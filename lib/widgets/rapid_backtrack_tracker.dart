import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RapidBacktrackTracker extends StatefulWidget {
  const RapidBacktrackTracker({super.key});

  @override
  State<RapidBacktrackTracker> createState() => _RapidBacktrackTrackerState();
}

class _RapidBacktrackTrackerState extends State<RapidBacktrackTracker> {
  final TextEditingController _controller = TextEditingController();
  final List<DateTime> _deletionTimestamps = [];
  bool _thresholdBreached = false;

  void _onKeyInput(RawKeyEvent event) {
    if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
      final now = DateTime.now();
      _deletionTimestamps.add(now);

      // Clean up timestamps older than 2 seconds
      _deletionTimestamps.removeWhere((ts) => now.difference(ts).inMilliseconds > 2000);

      if (_deletionTimestamps.length >= 5) {
        setState(() => _thresholdBreached = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: _onKeyInput,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rapid Backtracking Telemetry Input', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12.0),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Type and rapidly backspace to trigger tracking',
                border: const OutlineInputBorder(),
                suffixIcon: _thresholdBreached
                    ? Icon(Icons.warning, color: theme.colorScheme.error)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          if (_thresholdBreached)
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'ALERT: Rapid deletion threshold breached (5+ backspaces in 2s). Telemetry payload logged.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
