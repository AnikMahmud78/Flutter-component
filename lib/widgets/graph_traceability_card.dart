import 'package:flutter/material.dart';

class GraphTraceabilityCard extends StatefulWidget {
  const GraphTraceabilityCard({super.key});

  @override
  State<GraphTraceabilityCard> createState() => _GraphTraceabilityCardState();
}

class _GraphTraceabilityCardState extends State<GraphTraceabilityCard> {
  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Graph Interactive View State:'),
            Switch(
              value: _isEnabled,
              onChanged: (val) => setState(() => _isEnabled = val),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        IgnorePointer(
          ignoring: !_isEnabled,
          child: Opacity(
            opacity: _isEnabled ? 1.0 : 0.38, // Strict 38% opacity assignment
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('RCAE Pass Rate Node Graph', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 12.0),
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InteractiveViewer(
                        panEnabled: true,
                        scaleEnabled: true,
                        minScale: 0.8,
                        maxScale: 2.5,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_tree, size: 48, color: theme.colorScheme.primary),
                              const SizedBox(height: 8.0),
                              const Text('Pinch to zoom / Pan RCAE Nodes'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 48.0,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48.0),
                        ),
                        onPressed: _isEnabled ? () {} : null,
                        child: const Text('EXECUTE GRAPH TRACEABILITY'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
