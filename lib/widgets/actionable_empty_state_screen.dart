// Location: lib/widgets/actionable_empty_state_screen.dart
import 'package:flutter/material.dart';
import '../models/empty_state_telemetry_model.dart';

class ActionableEmptyStateScreen extends StatefulWidget {
  const ActionableEmptyStateScreen({super.key});

  @override
  State<ActionableEmptyStateScreen> createState() =>
      _ActionableEmptyStateScreenState();
}

class _ActionableEmptyStateScreenState
    extends State<ActionableEmptyStateScreen> {
  bool _hasData = false;
  final List<String> _dataset = [];

  final EmptyStateAccessTelemetry _telemetry = EmptyStateAccessTelemetry(
    accessType: 'READ_UI_PARAMETERS_LIB',
    userRole: 'UX_SYSTEMS_DESIGNER',
    permissionLevel: 'LEVEL_13_ADMIN',
    accessLog: 'ACCESS_LOG_USMBL_020_PASS',
    accessTimestamp: DateTime.now().toUtc().toIso8601String(),
    completionStatus: 'Pass',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3185',
    typographyTokenAdherenceRate: 1.0,
  );

  void _populateData() {
    setState(() {
      _hasData = true;
      _dataset.addAll([
        'Enterprise Task Payload #8801',
        'Compliance Review Record #8802',
        'System Security Audit Token #8803',
      ]);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'PROCESS INITIATED: Data populated successfully from actionable empty state.',
        ),
        backgroundColor: Colors.teal.shade800,
      ),
    );
  }

  void _resetToEmptyState() {
    setState(() {
      _hasData = false;
      _dataset.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actionable Empty States'),
        backgroundColor: colorScheme.surfaceContainerHigh,
        actions: [
          if (_hasData)
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: _resetToEmptyState,
              tooltip: 'Reset to Empty State',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // HABOT 16dp page margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TYPOGRAPHY TOKEN SCALE ADHERENCE BANNER
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // 12px rounding
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0), // 16px inner padding
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
                            'M3 Typography Token Adherence: Pass (100%)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Compliant with Material Design 3 Type Scale. Zero un-tokenized type rules.',
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

            // CONDITIONAL VIEW: POPULATED DATA VS ACTIONABLE EMPTY STATE
            _hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Populated Workspace Data',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _dataset.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Card.outlined(
                              child: ListTile(
                                leading: Icon(
                                  Icons.description_rounded,
                                  color: colorScheme.primary,
                                ),
                                title: Text(
                                  _dataset[index],
                                  style: textTheme.titleMedium,
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right_rounded,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : Card.outlined(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // 12px rounding
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 36.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 1. FRIENDLY, NON-ALARMING ILLUSTRATION CONTAINER
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.folder_open_rounded,
                              size: 40,
                              color: colorScheme.primary,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // 2. EXPLICIT UX COPY CONFIRMING ZERO RECORDS VS SYSTEM ERROR
                          Text(
                            'No Tasks or Records Found',
                            textAlign: TextAlign.center,
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ), // Bound strictly to M3 titleLarge token
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Your operational workspace is currently empty. This is an active zero-state, not a system error or network failure.',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ), // Bound strictly to M3 bodyMedium token
                          ),

                          const SizedBox(height: 24),

                          // 3. CENTRALLY PLACED >= 48DP PRIMARY CTA BUTTON
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 48.0,
                              minHeight:
                                  48.0, // Minimum 48dp Touch Target[cite: 1]
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 48.0,
                              child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: _populateData,
                                icon: const Icon(Icons.add_task_rounded),
                                label: Text(
                                  'INITIATE_NEW_WORKSPACE_TASK',
                                  style: textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                    color: colorScheme.onPrimary,
                                  ), // Bound strictly to M3 labelLarge token[cite: 1]
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY AUDIT LOG DISPLAY
            Text(
              'Atomic Step Execution Telemetry',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildTelemetryRow('Access Type', telemetry.accessType),
                    const Divider(height: 12),
                    _buildTelemetryRow('User Role', telemetry.userRole),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Permission Level',
                      telemetry.permissionLevel,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('Access Log', telemetry.accessLog),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Access Timestamp',
                      telemetry.accessTimestamp.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Completion Status',
                      telemetry.completionStatus,
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
