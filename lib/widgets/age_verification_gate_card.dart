import 'package:flutter/material.dart';
import '../models/age_verification_model.dart';

class AgeVerificationGateCard extends StatelessWidget {
  final AgeVerificationModel model;
  final ValueChanged<int> onAgeChanged;

  const AgeVerificationGateCard({
    Key? key,
    required this.model,
    required this.onAgeChanged,
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
            Text(
              'Age-Verification Gate',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Provider Eligibility: \${model.providerMinAgeYears} - \${model.providerMaxAgeYears} Years'),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Child Age: \${model.childAgeYears} yrs', style: theme.textTheme.titleMedium),
                Chip(
                  avatar: Icon(
                    model.isEligible ? Icons.check_circle : Icons.block,
                    color: model.isEligible ? Colors.green : Colors.red,
                  ),
                  label: Text(model.isEligible ? 'Eligible' : 'Ineligible'),
                  backgroundColor: model.isEligible ? Colors.green.shade50 : Colors.red.shade50,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.0,
                    child: OutlinedButton(
                      onPressed: () => onAgeChanged(model.childAgeYears - 1),
                      child: const Text('-1 Year'),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: SizedBox(
                    height: 48.0,
                    child: ElevatedButton(
                      onPressed: () => onAgeChanged(model.childAgeYears + 1),
                      child: const Text('+1 Year'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
