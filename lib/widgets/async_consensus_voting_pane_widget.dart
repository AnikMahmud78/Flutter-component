import 'dart:async';
import 'package:flutter/material.dart';
import '../models/async_voting_pane_telemetry_model.dart';

class AsyncConsensusVotingPaneWidget extends StatefulWidget {
  const AsyncConsensusVotingPaneWidget({super.key});

  @override
  State<AsyncConsensusVotingPaneWidget> createState() =>
      _AsyncConsensusVotingPaneWidgetState();
}

class _AsyncConsensusVotingPaneWidgetState
    extends State<AsyncConsensusVotingPaneWidget> {
  int _agreeVotes = 12;
  int _disagreeVotes = 2;
  int _remainingSeconds = 180; // 3-Minute Expiration Window
  Timer? _timer;
  String? _userVote;

  final AsyncVotingPaneTelemetryRecord _telemetry = AsyncVotingPaneTelemetryRecord(
    stepExecutionId: 'EXEC-655AWCV-2026',
    executionStatus: 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome:
        'Dedicated voting toggle pane rendered beneath descriptive summary container with live tally and timer.',
    userId: 'ANIK-EXEC-DESIGNER',
    completionStatus: 'Complete',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-655',
  );

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  void _castBinaryVote(bool agree) {
    if (_userVote != null) return;
    setState(() {
      _userVote = agree ? 'AGREE' : 'DISAGREE';
      if (agree) {
        _agreeVotes++;
      } else {
        _disagreeVotes++;
      }
    });
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
        title: const Text('Asynchronous Consensus Board'),
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
                    Icon(Icons.how_to_vote_rounded, color: Color(0xFF086C44), size: 28),
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
                            'Dedicated toggle pane rendered with expiration timer and live tally aggregation.',
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

            // TOP PANE: DESCRIPTIVE OPERATIONAL SUMMARY CONTAINER
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
                        const Text('Operational Proposal #9921',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Chip(
                          avatar: const Icon(Icons.timer_rounded, size: 14),
                          label: Text(
                            'Expires: ${_remainingSeconds}s',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.amber.shade100,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Approve direct deployment of BigQuery real-time event routing triggers for Level 13 operations.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // BOTTOM PANE: DEDICATED VOTING TOGGLE PANE
            Card.filled(
              color: colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dedicated Voting Toggle Pane',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('Tally: $_agreeVotes Agree / $_disagreeVotes Disagree',
                            style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 48.0),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _userVote == 'AGREE'
                                    ? const Color(0xFF086C44)
                                    : colorScheme.primary,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _userVote == null ? () => _castBinaryVote(true) : null,
                              icon: const Icon(Icons.thumb_up_rounded),
                              label: const Text('AGREE (SWIPE RIGHT)'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 48.0),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _userVote == 'DISAGREE'
                                    ? const Color(0xFFE31B23)
                                    : const Color(0xFF8B0811),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _userVote == null ? () => _castBinaryVote(false) : null,
                              icon: const Icon(Icons.thumb_down_rounded),
                              label: const Text('DISAGREE (SWIPE LEFT)'),
                            ),
                          ),
                        ),
                      ],
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
