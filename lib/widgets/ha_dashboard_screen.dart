import 'package:flutter/material.dart';
import '../models/ha_policy_model.dart';

class HaDashboardScreen extends StatefulWidget {
  const HaDashboardScreen({super.key});

  @override
  State<HaDashboardScreen> createState() => _HaDashboardScreenState();
}

class _HaDashboardScreenState extends State<HaDashboardScreen> {
  bool _isFailoverInProgress = false;

  final List<DatabaseZoneNode> _zones = [
    DatabaseZoneNode(
      zoneId: 'ZONE-US-EAST-1A',
      zoneRegion: 'us-east1-a (Primary)',
      healthState: ZoneHealthState.activePrimary,
      replicationLagMs: 0,
    ),
    DatabaseZoneNode(
      zoneId: 'ZONE-US-EAST-1B',
      zoneRegion: 'us-east1-b (Sync Standby)',
      healthState: ZoneHealthState.standbySync,
      replicationLagMs: 3,
    ),
    DatabaseZoneNode(
      zoneId: 'ZONE-US-EAST-1C',
      zoneRegion: 'us-east1-c (Quorum Witness)',
      healthState: ZoneHealthState.witnessQuorum,
      replicationLagMs: 1,
    ),
  ];

  HaPolicyExecutionModel get _executionTelemetry => HaPolicyExecutionModel(
    stepExecutionId: 'EXEC-1986HAZFE-2026',
    executionStatus: _isFailoverInProgress ? 'REBALANCING' : 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome:
        'High Availability Multi-Zone Policies Deployed with 48x48dp Touch Targets',
    userId: 'ANIK-HA-CLUSTER-ARCHITECT',
  );

  void _triggerZoneFailoverSimulation() {
    setState(() => _isFailoverInProgress = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isFailoverInProgress = false;

          // Promote Zone B to Primary, demote Zone A to Sync Standby
          _zones[0].healthState = ZoneHealthState.standbySync;
          _zones[0].replicationLagMs = 4;

          _zones[1].healthState = ZoneHealthState.activePrimary;
          _zones[1].replicationLagMs = 0;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'HA Failover Simulation Success: Primary database promoted to us-east1-b with zero frontend downtime.',
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
    final telemetry = _executionTelemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HA Database Cluster Policy'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp Grid Margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WCAG 2.2 COMPLIANCE BANNER
            Card.filled(
              color: Colors.teal.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.teal.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.touch_app_rounded,
                      color: Colors.teal.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mobile Touch Target Compliance: Pass (≥48dp)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.teal.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Compliant with WCAG 2.2 SC 2.5.8 & Material Design 3 Guidelines.',
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
              'Multi-Zone Replication Topology',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Status indicators below call shared design modules with explicit 48dp×48dp tap zones.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            // SHARED STATUS INDICATOR TILES WITH EXPLICIT 48X48 DP TOUCH TARGETS
            ..._zones.map((zone) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SharedStatusIndicatorTile(
                  zoneNode: zone,
                  onStatusTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Inspecting ${zone.zoneId}: Status=${zone.healthState.name}, Lag=${zone.replicationLagMs}ms',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              );
            }),

            const SizedBox(height: 16),

            // FAILOVER ACTION BUTTON (48DP MINIMUM TAP AREA)
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 48.0,
                minHeight: 48.0, // Minimum 48dp Touch Target Height
              ),
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
                  onPressed: _isFailoverInProgress
                      ? null
                      : _triggerZoneFailoverSimulation,
                  icon: _isFailoverInProgress
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.published_with_changes_rounded),
                  label: Text(
                    _isFailoverInProgress
                        ? 'Executing Zero-Downtime Failover...'
                        : 'Trigger Multi-Zone Failover Test',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC EXECUTION TELEMETRY LOGS
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
                      'Step Execution ID',
                      telemetry.stepExecutionId,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Execution Status',
                      telemetry.executionStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Execution Timestamp',
                      telemetry.executionTimestamp.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('Step Outcome', telemetry.stepOutcome),
                    const Divider(height: 12),
                    _buildTelemetryRow('User ID', telemetry.userId),
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

/// Shared Status Indicator Module with explicit 48dp x 48dp minimum touch target
class SharedStatusIndicatorTile extends StatelessWidget {
  final DatabaseZoneNode zoneNode;
  final VoidCallback onStatusTap;

  const SharedStatusIndicatorTile({
    super.key,
    required this.zoneNode,
    required this.onStatusTap,
  });

  Color _getStatusColor(ZoneHealthState state) {
    switch (state) {
      case ZoneHealthState.activePrimary:
        return Colors.green.shade700;
      case ZoneHealthState.standbySync:
        return Colors.indigo.shade700;
      case ZoneHealthState.witnessQuorum:
        return Colors.amber.shade900;
      case ZoneHealthState.failoverDegraded:
        return Colors.red.shade800;
    }
  }

  String _getStatusLabel(ZoneHealthState state) {
    switch (state) {
      case ZoneHealthState.activePrimary:
        return 'ACTIVE PRIMARY';
      case ZoneHealthState.standbySync:
        return 'SYNC STANDBY';
      case ZoneHealthState.witnessQuorum:
        return 'QUORUM WITNESS';
      case ZoneHealthState.failoverDegraded:
        return 'DEGRADED';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(zoneNode.healthState);

    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        child: Row(
          children: [
            // Shared Status Indicator Avatar
            CircleAvatar(
              radius: 18,
              backgroundColor: statusColor.withAlpha(25),
              child: Icon(
                zoneNode.isPrimary ? Icons.dns : Icons.cloud_sync_rounded,
                color: statusColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

            // Zone Name & Region Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    zoneNode.zoneRegion,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Replication Lag: ${zoneNode.replicationLagMs}ms • ${zoneNode.dbEngineVersion}',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // REQUIREMENT: Interactive Status Component with strict 48dp x 48dp minimum touch target
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 48.0, // Minimum 48dp Width Spec
                minHeight: 48.0, // Minimum 48dp Height Spec
              ),
              child: InkWell(
                onTap: onStatusTap,
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: statusColor, width: 1.0),
                  ),
                  child: Text(
                    _getStatusLabel(zoneNode.healthState),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
