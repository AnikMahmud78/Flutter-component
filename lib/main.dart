import 'package:flutter/material.dart';
import 'models/dispute_ticket_model.dart';
import 'widgets/dispute_validation_card.dart';

void main() {
  runApp(const DisputeApp());
}

class DisputeApp extends StatelessWidget {
  const DisputeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dispute Ticket SLA App',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      home: const DisputeScreen(),
    );
  }
}

class DisputeScreen extends StatelessWidget {
  const DisputeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const ticket = DisputeTicketModel(
      disputeId: 'DISP-9543-12',
      ticketNumber: 'TK-2026-9543',
      isSlaTimerActive: true,
      cycleTimeHours: 36,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('ODR Dispute Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DisputeValidationCard(
              model: ticket,
              onValidateSubmission: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('100% Ticket & Active Timer Validation Passed')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
