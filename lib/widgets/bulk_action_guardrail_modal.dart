// Location: lib/widgets/bulk_action_guardrail_modal.dart
import 'package:flutter/material.dart';
import '../models/bulk_action_guardrail_model.dart';

class BulkActionGuardrailScreen extends StatefulWidget {
  const BulkActionGuardrailScreen({super.key});

  @override
  State<BulkActionGuardrailScreen> createState() =>
      _BulkActionGuardrailScreenState();
}

class _BulkActionGuardrailScreenState extends State<BulkActionGuardrailScreen> {
  final List<ProjectSpecificationRow> _tableRows = [
    ProjectSpecificationRow(
      id: 'SPEC-9001',
      title: 'Enterprise Authentication & OAuth2 Gateway Spec',
      category: 'Security Architecture',
      lastModified: '2026-08-18',
      isSelected: true,
    ),
    ProjectSpecificationRow(
      id: 'SPEC-9002',
      title: 'Cloud Pub/Sub High-Throughput Ingestion Schema',
      category: 'Data Pipeline',
      lastModified: '2026-08-18',
      isSelected: true,
    ),
    ProjectSpecificationRow(
      id: 'SPEC-9003',
      title: 'Biometric Gateway Hardware Interface Specs',
      category: 'Edge Infrastructure',
      lastModified: '2026-08-17',
      isSelected: true,
    ),
    ProjectSpecificationRow(
      id: 'SPEC-9004',
      title: 'Universal UI Design System Primitive Tokens',
      category: 'Frontend Framework',
      lastModified: '2026-08-16',
      isSelected: false,
    ),
  ];

  bool _isProcessingBatch = false;
  double _batchProgress = 0.0;

  final BulkActionGuardrailTelemetry _telemetry = BulkActionGuardrailTelemetry(
    workspaceName: 'MERP_PRODUCTION_CORE_WORKSPACE',
    workspaceId: 'WS-CSIVW-2026-9921',
    workspaceConfiguration: 'HIGH_RISK_GUARDRAIL_MODAL_ACTIVE',
    memberList: 'ANIK_LEAD, SECURITY_OPS_DEV, UI_COMPONENT_SPECIALIST',
    workspaceStatus: 'READ_ONLY_FREEZE_READY',
    completionStatus: 'Pass',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3196',
  );

  List<ProjectSpecificationRow> get _selectedRows =>
      _tableRows.where((r) => r.isSelected).toList();

  void _triggerGuardrailModal() {
    final selected = _selectedRows;
    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'SELECTION REQUIRED: Select at least one row for bulk action.',
          ),
          backgroundColor: Colors.amber,
        ),
      );
      return;
    }

    // Launch Responsive Confirmation Overlay (<BulkActionGuardrailModal>)
    showDialog(
      context: context,
      barrierDismissible: !_isProcessingBatch,
      builder: (context) {
        return _BulkActionGuardrailModal(
          selectedRows: selected,
          onConfirm: _executeBatchProcessing,
        );
      },
    );
  }

  void _executeBatchProcessing() {
    Navigator.of(context).pop(); // Close Guardrail Modal

    setState(() {
      _isProcessingBatch = true;
      _batchProgress = 0.0;
    });

    // Simulate Background Cloud Lane Batch Processing
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return false;
      setState(() {
        _batchProgress += 0.25;
      });
      return _batchProgress < 1.0;
    }).then((_) {
      if (mounted) {
        setState(() {
          // Remove deleted rows and auto-clear selections
          _tableRows.removeWhere((r) => r.isSelected);
          _isProcessingBatch = false;
          _batchProgress = 0.0;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'BULK ACTION COMPLETE: Selected rows deleted. Selections automatically reset.',
            ),
            backgroundColor: Colors.teal.shade800,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;
    final selectedCount = _selectedRows.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulk Action Guardrail (CSIVW-012)'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SETUP READINESS AUDIT BANNER
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
                            'Environment & Config Setup Readiness: Pass',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Source-of-truth schema validated pre-edit to prevent configuration drift.',
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

            const SizedBox(height: 16),

            // BACKGROUND BATCH PROCESSING PROGRESS LINE
            if (_isProcessingBatch) ...[
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.shade400),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'BACKGROUND CLOUD BATCH JOB RUNNING...',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        Text(
                          '${(_batchProgress * 100).toInt()}%',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _batchProgress,
                      backgroundColor: Colors.amber.shade100,
                      color: Colors.amber.shade900,
                      minHeight: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // TABLE SELECTION TOOLBAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Project Specification Table ($selectedCount Selected)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedCount > 0
                          ? colorScheme.error
                          : Colors.grey.shade400,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: (_isProcessingBatch || selectedCount == 0)
                        ? null
                        : _triggerGuardrailModal,
                    icon: const Icon(Icons.delete_sweep_rounded),
                    label: const Text('MASS_DELETE_TRIGGER'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // INTERACTIVE TABLE WITH READ-ONLY FREEZE ON BATCH EXECUTION
            Opacity(
              opacity: _isProcessingBatch ? 0.5 : 1.0,
              child: IgnorePointer(
                ignoring: _isProcessingBatch, // Table frozen during processing
                child: Card.outlined(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _tableRows.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final row = _tableRows[index];
                      return CheckboxListTile(
                        value: row.isSelected,
                        onChanged: (val) {
                          setState(() => row.isSelected = val ?? false);
                        },
                        title: Text(
                          row.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        subtitle: Text(
                          'ID: ${row.id} • Category: ${row.category} • Modified: ${row.lastModified}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                        activeColor: colorScheme.primary,
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY LOG DISPLAY
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
                    _buildTelemetryRow(
                      'Workspace Name',
                      telemetry.workspaceName,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('Workspace ID', telemetry.workspaceId),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Workspace Config',
                      telemetry.workspaceConfiguration,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('Member List', telemetry.memberList),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Workspace Status',
                      telemetry.workspaceStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Completion Status',
                      telemetry.completionStatus,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
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
              color: isHighlight ? Colors.green.shade800 : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// RESPONSIVE CONFIRMATION MODAL COMPONENT (<BulkActionGuardrailModal>)
// =============================================================================

class _BulkActionGuardrailModal extends StatefulWidget {
  final List<ProjectSpecificationRow> selectedRows;
  final VoidCallback onConfirm;

  const _BulkActionGuardrailModal({
    required this.selectedRows,
    required this.onConfirm,
  });

  @override
  State<_BulkActionGuardrailModal> createState() =>
      __BulkActionGuardrailModalState();
}

class __BulkActionGuardrailModalState extends State<_BulkActionGuardrailModal> {
  final TextEditingController _verificationController = TextEditingController();
  bool _isValidated = false;

  @override
  void dispose() {
    _verificationController.dispose();
    super.dispose();
  }

  void _onInputChanged(String text) {
    setState(() {
      _isValidated = text.trim() == 'CONFIRM';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 600.0;

    final Widget modalContent = Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: isMobile ? double.infinity : 520.0,
          margin: isMobile ? EdgeInsets.zero : const EdgeInsets.all(24.0),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(isMobile ? 0.0 : 16.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AMBER WARNING HEADER BANNER
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.amber.shade700,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.amber.shade900,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HIGH-RISK BULK ACTION WARNING',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.amber.shade900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'You are about to permanently modify/delete ${widget.selectedRows.length} item(s).',
                              style: const TextStyle(
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

                const SizedBox(height: 16),

                // BOLD CALLOUT SUMMARY OF HIGH-PRIORITY TARGET ROWS
                Text(
                  'Target Specification Rows (${widget.selectedRows.length}):',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.selectedRows.length,
                    itemBuilder: (context, idx) {
                      final item = widget.selectedRows[idx];
                      return Text(
                        '• ${item.id}: ${item.title}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // TEXT VERIFICATION INPUT CELL (TYPE "CONFIRM")
                Text(
                  'Verification Required:',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Type "CONFIRM" in the box below to unlock action.',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 8),

                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48.0),
                  child: TextFormField(
                    controller: _verificationController,
                    autofocus: true, // Auto-launches mobile keyboard setup
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    onChanged: _onInputChanged,
                    decoration: InputDecoration(
                      hintText: 'Type CONFIRM here',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(
                        _isValidated
                            ? Icons.lock_open_rounded
                            : Icons.lock_rounded,
                        color: _isValidated ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ACTION CONTROL BUTTONS (STRICT >= 48DP TOUCH TARGET)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 48.0,
                        minWidth: 48.0,
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('CANCEL'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 48.0,
                        minWidth: 48.0,
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isValidated
                              ? colorScheme.error
                              : Colors.grey.shade400,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _isValidated ? widget.onConfirm : null,
                        icon: const Icon(Icons.check_circle_rounded),
                        label: const Text('CONFIRM_MASS_DELETE'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (isMobile) {
      return Dialog.fullscreen(child: modalContent);
    } else {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: modalContent,
      );
    }
  }
}
