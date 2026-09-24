import 'package:flutter/material.dart';
import '../models/abandonment_metric.dart';

class SingleColumnLayoutWidget extends StatelessWidget {
  final AbandonmentMetric metric;

  const SingleColumnLayoutWidget({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : 32.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Single-Column Experience',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Linearized layout optimized to reduce cognitive friction.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.analytics_outlined),
                          const SizedBox(width: 8),
                          Text('Abandonment Risk Level: '),
                          Chip(
                            label: Text(
                              metric.riskLevel,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: metric.riskLevel == 'Low'
                                ? Colors.green.shade100
                                : Colors.amber.shade100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Measured Abandonment Rate: ${(metric.abandonmentRate * 100).toStringAsFixed(1)}% (Threshold: <30%)',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Proceed Next Step'),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
