import 'package:flutter/material.dart';
import '../models/anomaly_item.dart';

class QuarantinedAnomaliesDashboard extends StatelessWidget {
  final String userRole;
  final List<AnomalyItem> anomalies;

  const QuarantinedAnomaliesDashboard({
    super.key,
    required this.userRole,
    required this.anomalies,
  });

  bool get _isManagerAuthorized => userRole == 'MANAGER' || userRole == 'ADMIN';

  @override
  Widget build(BuildContext context) {
    if (!_isManagerAuthorized) {
      return Card(
        color: Theme.of(context).colorScheme.errorContainer,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Access Denied: Manager privileges required to view quarantined anomalies.'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quarantined Anomaly Queue', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        ...anomalies.map(
          (item) => Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: const Icon(Icons.warning_amber, color: Colors.orange),
              title: Text('\${item.anomalyId} - Severity: \${item.severity}'),
              subtitle: Text(item.description),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Inspect'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
