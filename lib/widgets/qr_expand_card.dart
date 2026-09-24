import 'package:flutter/material.dart';
import '../models/qr_expand_model.dart';

class QRExpandCard extends StatelessWidget {
  final QRExpandModel model;
  final VoidCallback onTapExpand;

  const QRExpandCard({
    Key? key,
    required this.model,
    required this.onTapExpand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTapExpand,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('Digital Pass (Tap to Expand)', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12.0),
              Icon(Icons.qr_code_2, size: 100.0, color: theme.colorScheme.primary),
              const SizedBox(height: 8.0),
              Text('Pass ID: \${model.passId}', style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
