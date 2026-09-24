import 'package:flutter/material.dart';
import '../models/sla_status_payload.dart';

class SlaFaultSimulator extends StatefulWidget {
  const SlaFaultSimulator({Key? key}) : super(key: key);

  @override
  State<SlaFaultSimulator> createState() => _SlaFaultSimulatorState();
}

class _SlaFaultSimulatorState extends State<SlaFaultSimulator> {
  bool _isFaultTriggered = false;
  double _uptime = 99.95;

  // English Code (EC): Toggle-Artificial-Sla-Breach
  void toggleArtificialSlaBreach() {
    setState(() {
      _isFaultTriggered = !_isFaultTriggered;
      _uptime = _isFaultTriggered ? 94.20 : 99.95;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = _isFaultTriggered ? theme.colorScheme.errorContainer : theme.colorScheme.surfaceContainerHighest;
    final textColor = _isFaultTriggered ? theme.colorScheme.onErrorContainer : theme.colorScheme.onSurfaceVariant;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: _isFaultTriggered ? theme.colorScheme.error : Colors.transparent,
          width: 2.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _isFaultTriggered ? Icons.error_outline : Icons.check_circle_outline,
                color: textColor,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                'SLA Status Monitor',
                style: theme.textTheme.titleMedium?.copyWith(color: textColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Current Availability: ${_uptime.toStringAsFixed(2)}%',
            style: theme.textTheme.bodyLarge?.copyWith(color: textColor),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFaultTriggered ? theme.colorScheme.error : theme.colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: toggleArtificialSlaBreach,
              child: Text(_isFaultTriggered ? 'RESET SLA HEALTH' : 'TRIGGER ARTIFICIAL SLA BREACH'),
            ),
          ),
        ],
      ),
    );
  }
}
