import 'package:flutter/material.dart';

class ExportConfirmationDialog extends StatelessWidget {
  const ExportConfirmationDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      useSafeArea: false,
      builder: (context) => const ExportConfirmationDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Critical Export'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.warning_amber_rounded, size: 64, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              'Export Enterprise Telemetry Payload?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'This operation packages raw database logs and transmits them to external storage. Please verify authorization before proceeding.',
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Confirm & Export'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
