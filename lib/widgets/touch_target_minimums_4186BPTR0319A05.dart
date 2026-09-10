import 'package:flutter/material.dart';

class TouchTargetMinimums4186BPTR0319A05 extends StatelessWidget {
  const TouchTargetMinimums4186BPTR0319A05({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Touch Target Minimums')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.accessibility_new_rounded),
            title: Text('4186BPTR-0319-A05'),
            subtitle: Text('All actionable controls use a minimum 48dp target.'),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.touch_app_rounded),
              label: const Text('48DP ACTION TARGET'),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('48DP SECONDARY TARGET'),
            ),
          ),
          const SizedBox(height: 16),
          const Card.outlined(
            child: ListTile(
              title: Text('Validation Status: Complete'),
              subtitle: Text('Configuration Key: INTERACTIVE_MIN_HEIGHT_48DP'),
            ),
          ),
        ],
      ),
    );
  }
}
