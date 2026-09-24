import 'package:flutter/material.dart';

class LatencyMetricBanner extends StatelessWidget {
  final double successRate;

  const LatencyMetricBanner({super.key, required this.successRate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isSuccess = successRate >= 98.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isSuccess ? theme.colorScheme.tertiaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        '3G Video Playback Success Rate: \$successRate% (Target: ≥98.0%)',
        style: theme.textTheme.titleSmall?.copyWith(
          color: isSuccess ? theme.colorScheme.onTertiaryContainer : theme.colorScheme.onErrorContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
