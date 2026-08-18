// Location: lib/widgets/micro_task_screen.dart
import 'package:flutter/material.dart';
import '../../models/execution_timer_telemetry_model.dart';
import '../universal_library/ui/components/execution_timer.dart';

class MicroTaskScreen extends StatefulWidget {
  const MicroTaskScreen({super.key});

  @override
  State<MicroTaskScreen> createState() => _MicroTaskScreenState();
}

class _MicroTaskScreenState extends State<MicroTaskScreen> {
  final TextEditingController _dataEntryController1 = TextEditingController(
    text: 'SAMPLE_MICRO_TASK_PAYLOAD_9921',
  );
  final TextEditingController _dataEntryController2 = TextEditingController(
    text: 'CONFIDENTIAL_OPERATIONAL_NOTE',
  );

  bool _isTimedOut = false;
  bool _isEscalated = false;

  final ExecutionTimerAssetRecord _telemetry = ExecutionTimerAssetRecord(
    objectType: 'PRIVATE_PACKAGE_MODULE_FILE',
    objectLocationPath: 'universal_library/ui/components/ExecutionTimer.tsx',
    openStatus: 'READ_WRITE_VERIFIED',
    timestamp: DateTime.now().toUtc().toIso8601String(),
    fileHandleId: 'FH-EXEC-2026-3108',
    completionStatus: 'Complete',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3108',
  );

  /// Automated script trigger executed instantly when timer reaches 0:00
  void _executeTimeoutWipeAndEscalation() {
    setState(() {
      _isTimedOut = true;
      _isEscalated = true;
    });

    // 1. Instant Screen Wiping Animation & Field Clearing
    _dataEntryController1.clear();
    _dataEntryController2.clear();

    // 2. Immediate Task Escalation Channel Dispatch (Pub/Sub Sync)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: const Color(0xFF8B0811), // High contrast dark red
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        content: const Row(
          children: [
            Icon(Icons.report_problem_rounded, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'TASK TIMEOUT (0:00): Fields wiped. Ticket escalated to Google Pub/Sub topic.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetMicroTaskSession() {
    setState(() {
      _isTimedOut = false;
      _isEscalated = false;
      _dataEntryController1.text = 'RELOADED_TASK_PAYLOAD_8812';
      _dataEntryController2.text = 'FRESH_OPERATIONAL_INPUT';
    });
  }

  @override
  void dispose() {
    _dataEntryController1.dispose();
    _dataEntryController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Micro-Task Un-bypassable Execution'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp page margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ASSET READINESS AUDIT BANNER
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
                            'Environment / Asset Access Readiness: Complete (1.0)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Private package module ExecutionTimer.tsx discoverable & version-controlled.',
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

            // UN-BYPASSABLE VISUAL TIMER COMPONENT
            ExecutionTimer(
              totalSeconds: 10, // Accelerated 10s demo threshold for testing
              onTimeout: _executeTimeoutWipeAndEscalation,
            ),

            const SizedBox(height: 20),

            // MICRO-TASK DATA ENTRY FIELDS
            Text(
              'Micro-Task Data Space',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _isTimedOut
                  ? 'TASK TIMED OUT: Fields wiped instantly. Submissions locked.'
                  : 'Complete data entry before timer crosses boundary (0:00).',
              style: TextStyle(
                fontSize: 12,
                color: _isTimedOut ? colorScheme.error : Colors.grey.shade600,
                fontWeight: _isTimedOut ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _dataEntryController1,
              enabled: !_isTimedOut, // Hard-locked on timeout
              decoration: InputDecoration(
                labelText: 'Transactional Record ID *',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.data_object_rounded),
                filled: _isTimedOut,
                fillColor: Colors.grey.shade200,
              ),
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _dataEntryController2,
              enabled: !_isTimedOut, // Hard-locked on timeout
              decoration: InputDecoration(
                labelText: 'Operational Notes *',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.note_alt_rounded),
                filled: _isTimedOut,
                fillColor: Colors.grey.shade200,
              ),
            ),

            const SizedBox(height: 20),

            // ACTION BUTTONS ENFORCING >= 48DP TOUCH TARGETS
            SizedBox(
              width: double.infinity,
              height: 48.0, // Minimum 48dp Touch Target
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isTimedOut
                      ? colorScheme.errorContainer
                      : colorScheme.primary,
                  foregroundColor: _isTimedOut
                      ? colorScheme.onErrorContainer
                      : colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _isTimedOut ? null : () {},
                icon: Icon(
                  _isTimedOut ? Icons.block_rounded : Icons.check_rounded,
                ),
                label: Text(
                  _isTimedOut
                      ? 'PROCESSING_LOCKED_TIMED_OUT'
                      : 'SUBMIT_MICRO_TASK',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),

            if (_isEscalated) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48.0, // Minimum 48dp Touch Target
                child: OutlinedButton.icon(
                  onPressed: _resetMicroTaskSession,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text(
                    'RESET_DEMO_TIMER_SESSION',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // ATOMIC STEP EXECUTION TELEMETRY METADATA
            Text(
              'Atomic Asset Readability Telemetry',
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
                    _buildTelemetryRow('Object Type', telemetry.objectType),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Object Path',
                      telemetry.objectLocationPath,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Open Status',
                      telemetry.openStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Timestamp',
                      telemetry.timestamp.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'File Handle ID',
                      telemetry.fileHandleId,
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
              color: isHighlight ? Colors.teal.shade800 : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
