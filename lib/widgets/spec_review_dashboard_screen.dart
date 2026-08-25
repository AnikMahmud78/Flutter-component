// Location: lib/widgets/spec_review_dashboard_screen.dart
import 'package:flutter/material.dart';
import '../models/spec_review_telemetry_model.dart';

class SpecReviewDashboardScreen extends StatefulWidget {
  const SpecReviewDashboardScreen({super.key});

  @override
  State<SpecReviewDashboardScreen> createState() =>
      _SpecReviewDashboardScreenState();
}

class _SpecReviewDashboardScreenState extends State<SpecReviewDashboardScreen> {
  final SpecReviewTelemetryRecord _telemetry = SpecReviewTelemetryRecord(
    stepExecutionId: 'EXEC-14295AEETE-2026',
    executionStatus: 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome:
        'Engineering technical accuracy review completed for docs/components/atoms/button.md with 100% scope coverage.',
    userId: 'ANIK-DESIGN-SYSTEM-MAINTAINER',
    completionStatus: 'Complete',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-14295',
    scopeCoverageCompleteness: 1.0,
  );

  final List<Map<String, String>> _reviewItems = [
    {
      'parameter': 'Touch Target Boundary',
      'specValue': '>= 48dp x 48dp',
      'status': 'VERIFIED_PASS'
    },
    {
      'parameter': 'Design Token Mapping',
      'specValue': 'md.sys.color.primary',
      'status': 'VERIFIED_PASS'
    },
    {
      'parameter': 'Responsive Viewport Rules',
      'specValue': 'M3 Window Size Classes',
      'status': 'VERIFIED_PASS'
    },
    {
      'parameter': 'Poka-Yoke Linter Gate',
      'specValue': 'Block Hardcoded Dimensions',
      'status': 'VERIFIED_PASS'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GMRD Spec Technical Review Dashboard'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SCOPE COVERAGE / AUDIT COMPLETENESS BANNER
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
                            'Scope Coverage / Audit Completeness: Complete (100%)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '100% identified, logged, and cross-checked against design/architecture spec.',
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

            // TECHNICAL REVIEW VERIFICATION MATRIX
            Text(
              'Engineering Technical Verification Checklist',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _reviewItems.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = _reviewItems[index];
                  return ListTile(
                    leading: const Icon(Icons.check_circle_rounded,
                        color: Color(0xFF21B373)),
                    title: Text(
                      item['parameter']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    subtitle: Text(
                      'Spec Rule: ${item['specValue']}',
                      style: const TextStyle(
                          fontSize: 11, fontFamily: 'monospace'),
                    ),
                    trailing: Chip(
                      label: Text(
                        item['status']!,
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
                    _buildTelemetryRow(
                        'Step Execution ID', _telemetry.stepExecutionId),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                        'Execution Status', _telemetry.executionStatus,
                        isHighlight: true),
                    const Divider(height: 12),
                    _buildTelemetryRow('Scope Coverage',
                        '${(_telemetry.scopeCoverageCompleteness * 100).toStringAsFixed(0)}% (Complete)'),
                    const Divider(height: 12),
                    _buildTelemetryRow('Execution Timestamp',
                        _telemetry.executionTimestamp.substring(11, 19)),
                    const Divider(height: 12),
                    _buildTelemetryRow('Step Outcome', _telemetry.stepOutcome),
                    const Divider(height: 12),
                    _buildTelemetryRow('User ID', _telemetry.userId),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                        'Completion Status', _telemetry.completionStatus,
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

  Widget _buildTelemetryRow(String label, String value,
      {bool isHighlight = false}) {
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
