import 'dart:async';
import 'package:flutter/material.dart';
import '../models/friction_event_model.dart';

class FrictionListenerWrapper extends StatefulWidget {
  final Widget child;

  const FrictionListenerWrapper({super.key, required this.child});

  @override
  State<FrictionListenerWrapper> createState() =>
      _FrictionListenerWrapperState();
}

class _FrictionListenerWrapperState extends State<FrictionListenerWrapper> {
  final List<FrictionEventModel> _eventLogs = [];

  // Rage Tap Tracking
  int _tapCount = 0;
  Offset? _lastTapPosition;
  DateTime? _lastTapTime;

  @override
  void initState() {
    super.initState();

    // REQUIREMENT: Instantiate friction listener immediately following layout load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logFrictionEvent(
        type: 'LAYOUT_LOADED',
        description:
            'Friction & Hesitation listener attached post-layout render.',
      );
    });
  }

  void _logFrictionEvent({required String type, required String description}) {
    final now = DateTime.now().toUtc().toIso8601String();
    final newEvent = FrictionEventModel(
      eventId: 'FRIC-${DateTime.now().millisecondsSinceEpoch}',
      frictionType: '$type: $description',
      timestamp: now,
      userId: 'ANIK-USER-1502',
    );

    if (mounted) {
      setState(() {
        _eventLogs.insert(0, newEvent);
        if (_eventLogs.length > 10) _eventLogs.removeLast();
      });
    }
  }

  // Detects Rage Taps (3+ taps at same location within 500ms)
  void _handlePointerDown(PointerDownEvent event) {
    final now = DateTime.now();
    final position = event.position;

    if (_lastTapTime != null && _lastTapPosition != null) {
      final timeDiff = now.difference(_lastTapTime!).inMilliseconds;
      final distDiff = (position - _lastTapPosition!).distance;

      if (timeDiff < 500 && distDiff < 30) {
        _tapCount++;
        if (_tapCount >= 3) {
          _logFrictionEvent(
            type: 'RAGE_TAP_DETECTED',
            description:
                '3+ rapid taps registered at pos (${position.dx.toStringAsFixed(0)}, ${position.dy.toStringAsFixed(0)})',
          );
          _tapCount = 0; // Reset
        }
      } else {
        _tapCount = 1;
      }
    } else {
      _tapCount = 1;
    }

    _lastTapTime = now;
    _lastTapPosition = position;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _handlePointerDown,
      child: Stack(
        children: [
          widget.child,

          // Real-time telemetry log drawer overlay
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade900,
              child: ExpansionTile(
                initiallyExpanded: false,
                iconColor: Colors.greenAccent,
                collapsedIconColor: Colors.greenAccent,
                title: Row(
                  children: [
                    const Icon(
                      Icons.analytics_outlined,
                      color: Colors.greenAccent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Friction Telemetry Log Stream',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${_eventLogs.length} Events',
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  Container(
                    height: 150,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: _eventLogs.isEmpty
                        ? const Center(
                            child: Text(
                              'Awaiting user interaction signals...',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: _eventLogs.length,
                            separatorBuilder: (_, __) =>
                                const Divider(color: Colors.white12, height: 1),
                            itemBuilder: (context, index) {
                              final event = _eventLogs[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
                                child: Text(
                                  '[${event.timestamp.substring(11, 19)}] ${event.frictionType}',
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontFamily: 'monospace',
                                    fontSize: 11,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FrictionDemoForm extends StatefulWidget {
  const FrictionDemoForm({super.key});

  @override
  State<FrictionDemoForm> createState() => _FrictionDemoFormState();
}

class _FrictionDemoFormState extends State<FrictionDemoForm> {
  final FocusNode _hesitationFocusNode = FocusNode();
  Timer? _hesitationTimer;

  @override
  void initState() {
    super.initState();
    // REQUIREMENT: Field Hesitation Detection Timer (>5s focus delay)
    _hesitationFocusNode.addListener(() {
      if (_hesitationFocusNode.hasFocus) {
        _hesitationTimer = Timer(const Duration(seconds: 5), () {
          final wrapperState = context
              .findAncestorStateOfType<_FrictionListenerWrapperState>();
          wrapperState?._logFrictionEvent(
            type: 'FIELD_HESITATION',
            description:
                'User focused on "Tax Identification Number" for >5s without input.',
          );
        });
      } else {
        _hesitationTimer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _hesitationFocusNode.dispose();
    _hesitationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friction & Hesitation Listener'),
        backgroundColor: Colors.indigo.shade50,
      ),
      body: SingleChildScrollView(
        // REQUIREMENT: 16px Grid Margins on mobile viewports
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 220.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.touch_app_rounded,
                      color: Colors.indigo.shade800,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Test Rage Taps: Tap rapidly 3+ times anywhere on screen. Test Hesitation: Focus on Tax ID field for 5s without typing.',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Express Onboarding Form',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // FIELD 1: Full Name (* mandatory red asterisk)
            _buildMandatoryLabel('Full Name'),
            const SizedBox(height: 6),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter full legal name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ), // >=48px Touch Target
              ),
            ),

            const SizedBox(height: 16),

            // FIELD 2: Tax ID (* mandatory red asterisk + Hesitation Listener)
            _buildMandatoryLabel('Tax Identification Number (Tax ID)'),
            const SizedBox(height: 6),
            TextFormField(
              focusNode: _hesitationFocusNode,
              decoration: const InputDecoration(
                hintText: 'TAX-00000-X (Focus 5s to test hesitation)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ), // >=48px Touch Target
              ),
            ),

            const SizedBox(height: 24),

            // SUBMIT BUTTON (>=48px touch target height)
            SizedBox(
              width: double.infinity,
              height: 48, // REQUIREMENT: >=48px Touch Target
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade800,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Onboarding Form Submitted Successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text(
                  'Complete Onboarding',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // REQUIREMENT: Mark mandatory fields with a red asterisk (*)
  Widget _buildMandatoryLabel(String label) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(width: 4),
        const Text(
          '*',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
