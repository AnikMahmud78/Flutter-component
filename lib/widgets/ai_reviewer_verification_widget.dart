import 'package:flutter/material.dart';
import '../models/ai_reviewer_telemetry_model.dart';

class AiReviewerVerificationWidget extends StatefulWidget {
  const AiReviewerVerificationWidget({super.key});

  @override
  State<AiReviewerVerificationWidget> createState() =>
      _AiReviewerVerificationWidgetState();
}

class _AiReviewerVerificationWidgetState
    extends State<AiReviewerVerificationWidget> {
  bool _isValidating = false;
  bool _forceConflictState = false;

  AiRatingPacket _activePacket = const AiRatingPacket(
    packetId: 'PKT-FUSED-2026-8891',
    primaryAiRating: 'GRADE_A_COMPLIANT',
    reviewerAgentRating: 'GRADE_A_COMPLIANT',
    fusedDataSummary: 'Raw Fused Sensor Packet #8891 (Checksum: 0x9F4A2B)',
    confidenceScore: 0.985,
    isConsensusAchieved: true,
  );

  final AiReviewerTelemetryRecord _telemetry = AiReviewerTelemetryRecord(
    stepExecutionId: 'EXEC-7739ACRAE-2026',
    executionStatus: 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome:
        'Multi-Agent AI ratings cross-verified against fused raw packets. ISO 9001:2015 accuracy verified.',
    userId: 'ANIK-MULTI-AGENT-LEAD',
    completionStatus: 'Good',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-7739',
  );

  void _runCrossVerificationHandshake() {
    setState(() {
      _isValidating = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isValidating = false;
          if (_forceConflictState) {
            _activePacket = _activePacket.copyWith(
              reviewerAgentRating: 'GRADE_C_RISK_FLAGGED',
              isConsensusAchieved: false,
            );
          } else {
            _activePacket = _activePacket.copyWith(
              reviewerAgentRating: 'GRADE_A_COMPLIANT',
              isConsensusAchieved: true,
            );
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _activePacket.isConsensusAchieved
                  ? 'MULTI-AGENT CONSENSUS VERIFIED: Primary and Reviewer Agents agree.'
                  : 'RATING MISMATCH DETECTED: Reviewer Agent flagged a conflict.',
            ),
            backgroundColor: _activePacket.isConsensusAchieved
                ? const Color(0xFF086C44)
                : const Color(0xFF8B0811),
          ),
        );
      }
    });
  }

  void _resolveHumanInTheLoopConflict(String resolvedRating) {
    setState(() {
      _activePacket = _activePacket.copyWith(
        primaryAiRating: resolvedRating,
        reviewerAgentRating: resolvedRating,
        isConsensusAchieved: true,
      );
      _forceConflictState = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'HUMAN RESOLUTION APPLIED: Consensus established as "$resolvedRating".',
        ),
        backgroundColor: const Color(0xFF086C44),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isConsensus = _activePacket.isConsensusAchieved;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Reviewer Agent Cross-Verification'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ISO 9001:2015 QUALITY MANAGEMENT BANNER
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
                    Icon(
                      Icons.verified_user_rounded,
                      color: Color(0xFF086C44),
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Process Execution Accuracy Rate: Good (1.0 / 100%)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Compliant with ISO 9001:2015 Quality Management System Standard.',
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

            // CONFLICT TOGGLE FOR TESTING
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Simulate Multi-Agent Rating Mismatch',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                Switch(
                  value: _forceConflictState,
                  onChanged: (val) {
                    setState(() {
                      _forceConflictState = val;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            // PRIMARY AI VS REVIEWER AGENT CARD
            Card.outlined(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(
                  color: isConsensus
                      ? colorScheme.primary
                      : const Color(0xFFE31B23),
                  width: 1.5,
                ),
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
                          _activePacket.packetId,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        // CIRCULAR PROGRESS INDICATOR (PRIMARY COLOR) FOR STATUS
                        if (_isValidating)
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: colorScheme.primary,
                            ),
                          )
                        else
                          Chip(
                            avatar: Icon(
                              isConsensus
                                  ? Icons.check_circle_rounded
                                  : Icons.warning_amber_rounded,
                              size: 14,
                              color: isConsensus
                                  ? Colors.white
                                  : const Color(0xFF8B0811),
                            ),
                            label: Text(
                              isConsensus
                                  ? 'CONSENSUS_ACHIEVED'
                                  : 'RATING_CONFLICT',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isConsensus
                                    ? Colors.white
                                    : const Color(0xFF8B0811),
                              ),
                            ),
                            backgroundColor: isConsensus
                                ? colorScheme.primary
                                : const Color(0xFFF9DEDC),
                          ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // FUSED DATA SUMMARY LABEL (TITLE SMALL)
                    Text(
                      'FUSED DATA PACKET SUMMARY',
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _activePacket.fusedDataSummary,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),
                    const Divider(height: 1),
                    const SizedBox(height: 14),

                    // RATING COMPARISON GRID
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PRIMARY AI RATING',
                                style: textTheme.titleSmall?.copyWith(
                                  fontSize: 11,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _activePacket.primaryAiRating,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'REVIEWER AGENT RATING',
                                style: textTheme.titleSmall?.copyWith(
                                  fontSize: 11,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _activePacket.reviewerAgentRating,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: isConsensus
                                      ? colorScheme.primary
                                      : const Color(0xFFE31B23),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // "RESOLVE CONFLICT" VIEW FOR HUMAN INTERVENTION (WHEN CONSENSUS FAILS)
            if (!isConsensus) ...[
              Card.filled(
                color: const Color(0xFFF9DEDC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFE31B23)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.gavel_rounded,
                            color: Color(0xFF8B0811),
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Resolve Conflict (Human-in-the-Loop)',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF8B0811),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Multi-Agent disagreement detected between Primary AI and Reviewer Agent. Select override authority:',
                        style: TextStyle(fontSize: 11, color: Colors.black87),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 48.0,
                              ),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: colorScheme.primary,
                                  side: BorderSide(color: colorScheme.primary),
                                ),
                                onPressed: () => _resolveHumanInTheLoopConflict(
                                  'GRADE_A_COMPLIANT',
                                ),
                                child: const Text(
                                  'APPROVE_GRADE_A',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 48.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE31B23),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () => _resolveHumanInTheLoopConflict(
                                  'GRADE_C_RISK_FLAGGED',
                                ),
                                child: const Text(
                                  'CONFIRM_RISK_C',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // CROSS-VERIFICATION TRIGGER BUTTON (TOUCH TARGET >= 48DP)
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 48.0,
                minWidth: 48.0,
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
                  onPressed: _isValidating
                      ? null
                      : _runCrossVerificationHandshake,
                  icon: const Icon(Icons.sync_rounded),
                  label: Text(
                    'CROSS_VERIFY_AI_RATINGS',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY LOG
            Text(
              'Atomic Step Execution Telemetry',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Step Execution ID', telemetry.stepExecutionId),
                    const Divider(height: 12),
                    _buildRow(
                      'Execution Status',
                      telemetry.executionStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildRow(
                      'Execution Timestamp',
                      telemetry.executionTimestamp.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildRow('Step Outcome', telemetry.stepOutcome),
                    const Divider(height: 12),
                    _buildRow('User ID', telemetry.userId),
                    const Divider(height: 12),
                    _buildRow(
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

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
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
              color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
