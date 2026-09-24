import 'package:flutter/material.dart';
import '../models/qr_pass_model.dart';

class QRPassCard extends StatelessWidget {
  final QRPassModel model;
  final VoidCallback onRefreshScan;

  const QRPassCard({
    Key? key,
    required this.model,
    required this.onRefreshScan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Digital Pass Container',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: 180.0,
              height: 180.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade300, width: 2.0),
              ),
              child: Center(
                child: Icon(
                  Icons.qr_code_2,
                  size: 140.0,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              model.holderName,
              style: theme.textTheme.titleLarge,
            ),
            Text(
              'Pass ID: \${model.passId}',
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: OutlinedButton.icon(
                onPressed: onRefreshScan,
                icon: const Icon(Icons.sync),
                label: const Text('Verify QR Code Integrity'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
