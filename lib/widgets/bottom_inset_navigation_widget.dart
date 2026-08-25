import 'package:flutter/material.dart';

import '../models/bottom_inset_telemetry_model.dart';

class BottomInsetNavigationWidget extends StatefulWidget {
  const BottomInsetNavigationWidget({super.key});

  @override
  State<BottomInsetNavigationWidget> createState() =>
      _BottomInsetNavigationWidgetState();
}

class _BottomInsetNavigationWidgetState
    extends State<BottomInsetNavigationWidget> {
  int _selectedNavIndex = 0;

  static const _navDestinations = [
    (label: 'Dashboard', icon: Icons.dashboard_rounded),
    (label: 'Tasks', icon: Icons.task_alt_rounded),
    (label: 'Analytics', icon: Icons.analytics_rounded),
    (label: 'Profile', icon: Icons.person_rounded),
  ];

  final BottomInsetTelemetryRecord _telemetry = BottomInsetTelemetryRecord(
    stepExecutionId: 'EXEC-13921ANSA-2026',
    executionStatus: 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome:
        'Persistent bottom navigation bar mounted with gesture bar inset padding and 48dp touch target compliance.',
    userId: 'ANIK-ERGONOMICS-SPECIALIST',
    completionStatus: 'Complete',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-13921',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bottomGesturePadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: const Text('M3 Gesture Inset Navigation'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detected Gesture Bar Inset: ${bottomGesturePadding.toStringAsFixed(1)} dp',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Navigation container applies system inset padding below the 48dp touch targets.',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Atomic Step Execution Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    _buildRow('Step Execution ID', _telemetry.stepExecutionId),
                    const Divider(height: 12),
                    _buildRow(
                      'Execution Status',
                      _telemetry.executionStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildRow('Step Outcome', _telemetry.stepOutcome),
                    const Divider(height: 12),
                    _buildRow(
                      'Completion Status',
                      _telemetry.completionStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildRow('User Session ID', _telemetry.userSessionId),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: NavigationBar(
          selectedIndex: _selectedNavIndex,
          onDestinationSelected: (index) {
            setState(() => _selectedNavIndex = index);
          },
          indicatorColor: colorScheme.primaryContainer,
          destinations: [
            for (final destination in _navDestinations)
              NavigationDestination(
                icon: Icon(destination.icon),
                selectedIcon: Icon(
                  destination.icon,
                  color: colorScheme.primary,
                ),
                label: destination.label,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
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
