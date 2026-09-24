import 'package:flutter/material.dart';
import '../models/fluid_scaling_model.dart';

class FluidTextCard extends StatelessWidget {
  final FluidScalingModel model;

  const FluidTextCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Viewport Width: ${model.viewportWidth} dp',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Dynamically Scaled Text Preview',
              style: TextStyle(
                fontSize: model.computedFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4.0),
            Text('Calculated Size: ${model.computedFontSize.toStringAsFixed(1)} px'),
          ],
        ),
      ),
    );
  }
}
