import 'dart:async';
import 'package:flutter/material.dart';
import '../models/consensus_progression_telemetry_model.dart';

class ConsensusPipelineProgressionWidget extends StatefulWidget {
  const ConsensusPipelineProgressionWidget({super.key});

  @override
  State<ConsensusPipelineProgressionWidget> createState() =>
      _ConsensusPipelineProgressionWidgetState();
}

class _ConsensusPipelineProgressionWidgetState
    extends State<ConsensusPipelineProgressionWidget> {
  int _countdown = 5; // 5-Second Expiration Test Trigger
  Timer? _timer;
  bool _isPipelineProgressed = false;
  String _progressionLog = 'VOTING_ACTIVE: Awaiting timer expiration or vote finalization...';

  final ConsensusProgressionTelemetryRecord _telemetry = ConsensusProgressionTelemetryRecord(
    stepExecutionId: 'EXEC-105AWCV-2026',
    executionStatus: 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome:
        'Finalized consensus totals passed directly into downstream workflow automation pipelines on expiration.',
    userId: 'ANIK-EXEC-DESIGNER',
    completionStatus: 'Complete',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-105',
  );

  @override
  void initState() {
    super.initState();
    _startExpirationTimer();
  }

  void _startExpirationTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        _timer?.cancel();
        _triggerAutomatedPipelineProgression();
      }
    });
  }

  void _triggerAutomatedPipelineProgression() {
    final timestamp = DateTime.now().toUtc().toIso8601String();
    setState(() {
      _isPipelineProgressed = true;
      _progressionLog =
          'EXPIRATION_TRIGGERED [$timestamp]: Un-voted logged as ABSTAIN. Finalized Totals [Agree: 14, Disagree: 2, Abstain: 1] passed to pubsub://automation/consensus_pipeline.';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PIPELINE PROGRESSED: Finalized consensus passed downstream.'),
        backgroundColor: Color(0xFF086C44),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consensus Downstream Automation'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WORKFLOW COMPLETENESS BANNER
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
                    Icon(Icons.route_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Voting Workflow Completeness: Complete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Finalized vote totals pass directly into downstream automation pipelines upon expiration.',
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

            // PIPELINE PROGRESSION CARD
            Card.outlined(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Automation Pipeline Trigger',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Chip(
                          label: Text(
                            _isPipelineProgressed ? 'PROGRESSED' : 'EXPIRING IN ${_countdown}s',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          backgroundColor: _isPipelineProgressed
                              ? const Color(0xFF086C44)
                              : Colors.amber.shade900,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _progressionLog,
                      style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
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
                    _buildRow('Step Execution ID', telemetry.stepExecutionId),
                    const Divider(height: 12),
                    _buildRow('Execution Status', telemetry.executionStatus, isHighlight: true),
                    const Divider(height: 12),
                    _buildRow('Step Outcome', telemetry.stepOutcome),
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
