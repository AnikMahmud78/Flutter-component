// lib/widgets/scaffold_header_timer.dart
import 'dart:async';
import 'package:flutter/material.dart';

class ScaffoldHeaderTimer extends StatefulWidget {
  const ScaffoldHeaderTimer({super.key});

  @override
  State<ScaffoldHeaderTimer> createState() => _ScaffoldHeaderTimerState();
}

class _ScaffoldHeaderTimerState extends State<ScaffoldHeaderTimer> {
  int _remainingSeconds = 300;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final minutes = (_remainingSeconds / 60).floor().toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.alarm, size: 18, color: theme.colorScheme.onErrorContainer),
          const SizedBox(width: 6.0),
          Text(
            '$minutes:$seconds',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: theme.colorScheme.onErrorContainer,
            ),
          ),
        ],
      ),
    );
  }
}
