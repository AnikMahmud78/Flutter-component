import 'package:flutter/material.dart';
import '../models/review_exception_model.dart';

class ReviewExceptionCard extends StatelessWidget {
  final ReviewExceptionModel model;
  final VoidCallback onResolveException;

  const ReviewExceptionCard({
    Key? key,
    required this.model,
    required this.onResolveException,
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
            Text('Package: @habot/ops/exception-view', style: theme.textTheme.labelSmall),
            const SizedBox(height: 8.0),
            Text('Exception ID: \${model.exceptionId}', style: theme.textTheme.titleMedium),
            Text('Reason: \${model.flaggedReason}', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onResolveException,
                child: const Text('Resolve Review Exception'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
