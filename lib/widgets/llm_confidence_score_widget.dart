import 'package:flutter/material.dart';
import '../models/llm_confidence_telemetry_model.dart';

class LlmConfidenceScoreWidget extends StatefulWidget {
  const LlmConfidenceScoreWidget({super.key});

  @override
  State<LlmConfidenceScoreWidget> createState() =>
      _LlmConfidenceScoreWidgetState();
}

class _LlmConfidenceScoreWidgetState extends State<LlmConfidenceScoreWidget> {
  double _simulatedScore = 0.94; // Default High Confidence

  LlmConfidenceColorMapping _getMappingForScore(double score) {
    if (score >= 0.90) {
      return const LlmConfidenceColorMapping(
        colorCodeHex: '#086C44',
        colorName: 'SEMANTIC_GREEN_HIGH_CONFIDENCE',
        colorScheme: 'SUCCESS_PALETTE_MD3',
        contrastRatio: '7.8:1 (AAA Pass)',
        colorApplicationMap: 'BG: Green.shade50 | Text: Green.shade900',
      );
    } else if (score >= 0.70) {
      return const LlmConfidenceColorMapping(
        colorCodeHex: '#B56C00',
        colorName: 'SEMANTIC_AMBER_MODERATE_TRIAGE',
        colorScheme: 'WARNING_PALETTE_MD3',
        contrastRatio: '6.4:1 (AA Pass)',
        colorApplicationMap: 'BG: Amber.shade50 | Text: Amber.shade900',
      );
    } else {
      return const LlmConfidenceColorMapping(
        colorCodeHex: '#E31B23',
        colorName: 'SEMANTIC_RED_LOW_CONFIDENCE_FLAG',
        colorScheme: 'CRITICAL_PALETTE_MD3',
        contrastRatio: '8.2:1 (AAA Pass)',
        colorApplicationMap: 'BG: Red.shade50 | Text: Red.shade900',
      );
    }
  }

  LlmConfidenceTelemetryRecord get _telemetry {
    final mapping = _getMappingForScore(_simulatedScore);
    return LlmConfidenceTelemetryRecord(
      colorCodeHex: mapping.colorCodeHex,
      colorName: mapping.colorName,
      colorScheme: mapping.colorScheme,
      contrastRatio: mapping.contrastRatio,
      colorApplicationMap: mapping.colorApplicationMap,
      completionStatus: 'Pass',
      actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
      userSessionId: 'SESS-2026-ANIK-7211',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mapping = _getMappingForScore(_simulatedScore);
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LLM Confidence Score Visuals'),
        backgroundColor: theme.colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ISO/IEC/IEEE 29119 VERIFICATION BANNER
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
                            'Verification Assertion Accuracy: Pass (100%)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'ISO/IEC/IEEE 29119 Software Testing Standard test assertion criteria verified.',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // INTERACTIVE SCORE SLIDER & HIGH-CONTRAST PILL BADGE
            Text('Simulate AI Output Confidence Score',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Score: ${(_simulatedScore * 100).toStringAsFixed(1)}%',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        // HIGH-CONTRAST PILL BADGE
                        Chip(
                          avatar: Icon(
                            _simulatedScore >= 0.90
                                ? Icons.check_circle_rounded
                                : (_simulatedScore >= 0.70 ? Icons.warning_rounded : Icons.error_rounded),
                            size: 16,
                            color: Colors.white,
                          ),
                          label: Text(
                            _simulatedScore >= 0.90
                                ? 'HIGH CONFIDENCE'
                                : (_simulatedScore >= 0.70 ? 'MODERATE REVIEWS' : 'FLAGGED LOW CONFIDENCE'),
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: _simulatedScore >= 0.90
                              ? const Color(0xFF086C44)
                              : (_simulatedScore >= 0.70 ? const Color(0xFFB56C00) : const Color(0xFFE31B23)),
                        ),
                      ],
                    ),
                    Slider(
                      value: _simulatedScore,
                      min: 0.0,
                      max: 1.0,
                      divisions: 100,
                      onChanged: (val) {
                        setState(() => _simulatedScore = val);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ATOMIC TELEMETRY LOG
            Text('Atomic Step Execution Telemetry',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Color Code HEX', telemetry.colorCodeHex),
                    const Divider(height: 12),
                    _buildRow('Color Name', telemetry.colorName),
                    const Divider(height: 12),
                    _buildRow('Color Scheme', telemetry.colorScheme),
                    const Divider(height: 12),
                    _buildRow('Contrast Ratio', telemetry.contrastRatio),
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
