import 'package:flutter/material.dart';

class PassiveFailureMotionCurves963BPTR0422A10 extends StatefulWidget {
  const PassiveFailureMotionCurves963BPTR0422A10({super.key});

  @override
  State<PassiveFailureMotionCurves963BPTR0422A10> createState() => _PassiveFailureMotionCurves963BPTR0422A10State();
}

class _PassiveFailureMotionCurves963BPTR0422A10State extends State<PassiveFailureMotionCurves963BPTR0422A10> {
  static const motionDuration = Duration(milliseconds: 300);
  bool _failureVisible = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Passive Failure Motion Curves')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.motion_photos_off_rounded), title: Text('963BPTR-0422-A10'), subtitle: Text('System failures use a centralized 300ms accelerated exit motion.')),
          const SizedBox(height: 16),
          AnimatedSlide(
            duration: motionDuration,
            curve: Curves.easeIn,
            offset: _failureVisible ? Offset.zero : const Offset(0, -1),
            child: AnimatedOpacity(
              duration: motionDuration,
              opacity: _failureVisible ? 1 : 0,
              child: Card.filled(color: Colors.red.shade50, child: const ListTile(leading: Icon(Icons.error_rounded, color: Colors.red), title: Text('Quarantined data requires acknowledgement.'), subtitle: Text('Motion remains visible until addressed.'))),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(height: 48, child: FilledButton.icon(onPressed: () => setState(() => _failureVisible = !_failureVisible), icon: const Icon(Icons.warning_rounded), label: Text(_failureVisible ? 'ACKNOWLEDGE FAILURE' : 'TRIGGER FAILURE'))),
          const SizedBox(height: 16),
          const Card.outlined(child: ListTile(title: Text('Motion Configuration: Complete'), subtitle: Text('Duration: 300ms • Curve: easeIn • Dimming: 12%'))),
        ],
      );
}
