import 'package:flutter/material.dart';
import '../models/fat_finger_padding_model.dart';

class FatFingerPaddingCard extends StatelessWidget {
  final FatFingerPaddingModel model;
  final VoidCallback onValidatePadding;

  const FatFingerPaddingCard({
    Key? key,
    required this.model,
    required this.onValidatePadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Touch Padding Protection', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Minimum Bounding Box: \${model.minTouchTargetDp.toInt()} x \${model.minTouchTargetDp.toInt()} dp'),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onValidatePadding,
                icon: const Icon(Icons.touch_app),
                label: const Text('Verify 48x48dp Touch Targets'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
