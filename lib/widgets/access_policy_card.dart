import 'package:flutter/material.dart';
import '../models/access_policy_model.dart';
import 'status_chip.dart';

class AccessPolicyCard extends StatelessWidget {
  final AccessPolicyModel policyData;
  final VoidCallback onRefresh;

  const AccessPolicyCard({
    Key? key,
    required this.policyData,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Context-Aware Access Policy',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                StatusChip(
                  label: policyData.status,
                  isPass: policyData.status == 'Pass',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Client Egress IP: ${policyData.clientIp}',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Corporate Egress Match: ${policyData.isCorporateEgress ? "VERIFIED" : "UNAUTHORIZED"}',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Policy Compliance Rate: ${policyData.complianceRate.toStringAsFixed(1)}%',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              minWidth: 48,
              minHeight: 48,
              child: OutlinedButton(
                onPressed: onRefresh,
                child: const Text('Re-evaluate Policy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
