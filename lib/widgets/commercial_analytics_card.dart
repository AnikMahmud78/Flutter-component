import 'package:flutter/material.dart';
import '../models/commercial_analytics_model.dart';

class CommercialAnalyticsCard extends StatelessWidget {
  final CommercialAnalyticsModel model;
  final VoidCallback onRefresh;

  const CommercialAnalyticsCard({
    Key? key,
    required this.model,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Commercial Wallet Share', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Text('Wallet Share: \${model.walletSharePercentage.toStringAsFixed(1)}%', style: theme.textTheme.headlineMedium),
            Text('Top Spend Category: \${model.topSpendCategory}'),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.pie_chart),
                label: const Text('Refresh Commercial Analytics'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
