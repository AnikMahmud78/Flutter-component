import 'package:flutter/material.dart';
import '../models/precommit_linter_telemetry_model.dart';

class PrecommitLinterWidget2074FEBFL005A15 extends StatefulWidget {
  const PrecommitLinterWidget2074FEBFL005A15({super.key});

  @override
  State<PrecommitLinterWidget2074FEBFL005A15> createState() =>
      _PrecommitLinterWidget2074FEBFL005A15State();
}

class _PrecommitLinterWidget2074FEBFL005A15State
    extends State<PrecommitLinterWidget2074FEBFL005A15> {
  PrecommitLinterTelemetryRecord get _telemetry => PrecommitLinterTelemetryRecord(
        repositoryUrl: 'git@github.com:enterprise/ui-components.git',
        repositoryBranch: 'feature/m3-precommit-linter',
        accessRights: 'HOOK_EXECUTE_PERMISSIONS_GRANTED',
        commitHistory: 'PRE_COMMIT_HOOK_ACTIVE',
        repositoryVersion: 'v3.4.0',
        cloneStatus: 'LINTER_HOOK_BOUND_SUCCESS',
        completionStatus: 'Complete',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-2074',
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pre-Commit Linter Hook'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
                    Icon(Icons.terminal_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Typography Token Adherence: Complete (100%)',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF086C44)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Automated pre-commit hook script gates style regressions prior to commit steps.',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card.outlined(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hook Status: ${telemetry.cloneStatus}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('Target Branch: ${telemetry.repositoryBranch}',
                        style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                  ],
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
                    _buildRow('Hook Status', telemetry.cloneStatus),
                    const Divider(height: 12),
                    _buildRow('Completion Status', telemetry.completionStatus, isHighlight: true),
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
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
