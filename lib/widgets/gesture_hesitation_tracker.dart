// lib/widgets/gesture_hesitation_tracker.dart
// Task GEN-00103: Gesture Hesitation Tracking Engine
import 'package:flutter/material.dart';

class GestureHesitationTracker extends StatefulWidget {
  const GestureHesitationTracker({super.key});

  @override
  State<GestureHesitationTracker> createState() =>
      _GestureHesitationTrackerState();
}

class _GestureHesitationTrackerState extends State<GestureHesitationTracker> {
  int _hesitationCount = 0;
  double _lastScrollOffset = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onScaleUpdate: (details) {
        if (details.scale != 1.0) {
          setState(() => _hesitationCount++);
        }
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo is ScrollUpdateNotification) {
            final delta = scrollInfo.metrics.pixels - _lastScrollOffset;
            if (delta.abs() > 30 && delta.sign != _lastScrollOffset.sign) {
              setState(() => _hesitationCount++);
            }
            _lastScrollOffset = scrollInfo.metrics.pixels;
          }
          return false;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gesture Marker Interceptor', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text(
              'Detected Pinch/Reversals: $_hesitationCount',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12.0),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: Text('Pinch or Scroll Up/Down Quickly Inside Box'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
