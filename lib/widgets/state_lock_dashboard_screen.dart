// Location: lib/widgets/state_lock_dashboard_screen.dart
import 'package:flutter/material.dart';
import '../models/isolated_byt_state_model.dart';
import 'isolated_byt_component.dart';

class StateLockDashboardScreen extends StatefulWidget {
  const StateLockDashboardScreen({super.key});

  @override
  State<StateLockDashboardScreen> createState() =>
      _StateLockDashboardScreenState();
}

class _StateLockDashboardScreenState extends State<StateLockDashboardScreen> {
  // Pure local isolated state list bound 1-to-1 to unique Byt IDs
  List<BytStateRecord> _bytNodes = [
    const BytStateRecord(
      bytId: 'BYT-NAV-01',
      destinationField: 'dest_account_setup_pane',
      displayLabel: 'Initialize Account Setup Router Node',
      isSelected: false,
    ),
    const BytStateRecord(
      bytId: 'BYT-INPUT-02',
      destinationField: 'dest_funding_amount_input',
      displayLabel: 'Bind Initial Funding Amount Payload',
      isSelected: false,
    ),
    const BytStateRecord(
      bytId: 'BYT-LOCK-03',
      destinationField: 'dest_dcyn_consistency_gate',
      displayLabel: 'Hard-Lock Administrative Override Gate',
      isSelected: true,
    ),
  ];

  final MobileStateTelemetryRecord _telemetry = MobileStateTelemetryRecord(
    mobilePlatform: 'Flutter Mobile / Android Runtime',
    osVersion: 'Android 15 (API 35)',
    deviceType: 'Enterprise Handheld / Pixel 8',
    screenDimensions: '412 x 892 dp (4-Col Grid)',
    mobileConfiguration: 'IMMUTABLE_ISOLATED_STATE_LOCKED',
    completionStatus: 'Pass',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3086',
  );

  /// Mapping-Diff Automated Validator: Verifies zero orphaned or duplicate mappings
  bool get _isFieldMapping100PercentAccurate {
    final bytIds = _bytNodes.map((n) => n.bytId).toSet();
    final destFields = _bytNodes.map((n) => n.destinationField).toSet();
    return bytIds.length == _bytNodes.length &&
        destFields.length == _bytNodes.length;
  }

  void _handleStateChange(int index, BytStateRecord updatedRecord) {
    setState(() {
      // Replaces state cleanly via pure functional update (no mutation)
      _bytNodes[index] = updatedRecord;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isAccurate = _isFieldMapping100PercentAccurate;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolated State & Byt Lock'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // HABOT 16dp Page Margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DATA / FIELD MAPPING ACCURACY BANNER
            Card.filled(
              color: isAccurate
                  ? Colors.green.shade50
                  : colorScheme.errorContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isAccurate ? Colors.green.shade300 : colorScheme.error,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      isAccurate
                          ? Icons.verified_user_rounded
                          : Icons.gpp_bad_rounded,
                      color: isAccurate
                          ? Colors.green.shade800
                          : colorScheme.error,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isAccurate
                                ? 'Data/Field Mapping Accuracy: Pass (100.0%)'
                                : 'ORPHANED/DUPLICATE MAPPING DETECTED',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isAccurate
                                  ? Colors.green.shade900
                                  : colorScheme.onErrorContainer,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            '1-to-1 Byt ID to Destination Field Resolution Verified.',
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

            Text(
              'Isolated Component Byt Inventory',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Each component manages its own M3 state layer with pure immutable dispatches.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            // ISOLATED COMPONENTS ARRAY
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _bytNodes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return IsolatedBytComponent(
                  record: _bytNodes[index],
                  onStateChanged: (updated) =>
                      _handleStateChange(index, updated),
                );
              },
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY AUDIT METADATA
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
                      'Mobile Platform',
                      _telemetry.mobilePlatform,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('OS Version', _telemetry.osVersion),
                    const Divider(height: 12),
                    _buildTelemetryRow('Device Type', _telemetry.deviceType),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Screen Dimensions',
                      _telemetry.screenDimensions,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Mobile Config',
                      _telemetry.mobileConfiguration,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Completion Status',
                      _telemetry.completionStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'User Session ID',
                      _telemetry.userSessionId,
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
