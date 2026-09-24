import 'package:flutter/material.dart';
import '../models/alert_payload.dart';

class AlertMicroAnimator extends StatefulWidget {
  final AlertPayload alert;

  const AlertMicroAnimator({Key? key, required this.alert}) : super(key: key);

  @override
  State<AlertMicroAnimator> createState() => _AlertMicroAnimatorState();
}

class _AlertMicroAnimatorState extends State<AlertMicroAnimator> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );
    _triggerMicroAnimation();
  }

  // English Code (EC): Trigger-Micro-Animation
  void _triggerMicroAnimation() {
    _animController.forward().then((_) => _animController.reverse());
  }

  @override
  void didUpdateWidget(covariant AlertMicroAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.alert.alertId != widget.alert.alertId) {
      _triggerMicroAnimation();
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: Card(
        color: Theme.of(context).colorScheme.errorContainer,
        child: ListTile(
          leading: const Icon(Icons.error, color: Colors.red),
          title: Text(widget.alert.message, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Severity: ${widget.alert.severity}'),
        ),
      ),
    );
  }
}
