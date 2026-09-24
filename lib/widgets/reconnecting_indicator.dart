import 'package:flutter/material.dart';

class ReconnectingIndicator extends StatefulWidget {
  final bool isReconnecting;

  const ReconnectingIndicator({Key? key, required this.isReconnecting}) : super(key: key);

  @override
  State<ReconnectingIndicator> createState() => _ReconnectingIndicatorState();
}

class _ReconnectingIndicatorState extends State<ReconnectingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // English Code (EC): Render-Reconnecting-Status-Banner
  @override
  Widget build(BuildContext context) {
    if (!widget.isReconnecting) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.amber.shade800,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: _controller,
            child: const Icon(Icons.sync, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 8.0),
          const Text(
            'Reconnecting to Telemetry Stream...',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
