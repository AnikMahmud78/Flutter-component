import 'package:flutter/material.dart';
import '../models/dispute_ticket_model.dart';

class DisputeValidationCard extends StatelessWidget {
  final DisputeTicketModel model;
  final VoidCallback onValidateSubmission;

  const DisputeValidationCard({
    Key? key,
    required this.model,
    required this.onValidateSubmission,
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
            Text('Dispute Claim: \${model.disputeId}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Ticket Number: \${model.ticketNumber}', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8.0),
            Chip(
              avatar: Icon(
                model.isSlaTimerActive ? Icons.check_circle : Icons.warning,
                color: model.isSlaTimerActive ? Colors.green : Colors.red,
              ),
              label: Text(model.isSlaTimerActive ? 'SLA Timer Active' : 'Timer Inactive'),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onValidateSubmission,
                child: const Text('Run ODR ISO 20488 Validation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
