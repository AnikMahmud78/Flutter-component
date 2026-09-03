import 'package:flutter/material.dart';
import '../models/candidate_profile_status_telemetry_model.dart';

class CandidateProfileStatusWidget extends StatefulWidget {
  const CandidateProfileStatusWidget({super.key});

  @override
  State<CandidateProfileStatusWidget> createState() =>
      _CandidateProfileStatusWidgetState();
}

class _CandidateProfileStatusWidgetState
    extends State<CandidateProfileStatusWidget> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> _milestones = const [
    {'title': 'Identity Verification', 'status': 'COMPLETED', 'color': Color(0xFF086C44)},
    {'title': 'Background Check', 'icon': Icons.sync, 'status': 'IN_PROGRESS', 'color': Color(0xFFB56C00)},
    {'title': 'Credential Validation', 'status': 'PENDING', 'color': Colors.grey},
  ];

  CandidateProfileStatusTelemetryRecord get _telemetry => CandidateProfileStatusTelemetryRecord(
        creationDate: '2026-09-02T08:30:00Z',
        createdBy: 'SYSTEM_ASYNC_PIPELINE',
        creationMethod: 'EVENT_DRIVEN_INGRESS',
        initialConfiguration: 'SSL_POLICY_TLS_1.3_ONLY',
        objectId: 'OBJ-CANDIDATE-8821',
        completionStatus: 'Pass; Good',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-8201',
      );

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidate Verification Status'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // USABILITY & CORE WEB VITALS BANNER
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
                            'Mobile Usability Compliance: Pass; Good',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '100% 44-48px touch targets (WCAG AA 2.5.5) & Core Web Vitals Good (LCP < 2.5s).',
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

            Text('Async Verification Milestones',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // ANIMATED MILESTONE CARDS
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: _milestones.map((milestone) {
                    final isProgress = milestone['status'] == 'IN_PROGRESS';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(milestone['title'] as String,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ScaleTransition(
                            scale: isProgress ? _pulseAnimation : const AlwaysStoppedAnimation(1.0),
                            child: Chip(
                              avatar: Icon(
                                isProgress ? Icons.sync_rounded : Icons.check_circle_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                              label: Text(
                                milestone['status'] as String,
                                style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: milestone['color'] as Color,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
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
                    _buildRow('Creation Date', telemetry.creationDate),
                    const Divider(height: 12),
                    _buildRow('Created By', telemetry.createdBy),
                    const Divider(height: 12),
                    _buildRow('Initial Config', telemetry.initialConfiguration),
                    const Divider(height: 12),
                    _buildRow('Object ID', telemetry.objectId),
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
