import 'package:flutter/material.dart';
import '../models/secure_lock_model.dart';

class SecureLockBadgeCard extends StatelessWidget {
  final SecureLockModel model;
  final VoidCallback onFormSubmitted;

  const SecureLockBadgeCard({
    Key? key,
    required this.model,
    required this.onFormSubmitted,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Credit Card Details', style: theme.textTheme.titleMedium),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock, size: 16.0, color: Colors.green),
                      const SizedBox(width: 4.0),
                      Text(
                        '256-Bit SSL Encrypted',
                        style: theme.textTheme.labelMedium?.copyWith(color: Colors.green.shade900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Card Number',
                prefixIcon: Icon(Icons.credit_card),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onFormSubmitted,
                child: const Text('Save Secure Payment Method'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
