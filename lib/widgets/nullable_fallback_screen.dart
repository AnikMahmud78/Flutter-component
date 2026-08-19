// Location: lib/widgets/nullable_fallback_screen.dart
import 'package:flutter/material.dart';
import '../models/nullable_audit_telemetry_model.dart';
import '../utils/null_handler_util.dart';

class NullableFallbackScreen extends StatefulWidget {
  const NullableFallbackScreen({super.key});

  @override
  State<NullableFallbackScreen> createState() => _NullableFallbackScreenState();
}

class _NullableFallbackScreenState extends State<NullableFallbackScreen> {
  // Toggle between populated data and a partial/null data payload
  bool _simulateIncompleteDatabaseState = true;

  NullableRecordModel get _activeRecord => _simulateIncompleteDatabaseState
      ? NullableRecordModel(
          recordId: 'REC-NULL-8812',
          entityName: null, // Nullable Field 1
          categoryTag: null, // Nullable Field 2
          fundingAmountUsd: null, // Nullable Field 3
          targetGoalUsd: 50000.00,
          createdAt: null, // Nullable Field 4
        )
      : NullableRecordModel(
          recordId: 'REC-FULL-1092',
          entityName: 'Enterprise Logistics Expansion',
          categoryTag: 'CAPEX_EQUIPMENT',
          fundingAmountUsd: 24500.00,
          targetGoalUsd: 50000.00,
          createdAt: DateTime.now(),
        );

  final NullableAuditTelemetryRecord _telemetry = NullableAuditTelemetryRecord(
    mobilePlatform: 'Flutter Mobile / Android Runtime',
    osVersion: 'Android 15 (API 35)',
    deviceType: 'Enterprise Handheld / Pixel 8',
    screenDimensions: '412 x 892 dp (4-Col Grid)',
    mobileConfiguration: 'NULL_FALLBACK_PROTECTION_ENABLED',
    completionStatus: 'Complete',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3152',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final record = _activeRecord;

    // Safe string extractions via unified NullHandlerUtil asset
    final safeEntityName = NullHandlerUtil.safeString(
      record.entityName,
      fallback: 'UNNAMED_ENTERPRISE_ENTITY',
      fieldKey: 'entityName',
    );

    final safeCategoryTag = NullHandlerUtil.safeString(
      record.categoryTag,
      fallback: 'GENERAL_UNASSIGNED',
      fieldKey: 'categoryTag',
    );

    final safeFundingDisplay = NullHandlerUtil.safeCurrency(
      record.fundingAmountUsd,
      fieldKey: 'fundingAmountUsd',
    );

    // Arithmetic exception handling: division by target goal
    final completionRatio = NullHandlerUtil.safeDivide(
      record.fundingAmountUsd,
      record.targetGoalUsd,
      fallback: 0.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nullable Field Rendering Fallbacks'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp page margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // REQUIREMENTS / DISCOVERY COVERAGE BANNER
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
                            'Discovery Coverage: 100% (Complete)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Audit completed. Nullable rendering fallbacks active across all models.',
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

            // SIMULATION TOGGLE CONTROL (MINIMUM 48DP TOUCH TARGET)
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _simulateIncompleteDatabaseState =
                          !_simulateIncompleteDatabaseState;
                    });
                  },
                  icon: Icon(
                    _simulateIncompleteDatabaseState
                        ? Icons.data_object_rounded
                        : Icons.cleaning_services_rounded,
                  ),
                  label: Text(
                    _simulateIncompleteDatabaseState
                        ? 'SIMULATING: INCOMPLETE DATABASE STATE (NULLS)'
                        : 'SIMULATING: FULLY POPULATED DATA PAYLOAD',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Active Entity Card Component',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Renders safe fallbacks without throwing client-side JavaScript or null exceptions.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            // MATERIAL CARD WITH CONDITIONAL DISPLAY & FALLBACK DEFAULTS
            Card.outlined(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          record.recordId ?? 'REC-UNKNOWN',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        // CONDITIONAL CHIP DISPLAY TEMPLATE
                        Chip(
                          avatar: Icon(
                            record.categoryTag == null
                                ? Icons.help_outline_rounded
                                : Icons.label_rounded,
                            size: 14,
                            color: record.categoryTag == null
                                ? Colors.amber.shade900
                                : colorScheme.primary,
                          ),
                          label: Text(
                            safeCategoryTag,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: record.categoryTag == null
                                  ? Colors.amber.shade900
                                  : colorScheme.primary,
                            ),
                          ),
                          backgroundColor: record.categoryTag == null
                              ? Colors.amber.shade50
                              : colorScheme.primaryContainer,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // SAFE STRING DISPLAY
                    Text(
                      safeEntityName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: record.entityName == null
                            ? Colors.grey.shade700
                            : colorScheme.onSurface,
                        fontStyle: record.entityName == null
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Funding Amount:',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          safeFundingDisplay,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: record.fundingAmountUsd == null
                                ? Colors.amber.shade900
                                : Colors.teal.shade800,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // ARITHMETIC PROGRESS INDICATOR
                    LinearProgressIndicator(
                      value: completionRatio,
                      backgroundColor: Colors.grey.shade200,
                      color: Colors.teal,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // LIVE TEXT FALLBACK TRACKING ARRAY
            Text(
              'Text Fallback Tracking Array (Telemetry Stream)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Container(
                height: 120,
                padding: const EdgeInsets.all(12.0),
                child: NullHandlerUtil.fallbackTrackingLog.isEmpty
                    ? const Center(
                        child: Text(
                          'No fallbacks triggered yet.',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: NullHandlerUtil.fallbackTrackingLog.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              NullHandlerUtil.fallbackTrackingLog[index],
                              style: const TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: Colors.blueGrey,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY METADATA
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
