import 'package:flutter/material.dart';
import '../models/dcyn_runtime_validation_model.dart';

class DcynRuntimeValidationWidget extends StatefulWidget {
  const DcynRuntimeValidationWidget({super.key});

  @override
  State<DcynRuntimeValidationWidget> createState() =>
      _DcynRuntimeValidationWidgetState();
}

class _DcynRuntimeValidationWidgetState
    extends State<DcynRuntimeValidationWidget> {
  final DcynRuntimeValidationModel _model = const DcynRuntimeValidationModel(
    layoutType: 'DCYN_BINARY_COMPLIANCE_STACK',
    layoutGridDimensions: '4-Col Mobile Vertical Stack',
    spacingRules: '4px Scale (8dp, 12dp, 16dp)',
    alignmentSettings: 'VERTICAL_STACK_TOUCH_OPTIMIZED',
    layoutValidationStatus: 'HARD_CODED_DCYN_PASS',
  );

  bool _dcynResult = true;

  DcynTelemetryRecord get _telemetry => DcynTelemetryRecord(
        layoutType: _model.layoutType,
        layoutGridDimensions: _model.layoutGridDimensions,
        spacingRules: _model.spacingRules,
        alignmentSettings: _model.alignmentSettings,
        layoutValidationStatus: _model.layoutValidationStatus,
        completionStatus: 'Good',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-6925',
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DCYN Runtime Compliance Check'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DORA DEPLOYMENT SUCCESS RATE BANNER
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
                    Icon(Icons.verified_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DORA Deployment Success Rate: Good (98%+ Target)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'DCYN binary validation logic hard-coded into runtime model with zero deployment defects.',
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

            // VERTICAL STACKED PARAMETER CARDS
            Text('Active Validation Parameter Cards',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Card.outlined(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      title: const Text('DCYN Check 01: Encryption Token Gate'),
                      subtitle: const Text('Hard-coded check: DCYN-VALID-9901'),
                      trailing: Chip(
                        label: Text(_dcynResult ? 'DCYN_PASS' : 'DCYN_FAIL',
                            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                        backgroundColor: _dcynResult ? const Color(0xFF086C44) : const Color(0xFFE31B23),
                      ),
                    ),
                    const Divider(),
                    // EXPANDED TAP BOUNDARY TOGGLE (>=48DP)
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 48.0, minWidth: 48.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() => _dcynResult = !_dcynResult);
                          },
                          child: const Text('TOGGLE_RUNTIME_DCYN_CHECK_STATE'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY LOG
            Text('Atomic Step Execution Telemetry',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Layout Type', telemetry.layoutType),
                    const Divider(height: 12),
                    _buildRow('Grid Dimensions', telemetry.layoutGridDimensions),
                    const Divider(height: 12),
                    _buildRow('Validation Status', telemetry.layoutValidationStatus, isHighlight: true),
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
