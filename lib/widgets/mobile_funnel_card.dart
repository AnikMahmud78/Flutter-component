import 'package:flutter/material.dart';
import '../models/mobile_funnel_model.dart';

class MobileFunnelCard extends StatelessWidget {
  final MobileFunnelModel model;
  final VoidCallback onProceedNextStep;

  const MobileFunnelCard({
    Key? key,
    required this.model,
    required this.onProceedNextStep,
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
            Text('Inherited Funnel: @habot/templates/mobile-funnel', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8.0),
            Text('Current Stage: \${model.funnelStage}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            LinearProgressIndicator(value: model.completionRate),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onProceedNextStep,
                child: const Text('Continue Onboarding Step'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
