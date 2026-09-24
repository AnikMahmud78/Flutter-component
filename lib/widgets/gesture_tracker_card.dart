import 'package:flutter/material.dart';
import '../models/gesture_event_model.dart';

class GestureTrackerCard extends StatelessWidget {
  final GestureEventModel model;
  final ValueChanged<String> onGestureCaptured;

  const GestureTrackerCard({
    Key? key,
    required this.model,
    required this.onGestureCaptured,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: (_) => onGestureCaptured('Touch Down'),
      onLongPress: () => onGestureCaptured('Long Press'),
      onHorizontalDragEnd: (_) => onGestureCaptured('Swipe Drag'),
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text('Interactive Gesture Target', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12.0),
              Text('Detected: \${model.lastGesture}', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8.0),
              Text('Accuracy: \${(model.detectionAccuracy * 100).toStringAsFixed(1)}%', style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
