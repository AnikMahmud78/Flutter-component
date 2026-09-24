import 'package:flutter/material.dart';
import 'models/ui_acknowledgement_model.dart';
import 'services/ack_verification_service.dart';
import 'widgets/confirmation_dialog_widget.dart';
import 'widgets/audit_completion_banner.dart';

void main() {
  runApp(const HABOTAckApp());
}

class HABOTAckApp extends StatelessWidget {
  const HABOTAckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10357GEN-02129 MD3 Confirmation',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0061A4)),
      ),
      home: const AckScreen(),
    );
  }
}

class AckScreen extends StatefulWidget {
  const AckScreen({super.key});

  @override
  State<AckScreen> createState() => _AckScreenState();
}

class _AckScreenState extends State<AckScreen> {
  late UiAcknowledgementModel _model;

  @override
  void initState() {
    super.initState();
    _model = AckVerificationService.generateAckRecord(
      taskId: '10357GEN-02129',
      confirmed: true,
      userId: 'USER-ANIK-8821',
    );
  }

  void _showConfirmModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Critical Action'),
        content: const Text('Are you sure you want to finalize and commit the audit record to the runbook?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _model = AckVerificationService.generateAckRecord(
                  taskId: '10357GEN-02129',
                  confirmed: true,
                  userId: 'USER-ANIK-8821',
                );
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Action confirmed and logged to BigQuery audit stream.')),
              );
            },
            child: const Text('Confirm & Execute'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MD3 Confirmation & Acknowledgement')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AuditCompletionBanner(rate: _model.auditVerificationRate),
            const SizedBox(height: 16.0),
            ConfirmationDialogWidget(
              model: _model,
              onTriggerConfirm: _showConfirmModal,
            ),
          ],
        ),
      ),
    );
  }
}
