import 'package:flutter/material.dart';
import '../models/document_seal_model.dart';

class MasterDocumentStepperWidget extends StatefulWidget {
  const MasterDocumentStepperWidget({super.key});

  @override
  State<MasterDocumentStepperWidget> createState() =>
      _MasterDocumentStepperWidgetState();
}

class _MasterDocumentStepperWidgetState
    extends State<MasterDocumentStepperWidget> {
  int _activeStepIndex = 0;

  final MasterDocumentRecord _documentRecord = MasterDocumentRecord(
    documentId: 'DOC-EC-2026-8891',
    title: 'Enterprise Technical Architecture Master Specification',
    versionTag: 'ED 4.0 (Final Sealed State)',
  );

  DocumentSealTelemetry get _telemetry => DocumentSealTelemetry(
    stepExecutionId: 'EXEC-2866ETMDI-2026',
    executionStatus: _documentRecord.isSealed
        ? 'SEALED_COMPLETE'
        : 'IN_PROGRESS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome: _documentRecord.isSealed
        ? 'Master EC Document Sealed (ED 4). Edit FABs permanently removed from viewport.'
        : 'Document progressing through workflow stepper. Edit capabilities enabled.',
    userId: 'ANIK-OPS-ARCHITECT',
  );

  void _advanceStep() {
    if (_activeStepIndex < 3) {
      setState(() {
        _activeStepIndex++;
        _documentRecord.currentStep =
            DocumentLifecycleStep.values[_activeStepIndex];
      });

      if (_documentRecord.isSealed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'DOCUMENT SEALED (ED 4): Edit FABs stripped per DAMA-DMBOK2 Standard.',
            ),
            backgroundColor: Colors.indigo.shade900,
          ),
        );
      }
    }
  }

  void _previousStep() {
    if (_activeStepIndex > 0 && !_documentRecord.isSealed) {
      setState(() {
        _activeStepIndex--;
        _documentRecord.currentStep =
            DocumentLifecycleStep.values[_activeStepIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSealed = _documentRecord.isSealed;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seal Master EC Document (ED 4)'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),

      // DYNAMIC FAB REMOVAL: FAB renders only when document is UNSEALED
      floatingActionButton: isSealed
          ? null // Edit FAB completely removed from viewport when sealed
          : ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 48.0,
                minHeight: 48.0,
              ),
              child: FloatingActionButton.extended(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('EDIT MODE ACTIVE: Document is unsealed.'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_note_rounded),
                label: const Text(
                  'EDIT_DOCUMENT_DRAFT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DAMA-DMBOK2 COMPLETENESS BANNER
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user_rounded,
                      color: Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Metadata Completeness Rate: 100% (Complete)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Compliant with DAMA-DMBOK2 Metadata Management Standard.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DOCUMENT METADATA SUMMARY CARD
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _documentRecord.documentId,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Chip(
                          avatar: Icon(
                            isSealed
                                ? Icons.lock_rounded
                                : Icons.lock_open_rounded,
                            size: 14,
                            color: isSealed
                                ? Colors.white
                                : Colors.indigo.shade900,
                          ),
                          label: Text(
                            isSealed ? 'SEALED (ED 4)' : 'EDITABLE DRAFT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: isSealed
                                  ? Colors.white
                                  : Colors.indigo.shade900,
                            ),
                          ),
                          backgroundColor: isSealed
                              ? Colors.indigo.shade900
                              : Colors.indigo.shade50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _documentRecord.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Version Tag: ${_documentRecord.versionTag}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // MATERIAL STEPPER WORKFLOW PROGRESSION
            Text(
              'Document Sealing Progression Path',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Stepper(
              physics: const NeverScrollableScrollPhysics(),
              currentStep: _activeStepIndex,
              onStepContinue: _advanceStep,
              onStepCancel: _previousStep,
              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      if (_activeStepIndex < 3)
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 48.0),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                            ),
                            onPressed: details.onStepContinue,
                            icon: const Icon(Icons.arrow_forward_rounded),
                            label: Text(
                              _activeStepIndex == 2
                                  ? 'SEAL_DOCUMENT_ED4'
                                  : 'ADVANCE_STEP',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (_activeStepIndex > 0 && !isSealed) ...[
                        const SizedBox(width: 8),
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 48.0),
                          child: OutlinedButton(
                            onPressed: details.onStepCancel,
                            child: const Text('PREVIOUS'),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: const Text('1. Document Creation & Draft'),
                  subtitle: const Text('Initial EC spec drafting phase'),
                  content: const Text(
                    'Drafting parameters active. Edit Floating Action Button is enabled.',
                    style: TextStyle(fontSize: 12),
                  ),
                  isActive: _activeStepIndex >= 0,
                  state: _activeStepIndex > 0
                      ? StepState.complete
                      : StepState.indexed,
                ),
                Step(
                  title: const Text('2. Internal Review Phase'),
                  subtitle: const Text('Peer review and metadata validation'),
                  content: const Text(
                    'Document under review by TC Implementers and OPS Architects.',
                    style: TextStyle(fontSize: 12),
                  ),
                  isActive: _activeStepIndex >= 1,
                  state: _activeStepIndex > 1
                      ? StepState.complete
                      : StepState.indexed,
                ),
                Step(
                  title: const Text('3. Executive Sign-Off'),
                  subtitle: const Text(
                    'Final verification before ED 4 sealing',
                  ),
                  content: const Text(
                    'Ready for permanent seal. Tap SEAL_DOCUMENT_ED4 to lock.',
                    style: TextStyle(fontSize: 12),
                  ),
                  isActive: _activeStepIndex >= 2,
                  state: _activeStepIndex > 2
                      ? StepState.complete
                      : StepState.indexed,
                ),
                Step(
                  title: const Text('4. Master EC Sealed State (ED 4)'),
                  subtitle: const Text('Permanent lock — FABs removed'),
                  content: const Text(
                    'DOCUMENT PERMANENTLY SEALED. All edit Floating Action Buttons have been removed.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  isActive: _activeStepIndex >= 3,
                  state: StepState.complete,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ATOMIC STEP EXECUTION TELEMETRY
            Text(
              'Atomic Step Execution Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Step Execution ID', telemetry.stepExecutionId),
                    const Divider(height: 12),
                    _buildRow(
                      'Execution Status',
                      telemetry.executionStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildRow(
                      'Execution Timestamp',
                      telemetry.executionTimestamp.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildRow('Step Outcome', telemetry.stepOutcome),
                    const Divider(height: 12),
                    _buildRow('User ID', telemetry.userId),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? Colors.teal.shade800 : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
