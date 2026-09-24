import 'package:flutter/material.dart';
import '../models/scroll_fps_model.dart';

class ScrollFpsCard extends StatelessWidget {
  final ScrollFpsModel model;
  final VoidCallback onTestScroll;

  const ScrollFpsCard({
    Key? key,
    required this.model,
    required this.onTestScroll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scroll Performance Profiler', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Render Speed: ${model.currentFps.toStringAsFixed(1)} FPS'),
                Chip(
                  label: Text('${model.droppedFrames} Dropped'),
                  backgroundColor: model.droppedFrames == 0 ? Colors.green.shade50 : Colors.red.shade50,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onTestScroll,
                icon: const Icon(Icons.speed),
                label: const Text('Run 60fps Scroll Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
