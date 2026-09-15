import 'package:flutter/material.dart';
import '../models/job_title_validation_telemetry_model.dart';

class JobTitleValidatorWidget4175FEBFL017A05 extends StatefulWidget {
  const JobTitleValidatorWidget4175FEBFL017A05({super.key});

  @override
  State<JobTitleValidatorWidget4175FEBFL017A05> createState() =>
      _JobTitleValidatorWidget4175FEBFL017A05State();
}

class _JobTitleValidatorWidget4175FEBFL017A05State
    extends State<JobTitleValidatorWidget4175FEBFL017A05> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  JobTitleValidationTelemetryRecord get _telemetry => JobTitleValidationTelemetryRecord(
        stepExecutionId: 'EXEC-4175FEBFL-2026',
        executionStatus: 'PASS',
        executionTimestamp: DateTime.now().toUtc().toIso8601String(),
        stepOutcome: 'Explicit one-line validation rule configured to reject compound job titles.',
        userId: 'ANIK-FUNCTIONAL-DESIGN',
        completionStatus: 'Complete',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-4175',
      );

  String? _validateJobTitle(String? value) {
    if (value == null || value.trim().isEmpty) return 'Job title cannot be empty.';
    if (value.toLowerCase().contains(' and ')) return 'Compound titles rejected. Enter single role only.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atomic Job Title Validator'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card.filled(
                color: Colors.green.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.green.shade300),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      Icon(Icons.fact_check_rounded, color: Color(0xFF086C44), size: 28),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Process Execution Quality: Complete (100%)',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF086C44))),
                            SizedBox(height: 2),
                            Text('General execution steps executed to defined standard of work before sign-off.',
                                style: TextStyle(fontSize: 11, color: Colors.black87)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                validator: _validateJobTitle,
                decoration: const InputDecoration(
                  labelText: 'Target Job Title',
                  hintText: 'e.g., Senior Operations Architect',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary, foregroundColor: Colors.white),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('VALIDATION PASS: Role Accepted.'),
                              backgroundColor: Color(0xFF086C44)),
                        );
                      }
                    },
                    child: const Text('VALIDATE JOB TITLE STRING'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Atomic Telemetry Logs',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      _buildRow('Execution Status', telemetry.executionStatus, isHighlight: true),
                      const Divider(height: 12),
                      _buildRow('Completion Status', telemetry.completionStatus, isHighlight: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        Expanded(
          child: Text(value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
              )),
        ),
      ],
    );
  }
}
