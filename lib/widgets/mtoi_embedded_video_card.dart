import 'dart:async';
import 'package:flutter/material.dart';
import '../models/mtoi_training_model.dart';

class MtoiEmbeddedVideoCard extends StatefulWidget {
  const MtoiEmbeddedVideoCard({super.key});

  @override
  State<MtoiEmbeddedVideoCard> createState() => _MtoiEmbeddedVideoCardState();
}

class _MtoiEmbeddedVideoCardState extends State<MtoiEmbeddedVideoCard> {
  final MtoiTrainingState _trainingState = MtoiTrainingState(
    videoId: 'MTOI-VID-2026-892',
    videoTitle: 'MTOI Safety Protocol & Equipment Operational Training',
  );

  final TextEditingController _feedbackController = TextEditingController();

  // Simulated Video Playback Controllers
  bool _isPlaying = false;
  double _playbackProgress = 0.0; // 0.0 to 1.0
  Timer? _videoTimer;

  MtoiAuditTelemetry get _telemetry => MtoiAuditTelemetry(
    stepExecutionId: 'EXEC-2822MTVPE-2026',
    executionStatus: 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome: _trainingState.isVideoCompleted
        ? 'MTOI Video Completed. Interactive Input Field Un-Gated Successfully.'
        : 'MTOI Video Incomplete. Interactive Input Field Hard-Locked.',
    userId: 'ANIK-MTOI-LEAD',
  );

  @override
  void dispose() {
    _videoTimer?.cancel();
    _feedbackController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _videoTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
        if (!mounted) return;
        setState(() {
          _playbackProgress += 0.05;
          if (_playbackProgress >= 1.0) {
            _playbackProgress = 1.0;
            _isPlaying = false;
            _trainingState.isVideoCompleted = true; // UN-GATE TRIGGER
            timer.cancel();
          }
        });
      });
    } else {
      _videoTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MTOI Embedded Video Training'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DORA DEPLOYMENT METRIC BANNER
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
                            'Deployment Gate Failure-Detection: Pass (1.0)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Compliant with Google DORA Deployment-Frequency & Change-Failure Rate Metrics.',
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

            // EMBEDDED MEDIA IN AN M3 ELEVATED CARD
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MEDIA CONTAINER
                  Container(
                    height: 180.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16.0),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // PLAYBACK PROGRESS INDICATOR OVERLAY
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: LinearProgressIndicator(
                            value: _playbackProgress,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _trainingState.isVideoCompleted
                                  ? Colors.green
                                  : colorScheme.primary,
                            ),
                          ),
                        ),

                        // LARGE PLAY / PAUSE ICON (48X48 DP TAP TARGET)
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 48.0,
                            minHeight: 48.0,
                          ),
                          child: IconButton(
                            iconSize: 48.0,
                            icon: Icon(
                              _trainingState.isVideoCompleted
                                  ? Icons.check_circle_rounded
                                  : (_isPlaying
                                        ? Icons.pause_circle_filled_rounded
                                        : Icons.play_circle_fill_rounded),
                              color: _trainingState.isVideoCompleted
                                  ? Colors.greenAccent
                                  : Colors.white,
                            ),
                            onPressed: _trainingState.isVideoCompleted
                                ? null
                                : _togglePlayPause,
                          ),
                        ),

                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${(_playbackProgress * 100).toInt()}% COMPLETED',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // CARD DETAILS
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _trainingState.videoTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Video ID: ${_trainingState.videoId} • Required for Un-gating',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // UN-GATED / HARD-LOCKED INTERACTIVE FORM INPUT
            Text(
              'Training Feedback & Acknowledgement',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            TextFormField(
              controller: _feedbackController,
              enabled: _trainingState.isVideoCompleted, // UN-GATING LOGIC
              decoration: InputDecoration(
                labelText: _trainingState.isVideoCompleted
                    ? 'Enter Operational Understanding Notes *'
                    : 'LOCKED: Watch training video to unlock input field',
                border: const OutlineInputBorder(),
                filled: !_trainingState.isVideoCompleted,
                fillColor: Colors.grey.shade200,
                prefixIcon: Icon(
                  _trainingState.isVideoCompleted
                      ? Icons.lock_open_rounded
                      : Icons.lock_rounded,
                  color: _trainingState.isVideoCompleted
                      ? Colors.green
                      : Colors.red,
                ),
                helperText: _trainingState.isVideoCompleted
                    ? 'Field un-gated successfully following video completion.'
                    : 'Input disabled until video playback reaches 100%.',
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY LOGS
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
                      'Step Execution ID',
                      telemetry.stepExecutionId,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Execution Status',
                      telemetry.executionStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Execution Timestamp',
                      telemetry.executionTimestamp.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('Step Outcome', telemetry.stepOutcome),
                    const Divider(height: 12),
                    _buildTelemetryRow('User ID', telemetry.userId),
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
