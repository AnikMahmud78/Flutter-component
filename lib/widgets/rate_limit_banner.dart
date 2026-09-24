import 'package:flutter/material.dart';

class RateLimitBanner extends StatelessWidget {
  final int retryAfterSeconds;
  final VoidCallback? onRetry;

  const RateLimitBanner({
    super.key,
    required this.retryAfterSeconds,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Theme.of(context).colorScheme.onErrorContainer),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'Too Many Requests, please wait $retryAfterSeconds seconds.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              minWidth: 120,
              height: 48,
              child: ElevatedButton(
                onPressed: retryAfterSeconds == 0 ? onRetry : null,
                child: const Text('Retry Now'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
