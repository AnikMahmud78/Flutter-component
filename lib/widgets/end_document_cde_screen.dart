import 'package:flutter/material.dart';
import '../models/end_document_cde_model.dart';

class EndDocumentCdeScreen extends StatefulWidget {
  const EndDocumentCdeScreen({super.key});

  @override
  State<EndDocumentCdeScreen> createState() => _EndDocumentCdeScreenState();
}

class _EndDocumentCdeScreenState extends State<EndDocumentCdeScreen> {
  final List<EndDocumentCde> _cdeCatalog = [
    EndDocumentCde(
      cdeId: 'CDE-ED-001',
      uiFieldId: 'input_doc_title',
      dbTableName: 'tbl_ed_end_document_master',
      dbColumnName: 'document_title',
      dataType: 'VARCHAR(255)',
      isMandatory: true,
      isSchemaLocked: true,
      currentInputValue: 'Final Ingestion Structural Baseline ED-2026',
    ),
    EndDocumentCde(
      cdeId: 'CDE-ED-002',
      uiFieldId: 'input_doc_reference_id',
      dbTableName: 'tbl_ed_end_document_master',
      dbColumnName: 'document_ref_code',
      dataType: 'VARCHAR(64)',
      isMandatory: true,
      isSchemaLocked: true,
      currentInputValue: 'ED-REF-99821-X',
    ),
    EndDocumentCde(
      cdeId: 'CDE-ED-003',
      uiFieldId: 'input_signoff_author',
      dbTableName: 'tbl_ed_end_document_master',
      dbColumnName: 'signoff_author_id',
      dataType: 'VARCHAR(128)',
      isMandatory: true,
      isSchemaLocked: true,
      currentInputValue: 'USER-ANIK-LEAD',
    ),
    EndDocumentCde(
      cdeId: 'CDE-ED-004',
      uiFieldId: 'input_approval_date',
      dbTableName: 'tbl_ed_end_document_master',
      dbColumnName: 'approval_timestamp',
      dataType: 'TIMESTAMP',
      isMandatory: true,
      isSchemaLocked: true,
      currentInputValue: '', // Left blank to demonstrate Self-Chasing lock
    ),
  ];

  // Compute percentage of UI fields mapped to locked End Document CDEs
  double get _cdeMappingCoverage {
    if (_cdeCatalog.isEmpty) return 0.0;
    final lockedCount = _cdeCatalog.where((c) => c.isSchemaLocked).length;
    return lockedCount / _cdeCatalog.length;
  }

  // SELF-CHASING CONDITION: All mandatory CDEs must be populated
  bool get _isSelfChasingValid =>
      _cdeCatalog.every((c) => !c.isMandatory || c.isFieldPopulated);

  // POKA-YOKE CONDITION: 100% CDE mapping required to enable Track Release
  bool get _canReleaseTrack =>
      _cdeMappingCoverage == 1.0 && _isSelfChasingValid;

  EndDocumentValidationTelemetry get _telemetryLog {
    final bool isPass = _canReleaseTrack;
    final String timeNow = DateTime.now().toUtc().toIso8601String();

    return EndDocumentValidationTelemetry(
      validationType: '100% End Document (ED) CDE Direct Field Lock Audit',
      validationResult: isPass ? 'PASS' : 'FAIL',
      errorMessages: isPass
          ? 'None. All UI fields map 100% to locked End Document Cloud SQL CDEs.'
          : 'Self-Chasing Alert: Required ED input field "input_approval_date" is blank.',
      validationTimestamp: timeNow,
      validationLog:
          'Audit Log [TASK-1843]: CDE Coverage=${(_cdeMappingCoverage * 100).toInt()}%, PopulatedState=$_isSelfChasingValid, PokaYokeLock=${!isPass}',
    );
  }

  void _triggerMobilePushNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.add_alert_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Mobile Push Notification Pushed: Complete missing End Document CDE inputs to unlock Release.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade900,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetryLog;

    return Scaffold(
      appBar: AppBar(
        title: const Text('End Document (ED) CDE Mapper'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        // Mobile-First Fluid Layout (16dp outer margin)
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. POKA-YOKE & SELF-CHASING STATUS BANNER
            // =========================================================
            Card.filled(
              color: _canReleaseTrack
                  ? Colors.green.shade50
                  : colorScheme.errorContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: _canReleaseTrack
                      ? Colors.green.shade400
                      : colorScheme.error,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _canReleaseTrack
                              ? Icons.verified_user_rounded
                              : Icons.gpp_maybe_rounded,
                          color: _canReleaseTrack
                              ? Colors.green.shade800
                              : colorScheme.onErrorContainer,
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _canReleaseTrack
                                ? '100% ED CDE MAPPED & VALIDATED'
                                : 'SELF-CHASING LOCK ACTIVE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: _canReleaseTrack
                                  ? Colors.green.shade900
                                  : colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      telemetry.errorMessages,
                      style: TextStyle(
                        fontSize: 12,
                        color: _canReleaseTrack
                            ? Colors.green.shade800
                            : colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 2. END DOCUMENT CRITICAL DATA ELEMENTS (CDE) INPUT FORM
            // =========================================================
            Text(
              'End Document (ED) Inputs',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '100% of UI controls below are strictly locked to Cloud SQL End Document CDE columns.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            ..._cdeCatalog.map((cde) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${cde.uiFieldId} *',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${cde.dbTableName}.${cde.dbColumnName}',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // THUMB-FRIENDLY TOUCH TARGETS (48dp height minimum)
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 48.0,
                        minWidth: 48.0,
                      ),
                      child: TextFormField(
                        initialValue: cde.currentInputValue,
                        onChanged: (val) {
                          setState(() {
                            cde.currentInputValue = val;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter ${cde.dbColumnName}',
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 14.0,
                          ),
                          suffixIcon: Icon(
                            cde.isFieldPopulated
                                ? Icons.lock
                                : Icons.warning_amber_rounded,
                            color: cde.isFieldPopulated
                                ? Colors.green
                                : colorScheme.error,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),

            // =========================================================
            // 3. THUMB-FRIENDLY ACTION BUTTONS (48X48 DP TAP TARGETS)
            // =========================================================
            // ACTION 1: Release Button (Disabled when Self-Chasing Lock Active)
            SizedBox(
              width: double.infinity,
              height: 48.0, // Minimum 48dp Touch Target
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _canReleaseTrack
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'End Document (ED) Schema & Track Released Successfully!',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    : null, // Disabled per Self-Chasing logic
                icon: const Icon(Icons.rocket_launch_rounded),
                label: Text(
                  _canReleaseTrack
                      ? 'Release ED Schema & Track'
                      : 'Release Locked (Populate All ED CDEs)',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ACTION 2: Simulate Push Notification Alert
            if (!_canReleaseTrack)
              SizedBox(
                width: double.infinity,
                height: 48.0, // Minimum 48dp Touch Target
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    side: BorderSide(color: colorScheme.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _triggerMobilePushNotification,
                  icon: const Icon(Icons.notifications_active_rounded),
                  label: const Text(
                    'Push Mobile Notification Alert',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // =========================================================
            // 4. ATOMIC TELEMETRY LOG DISPLAY
            // =========================================================
            Text(
              'Atomic Validation Telemetry Logs',
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
                      'Validation Type',
                      telemetry.validationType,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Validation Result',
                      telemetry.validationResult,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Error Messages',
                      telemetry.errorMessages,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Validation Timestamp',
                      telemetry.validationTimestamp.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Validation Log',
                      telemetry.validationLog,
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
              color: isHighlight
                  ? (_canReleaseTrack
                        ? Colors.green.shade800
                        : Colors.red.shade800)
                  : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
