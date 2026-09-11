import 'package:flutter/material.dart';

class TouchTargetMinimums2690BPTR0319A07 extends StatelessWidget {
  const TouchTargetMinimums2690BPTR0319A07({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Miniature Control Sizing')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.tune_rounded),
            title: Text('2690BPTR-0319-A07'),
            subtitle: Text(
              'Padding and tap boxes are constrained to 48dp minimums.',
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox.square(
                dimension: 48,
                child: IconButton(
                  tooltip: 'Settings',
                  onPressed: () {},
                  icon: const Icon(Icons.settings_rounded),
                ),
              ),
              SizedBox.square(
                dimension: 48,
                child: IconButton(
                  tooltip: 'Filter',
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list_rounded),
                ),
              ),
              SizedBox.square(
                dimension: 48,
                child: IconButton(
                  tooltip: 'More options',
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_rounded),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Card.outlined(
            child: ListTile(
              title: Text('Validation Status: Complete'),
              subtitle: Text('Configuration Type: GLOBAL_TOUCH_TARGET_RULE'),
            ),
          ),
        ],
      ),
    );
  }
}
