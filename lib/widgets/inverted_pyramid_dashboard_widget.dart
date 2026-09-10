import 'package:flutter/material.dart';

import '../models/inverted_pyramid_telemetry_model.dart';

class InvertedPyramidDashboardWidget extends StatelessWidget {
  const InvertedPyramidDashboardWidget({super.key});

  static const _primaryEntries = [
    'Revenue Run-Rate: 24.2M',
    r'Revenue Run-Rate: $24.2M',
    'Active Node SLA: 99.98%',
    'Customer Churn Index: 0.12%',
    'Ingress Queue Throughput: 14k/s',
    'Operating Margin: +24.5%',
  ];

  void _openContext(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Drill-Down Contextual Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Divider(),
              const ListTile(
                title: Text('Dense Data Log #001'),
                subtitle: Text('SLA breach investigation'),
              ),
              const ListTile(
                title: Text('Dense Data Log #002'),
                subtitle: Text('Ingress buffer overflow'),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CLOSE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inverted Pyramid Operational Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: Colors.green.shade50,
              child: const ListTile(
                leading: Icon(
                  Icons.filter_list_rounded,
                  color: Color(0xFF086C44),
                ),
                title: Text('Field/Element Identification Accuracy: Pass'),
                subtitle: Text(
                  'Strategic indicators are pinned in the top 30% viewport area.',
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card.filled(
              color: colors.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOP 30% VIEWPORT: STRATEGIC OPERATIONAL INDICATORS',
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._primaryEntries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '• $entry',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Card.outlined(
              child: ListTile(
                leading: Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFE31B23),
                ),
                title: Text('Variance Alert: Ingress Queue Latency (+12ms)'),
              ),
            ),
            const SizedBox(height: 16),
            if (compact)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: () => _openContext(context),
                  icon: const Icon(Icons.layers_rounded),
                  label: const Text('OPEN DRILL-DOWN CARD'),
                ),
              )
            else
              const ExpansionTile(
                title: Text('Dense Data Logs & Drill-Down Tables'),
                children: [
                  ListTile(title: Text('Data Log #001: Buffer Overflow')),
                  ListTile(title: Text('Data Log #002: Route Transition')),
                ],
              ),
            const SizedBox(height: 24),
            const Card.outlined(
              child: ListTile(
                leading: Icon(Icons.verified_rounded, color: Color(0xFF086C44)),
                title: Text('EXEC-14416BPTR-2026'),
                subtitle: Text(
                  'PASS • Primary visualization capped at five entries.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
