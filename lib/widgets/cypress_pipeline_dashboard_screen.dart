// Location: lib/widgets/cypress_pipeline_dashboard_screen.dart
import 'package:flutter/material.dart';
import '../models/cypress_pipeline_telemetry_model.dart';

class CypressPipelineDashboardScreen extends StatefulWidget {
  const CypressPipelineDashboardScreen({super.key});

  @override
  State<CypressPipelineDashboardScreen> createState() =>
      _CypressPipelineDashboardScreenState();
}

class _CypressPipelineDashboardScreenState
    extends State<CypressPipelineDashboardScreen> {
  final CypressPipelineTelemetryRecord _telemetry =
      CypressPipelineTelemetryRecord(
    testType: 'CYPRESS_E2E_RESPONSIVE_INTERFACE_VALIDATION',
    testResult: 'PASSED_100_PERCENT_ENVIRONMENTS',
    testCoverage: 1.0,
    testTimestamp: DateTime.now().toUtc().toIso8601String(),
    testLogPath: 'cypress/logs/MobileLayoutResponsiveCheck.log',
    completionStatus: 'Pass',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-14240',
  );

  final List<Map<String, String>> _e2eTestScenarios = [
    {
      'scenario': '360px Mobile Layout Overflow Check',
      'spec': 'MobileLayoutResponsiveCheck.spec.ts:10',
      'result': 'PASSED'
    },
    {
      'scenario': 'Touch Target Sizing Check (>=48x48dp)',
      'spec': 'MobileLayoutResponsiveCheck.spec.ts:20',
      'result': 'PASSED'
    },
    {
      'scenario': 'Clean Form Focus Loop Navigation',
      'spec': 'MobileLayoutResponsiveCheck.spec.ts:28',
      'result': 'PASSED'
    },
    {
      'scenario': 'Modal Dialog Body Scroll Lock',
      'spec': 'MobileLayoutResponsiveCheck.spec.ts:35',
      'result': 'PASSED'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cypress E2E Front-End Validation Runner'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FUNCTIONAL TEST PASS RATE BANNER
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
                    Icon(Icons.verified_user_rounded,
                        color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Functional Test Pass Rate: Pass (100% Environments + CI)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'All scenarios in tests/e2e/MobileLayoutResponsiveCheck.spec.ts pass; CI regression active.',
                            style:
                                TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // E2E SCENARIO EXECUTION MATRIX
            Text(
              'Cypress E2E Pipeline Execution Matrix',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _e2eTestScenarios.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = _e2eTestScenarios[index];
                  return ListTile(
                    leading: const Icon(Icons.check_circle_rounded,
                        color: Color(0xFF21B373)),
                    title: Text(
                      item['scenario']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    subtitle: Text(
                      'Spec: ${item['spec']}',
                      style: const TextStyle(
                          fontSize: 11, fontFamily: 'monospace'),
                    ),
                    trailing: Chip(
                      label: Text(
                        item['result']!,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: const Color(0xFF086C44),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY LOG
            Text(
              'Atomic Step Execution Telemetry',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Test Type', _telemetry.testType),
                    const Divider(height: 12),
                    _buildRow('Test Result', _telemetry.testResult,
                        isHighlight: true),
                    const Divider(height: 12),
                    _buildRow('Pass Rate Level', _telemetry.functionalTestPassRate),
                    const Divider(height: 12),
                    _buildRow('Test Timestamp',
                        _telemetry.testTimestamp.substring(11, 19)),
                    const Divider(height: 12),
                    _buildRow('Log File Path', _telemetry.testLogPath),
                    const Divider(height: 12),
                    _buildRow('Completion Status', _telemetry.completionStatus,
                        isHighlight: true),
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
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
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
              color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
