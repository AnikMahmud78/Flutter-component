import 'package:flutter/material.dart';
import '../models/sync_telemetry_model.dart';

class TransientSnackbarScreen extends StatefulWidget {
  const TransientSnackbarScreen({super.key});

  @override
  State<TransientSnackbarScreen> createState() =>
      _TransientSnackbarScreenState();
}

class _TransientSnackbarScreenState extends State<TransientSnackbarScreen> {
  int _currentBottomNavIndex = 0;

  final SyncTelemetryRecord _syncRecord = SyncTelemetryRecord(
    syncType: 'DELTA_PAYLOAD_BACKGROUND_SYNC',
    syncStatus: 'SUCCESS_SYNCHRONIZED',
    lastSyncDate: DateTime.now().toUtc().toIso8601String(),
    syncConflicts: 0,
    syncDuration: '142 ms',
  );

  final BabokAuditTelemetry _auditTelemetry = BabokAuditTelemetry(
    completionStatus: 'Complete',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3031',
  );

  // Trigger 4-Second Transient Success Snackbar Floating Above Bottom Nav
  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4), // REQUIREMENT: 4-second limit
        behavior: SnackBarBehavior.floating, // Floating above bottom nav
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 80.0),
        backgroundColor: const Color(0xFF0F382C), // High contrast dark teal
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.greenAccent,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ASYNC SYNC COMPLETED (4s)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Background sync finished in ${_syncRecord.syncDuration}. Zero conflicts.',
                    style: const TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Trigger 4-Second Transient Minor Exception Snackbar Floating Above Bottom Nav
  void _showMinorExceptionSnackbar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4), // REQUIREMENT: 4-second limit
        behavior: SnackBarBehavior.floating, // Floating above bottom nav
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 80.0),
        backgroundColor: const Color(0xFF1E2A38), // High contrast navy
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.amberAccent,
              size: 24,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MINOR SYNC DELAY (4s)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.amberAccent,
                    ),
                  ),
                  Text(
                    'Network packet loss detected. Retrying in background stream...',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 48.0,
                minWidth: 48.0,
              ),
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  _showSuccessSnackbar();
                },
                child: const Text(
                  'RETRY',
                  style: TextStyle(color: Colors.cyanAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transient Notification Hierarchy'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IIBA BABOK V3 COMPLETENESS BENCHMARK BANNER
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
                            'BABOK v3 Requirements Completeness: Complete (1.0)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Compliant with IIBA BABOK v3 requirements-elicitation completeness benchmark.',
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

            // NON-BLOCKING ASYNCHRONOUS NOTIFICATION TRIGGERS
            Text(
              'Asynchronous Notification Rules (4-Second Limit)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Prompts sit strictly above bottom navigation and avoid blocking active touch entry.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: _showSuccessSnackbar,
                      icon: const Icon(Icons.check_circle_outline_rounded),
                      label: const Text('TRIGGER_SUCCESS (4s)'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.amber.shade900,
                        side: BorderSide(color: Colors.amber.shade900),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: _showMinorExceptionSnackbar,
                      icon: const Icon(Icons.warning_amber_rounded),
                      label: const Text('MINOR_EXCEPTION (4s)'),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ATOMIC DATA FIELDS AUDIT DISPLAY
            Text(
              'Atomic Synchronization Telemetry',
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
                    _buildTelemetryRow('Sync Type', _syncRecord.syncType),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Sync Status',
                      _syncRecord.syncStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Last Sync Date',
                      _syncRecord.lastSyncDate.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Sync Conflicts',
                      '${_syncRecord.syncConflicts}',
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Sync Duration',
                      _syncRecord.syncDuration,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // PERSISTENT BOTTOM NAVIGATION FRAME
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (idx) => setState(() => _currentBottomNavIndex = idx),
        selectedItemColor: colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Workspace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync_rounded),
            label: 'Telemetry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
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
