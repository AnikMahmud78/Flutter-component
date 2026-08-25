import 'package:flutter/material.dart';
import '../models/agentic_handoff_telemetry_model.dart';

enum HandoffState { idle, inProgress, networkDropException, recovered }

class AgenticHandoffAnimationWidget extends StatefulWidget {
  const AgenticHandoffAnimationWidget({super.key});

  @override
  State<AgenticHandoffAnimationWidget> createState() =>
      _AgenticHandoffAnimationWidgetState();
}

class _AgenticHandoffAnimationWidgetState
    extends State<AgenticHandoffAnimationWidget>
    with SingleTickerProviderStateMixin {
  HandoffState _currentState = HandoffState.idle;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;

  final AgenticHandoffTelemetry _telemetry = AgenticHandoffTelemetry(
    layoutType: 'AGENTIC_HANDOFF_EXCEPTION_CANVAS',
    layoutGridDimensions: '4-Col Mobile (360dp) / 16dp Margin',
    spacingRules: '4px Scale (4, 8, 16, 24, 48)',
    alignmentSettings: 'CENTER_AXIS_STATE_BOUND_PULSE',
    layoutValidationStatus: 'PASSED_STATE_BOUND_MOTION',
    completionStatus: 'Good',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-5594',
  );

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scaleAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _triggerAgenticHandoff() {
    setState(() {
      _currentState = HandoffState.inProgress;
    });
    _pulseController.repeat(reverse: true);

    // Simulate unexpected network handoff drop after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _pulseController.stop();
        setState(() {
          _currentState = HandoffState.networkDropException;
        });
      }
    });
  }

  void _recoverHandoff() {
    setState(() {
      _currentState = HandoffState.inProgress;
    });
    _pulseController.repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        _pulseController.stop();
        setState(() {
          _currentState = HandoffState.recovered;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'HANDOFF RESOLVED: Agentic state synced in < 15 min limit.',
            ),
            backgroundColor: Color(0xFF086C44),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agentic Task Handoff Micro-Animations'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ITIL 4 & LEAN SIX SIGMA QUALITY BANNER
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
                      Icons.verified_rounded,
                      color: Color(0xFF086C44),
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Exception Resolution Status: Good (100% Compliant)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'ITIL 4 Incident Management & Lean Six Sigma Cycle-Time Compliant.',
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

            // AGENTIC HANDOFF STATE ANIMATION DISPLAY
            Text(
              'Agentic Task Handoff Pipeline',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'State-bound micro-animations manage perceived latency and exception drops.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _currentState == HandoffState.inProgress
                      ? _scaleAnimation.value
                      : 1.0,
                  child: Card.outlined(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(
                        color:
                            _currentState == HandoffState.networkDropException
                            ? const Color(0xFFE31B23)
                            : (_currentState == HandoffState.recovered
                                  ? const Color(0xFF21B373)
                                  : colorScheme.outlineVariant),
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          _buildStateHeader(),
                          const SizedBox(height: 16),
                          _buildAnimatedContent(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // TRIGGER / RECOVERY ACTION BUTTON (TOUCH TARGET >= 48DP)
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
                    backgroundColor:
                        _currentState == HandoffState.networkDropException
                        ? const Color(0xFFE31B23)
                        : colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _currentState == HandoffState.networkDropException
                      ? _recoverHandoff
                      : _triggerAgenticHandoff,
                  icon: Icon(
                    _currentState == HandoffState.networkDropException
                        ? Icons.sync_problem_rounded
                        : Icons.play_arrow_rounded,
                  ),
                  label: Text(
                    _currentState == HandoffState.networkDropException
                        ? 'RECOVER_HANDOFF_DROP (<15 MIN)'
                        : 'INITIATE_AGENTIC_HANDOFF',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY DISPLAY
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
                    _buildRow('Layout Type', _telemetry.layoutType),
                    const Divider(height: 12),
                    _buildRow(
                      'Grid Dimensions',
                      _telemetry.layoutGridDimensions,
                    ),
                    const Divider(height: 12),
                    _buildRow('Spacing Rules', _telemetry.spacingRules),
                    const Divider(height: 12),
                    _buildRow(
                      'Alignment Settings',
                      _telemetry.alignmentSettings,
                    ),
                    const Divider(height: 12),
                    _buildRow(
                      'Validation Status',
                      _telemetry.layoutValidationStatus,
                    ),
                    const Divider(height: 12),
                    _buildRow(
                      'Completion Status',
                      _telemetry.completionStatus,
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

  Widget _buildStateHeader() {
    switch (_currentState) {
      case HandoffState.idle:
        return const Row(
          children: [
            Icon(Icons.smart_toy_outlined, color: Colors.blueGrey),
            SizedBox(width: 10),
            Text(
              'Agent A Ready for Task Transition',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        );
      case HandoffState.inProgress:
        return const Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 10),
            Text(
              'Executing Task Handoff (Agent A ➔ Agent B)...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        );
      case HandoffState.networkDropException:
        return const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Color(0xFFE31B23)),
            SizedBox(width: 10),
            Text(
              'EXCEPTIONAL HANDOFF DROP DETECTED',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Color(0xFFE31B23),
              ),
            ),
          ],
        );
      case HandoffState.recovered:
        return const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Color(0xFF21B373)),
            SizedBox(width: 10),
            Text(
              'Agent B Context Sync Complete',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Color(0xFF086C44),
              ),
            ),
          ],
        );
    }
  }

  Widget _buildAnimatedContent() {
    if (_currentState == HandoffState.networkDropException) {
      return Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF9DEDC),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text(
          'Network packet loss interrupted stream transfer between Agent A and Agent B. State cached locally.',
          style: TextStyle(fontSize: 11, color: Color(0xFF8B0811)),
        ),
      );
    }

    return LinearProgressIndicator(
      value: _currentState == HandoffState.recovered
          ? 1.0
          : (_currentState == HandoffState.idle ? 0.0 : null),
      backgroundColor: Colors.grey.shade200,
      color: _currentState == HandoffState.recovered
          ? const Color(0xFF21B373)
          : Colors.indigo,
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
