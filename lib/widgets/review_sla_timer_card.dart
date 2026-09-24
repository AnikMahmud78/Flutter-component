import 'dart:async';
import 'package:flutter/material.dart';
import '../models/review_sla_model.dart';

class ReviewSLATimerCard extends StatefulWidget {
  final ReviewSLAModel model;
  final VoidCallback onResolve;

  const ReviewSLATimerCard({
    Key? key,
    required this.model,
    required this.onResolve,
  }) : super(key: key);

  @override
  State<ReviewSLATimerCard> createState() => _ReviewSLATimerCardState();
}

class _ReviewSLATimerCardState extends State<ReviewSLATimerCard> {
  late Timer _timer;
  late int _currentSeconds;

  @override
  void initState() {
    super.initState();
    _currentSeconds = widget.model.remainingSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_currentSeconds > 0) {
        setState(() {
          _currentSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_currentSeconds / 60).floor().toString().padLeft(2, '0');
    final seconds = (_currentSeconds % 60).toString().padLeft(2, '0');
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Review SLA ID: \${widget.model.reviewId}',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Chip(
                  avatar: Icon(
                    _currentSeconds > 0 ? Icons.timer : Icons.error_outline,
                    color: _currentSeconds > 0 ? Colors.green : Colors.red,
                  ),
                  label: Text(_currentSeconds > 0 ? '\$minutes:\$seconds' : 'BREACHED'),
                  backgroundColor: _currentSeconds > 0 ? Colors.green.shade50 : Colors.red.shade50,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'Verification Score: \${(widget.model.verificationScore * 100).toStringAsFixed(1)}%',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: _currentSeconds > 0 ? widget.onResolve : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                child: const Text('Resolve Risk Item'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
