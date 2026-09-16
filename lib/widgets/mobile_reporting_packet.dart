import 'package:flutter/material.dart';

class MobileReportingPacket extends StatelessWidget {
  final Map<String, String> deviceSpecs;

  const MobileReportingPacket({
    super.key,
    required this.deviceSpecs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Structured Mobile Telemetry Packet', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ...deviceSpecs.entries.map((spec) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(spec.key, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                Text(spec.value, style: theme.textTheme.bodyMedium),
              ],
            ),
          );
        }),
      ],
    );
  }
}
