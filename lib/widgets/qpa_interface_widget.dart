import 'package:flutter/material.dart';

class QpaInterfaceWidget extends StatelessWidget {
  final double qualityScore;
  const QpaInterfaceWidget({super.key, this.qualityScore = 0.98});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('QPA Engine Status', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Product Quality Index:'),
                Text('${(qualityScore * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.analytics),
                label: const Text('View Detailed Telemetry'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
