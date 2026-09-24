import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/countdown_model.dart';

class CountdownClockWidget extends StatelessWidget {
  final CountdownModel model;

  const CountdownClockWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUrgent = model.remainingSeconds < 60;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isUrgent ? theme.colorScheme.errorContainer : theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer,
            color: isUrgent ? theme.colorScheme.onErrorContainer : theme.colorScheme.onPrimaryContainer,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            model.formattedTime,
            style: theme.textTheme.titleMedium?.copyWith(
              color: isUrgent ? theme.colorScheme.onErrorContainer : theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
