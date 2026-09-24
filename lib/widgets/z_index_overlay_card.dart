import 'package:flutter/material.dart';
import '../models/z_index_overlay_model.dart';

class ZIndexOverlayCard extends StatelessWidget {
  final ZIndexOverlayModel model;
  final VoidCallback onToggleOverlay;

  const ZIndexOverlayCard({
    Key? key,
    required this.model,
    required this.onToggleOverlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Underlying View Target', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8.0),
                const Text('When overlay is active, these buttons are disabled.'),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: onToggleOverlay,
                    child: Text(model.isOverlayActive ? 'Deactivate Barrier' : 'Activate Touch Barrier'),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (model.isOverlayActive)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                color: Colors.black26,
                child: const Center(
                  child: Chip(
                    label: Text('Z-Index Touch Barrier Active'),
                    backgroundColor: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
