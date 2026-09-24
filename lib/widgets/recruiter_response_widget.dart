import 'package:flutter/material.dart';
import '../models/recruiter_response.dart';

class RecruiterResponseWidget extends StatefulWidget {
  final Function(RecruiterResponse) onCaptured;

  const RecruiterResponseWidget({super.key, required this.onCaptured});

  @override
  State<RecruiterResponseWidget> createState() => _RecruiterResponseWidgetState();
}

class _RecruiterResponseWidgetState extends State<RecruiterResponseWidget> {
  String _selectedDecision = 'Approved';
  final _notesController = TextEditingController();

  void _submitResponse() {
    final response = RecruiterResponse(
      candidateId: 'CAN-88392',
      recruiterId: 'REC-0012',
      decision: _selectedDecision,
      notes: _notesController.text,
      timestamp: DateTime.now(),
    );
    widget.onCaptured(response);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recruiter response captured successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Capture Recruiter Evaluation', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedDecision,
              decoration: const InputDecoration(labelText: 'Evaluation Decision', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'Approved', child: Text('Approved')),
                DropdownMenuItem(value: 'Rejected', child: Text('Rejected')),
                DropdownMenuItem(value: 'OnHold', child: Text('On Hold')),
              ],
              onChanged: (val) => setState(() => _selectedDecision = val!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Recruiter Feedback / Notes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _submitResponse,
                icon: const Icon(Icons.send),
                label: const Text('Save & Transmit Response'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
