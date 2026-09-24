import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SemanticSwipeContainer extends StatelessWidget {
  const SemanticSwipeContainer({Key? key}) : super(key: key);

  // English Code (EC): Build-Sequential-Semantic-Nodes
  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            label: 'Header Section: System Health Metrics',
            child: Text(
              'System Health Metrics',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 16),
          Semantics(
            sortKey: const OrdinalSortKey(1.0),
            label: 'Metric Card 1: Process Completion Engine Status',
            hint: 'Double tap to open metric deep dive',
            child: Card(
              child: ListTile(
                title: const Text('Process Engine'),
                subtitle: const Text('Status: Operational (100% Rate)'),
                trailing: const Icon(Icons.check_circle, color: Colors.green),
                onTap: () {},
              ),
            ),
          ),
          const SizedBox(height: 12),
          Semantics(
            sortKey: const OrdinalSortKey(2.0),
            label: 'Metric Card 2: Swipe Navigation Verification',
            hint: 'Swipe right to access next control',
            child: Card(
              child: ListTile(
                title: const Text('DOM Sequential Traverser'),
                subtitle: const Text('Accessibility Order Locked'),
                trailing: const Icon(Icons.swipe, color: Colors.blue),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
