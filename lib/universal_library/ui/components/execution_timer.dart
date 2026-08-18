// Location: lib/universal_library/ui/components/execution_timer.dart
import 'dart:async';
import 'package:flutter/material.dart';

/// Un-bypassable Visual Execution Timer Widget
/// Private Package Component: universal_library/ui/components/execution_timer.dart
class ExecutionTimer extends StatefulWidget {
  final int totalSeconds;
  final VoidCallback onTimeout;
  final ValueChanged<int>? onTick;

  const ExecutionTimer({
    super.key,
    this.totalSeconds = 300, // Default 5-minute (300s) threshold
    required this.onTimeout,
    this.onTick,
  });

  @override
  State<ExecutionTimer> createState() => _ExecutionTimerState();
}

class _ExecutionTimerState extends State<ExecutionTimer> {
  late int _secondsRemaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.totalSeconds;
    _startUnbypassableTimer();
  }

  void _startUnbypassableTimer() {
    // Non-pausable main-thread ticker
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
        widget.onTick?.call(_secondsRemaining);
      } else {
        _timer?.cancel();
        widget.onTimeout(); // AUTOMATED SCRIPT TRIGGER AT 0:00
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelled strictly on widget unmount
    super.dispose();
  }

  String get _formattedTime {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final bool isCritical = _secondsRemaining <= 60;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isCritical ? const Color(0xFFE31B23) : const Color(0xFF1E2A38),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isCritical ? Colors.red.shade900 : Colors.indigo.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isCritical ? Icons.timer_off_rounded : Icons.timer_rounded,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'EXECUTION TIMEOUT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          // High-contrast, bold, un-pausable countdown display
          Text(
            _formattedTime,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
