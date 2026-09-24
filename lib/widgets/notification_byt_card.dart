import 'package:flutter/material.dart';
import '../models/notification_byt_model.dart';

class NotificationBytWidget extends StatelessWidget {
  final NotificationBytModel model;
  const NotificationBytWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final bool isPassing = model.deliveryRate >= 0.98;
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(model.title, style: Theme.of(context).textTheme.titleMedium),
                Chip(
                  label: Text(isPassing ? 'PASS' : 'FAIL'),
                  backgroundColor: isPassing ? Colors.green.shade100 : Colors.red.shade100,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text('Delivery Rate: ${(model.deliveryRate * 100).toStringAsFixed(1)}%'),
          ],
        ),
      ),
    );
  }
}
