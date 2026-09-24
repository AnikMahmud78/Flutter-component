import 'package:flutter/material.dart';
import '../models/zero_zoom_model.dart';

class ZeroZoomCard extends StatelessWidget {
  final ZeroZoomModel model;
  final VoidCallback onVerifyLayout;

  const ZeroZoomCard({
    Key? key,
    required this.model,
    required this.onVerifyLayout,
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
            Text('Zero-Zoom Mobile Viewport', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Optimal Information Architecture (No Scroll/Zoom Required)',
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onVerifyLayout,
                child: const Text('Verify Viewport Data Fitting'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
