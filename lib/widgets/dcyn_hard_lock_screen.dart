import 'package:flutter/material.dart';
import '../models/dcyn_lock_model.dart';

class DcynHardLockScreen extends StatefulWidget {
  const DcynHardLockScreen({super.key});

  @override
  State<DcynHardLockScreen> createState() => _DcynHardLockScreenState();
}

class _DcynHardLockScreenState extends State<DcynHardLockScreen> {
  // Simulated DCYN Failure State (Hard-locked record)
  final DcynLockState _dcynRecord = DcynLockState(
    recordId: 'REC-DCYN-2026-8841',
    hasDcynFailure: true,
    failureReason:
        'DCYN_HASH_MISMATCH: Ingestion value checksum failed consistency check.',
    payloadData: 'PAYLOAD_TRANSACTION_VALUE_USD = 84,200.00 [LOCKED]',
  );

  bool _isReRunningDiagnostics = false;

  DcynAuditTelemetry get _telemetry => DcynAuditTelemetry(
    stepExecutionId: 'EXEC-2745IRBCA-2026',
    executionStatus: 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome:
        'DCYN Hard-Lock Policy Enforced. Administrative Bypass FABs and Overrides Stripped.',
    userId: 'ANIK-QUALITY-AUDITOR',
  );

  void _reRunDiagnostics() {
    setState(() => _isReRunningDiagnostics = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isReRunningDiagnostics = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'DIAGNOSTICS EXECUTED: DCYN hard-lock remains active until upstream data source re-synchronizes.',
            ),
            backgroundColor: Colors.indigo.shade800,
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('DCYN Data Integrity Lock'),
        backgroundColor: colorScheme.surfaceContainerHigh,
        // REQUIREMENT: IconButton components tied to override functions are completely removed
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Chip(
              avatar: Icon(Icons.lock_rounded, size: 16, color: Colors.red),
              label: Text(
                'BYPASS_DISABLED',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              backgroundColor: Color(0xFFFFEBEE),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ],
      ),
      // REQUIREMENT: Remove any extraneous Floating Action Buttons (FABs) suggesting administrative bypass
      floatingActionButton:
          null, // Hardlocked: No FAB rendered on DCYN failure screens
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ISO 9001:2015 PROCESS QUALITY SCORE BANNER
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
                      Icons.verified_rounded,
                      color: Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Process Execution Quality Score: 100% (Good)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Compliant with ISO 9001:2015 Quality Management Standard.',
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

            // DCYN FAILURE LOCK NOTICE
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: colorScheme.error, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.gpp_bad_rounded,
                    color: colorScheme.onErrorContainer,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HARD-LOCK ACTIVE: DCYN VERIFICATION FAILURE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: colorScheme.onErrorContainer,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _dcynRecord.failureReason,
                          style: TextStyle(
                            fontSize: 11,
                            color: colorScheme.onErrorContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Locked Data Record Fields',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Fields are hard-locked. Manual administrative overrides are permanently disabled.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            // REQUIREMENT: Render non-editable fields using OutlinedTextField with enabled = false and lowered opacity
            Opacity(
              opacity: 0.38, // MD3 Disabled Opacity Token
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: _dcynRecord.recordId),
                decoration: const InputDecoration(
                  labelText: 'Record Identification Code',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Opacity(
              opacity: 0.38, // MD3 Disabled Opacity Token
              child: TextField(
                enabled: false,
                controller: TextEditingController(
                  text: _dcynRecord.payloadData,
                ),
                decoration: const InputDecoration(
                  labelText: 'Payload Data Stream',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.data_object_rounded),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // REQUIREMENT: Simplify the interface to present only the compliant path forward
            Text(
              'Compliant Action Path',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _isReRunningDiagnostics ? null : _reRunDiagnostics,
                  icon: _isReRunningDiagnostics
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.sync_problem_rounded),
                  label: const Text(
                    'RE_RUN_DCYN_DIAGNOSTICS',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC AUDIT EXECUTION TELEMETRY
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
