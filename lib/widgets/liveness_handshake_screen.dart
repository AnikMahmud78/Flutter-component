import 'package:flutter/material.dart';
import '../models/liveness_service_model.dart';
import '../services/health_polling_service.dart';

class LivenessHandshakeScreen extends StatefulWidget {
  const LivenessHandshakeScreen({super.key});

  @override
  State<LivenessHandshakeScreen> createState() =>
      _LivenessHandshakeScreenState();
}

class _LivenessHandshakeScreenState extends State<LivenessHandshakeScreen> {
  final HealthPollingService _pollingService = HealthPollingService();
  bool _isHealingInProgress = false;

  @override
  void initState() {
    super.initState();
    _pollingService.startPolling(
      onUpdate: () {
        if (mounted) setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _pollingService.dispose();
    super.dispose();
  }

  void _triggerSelfHealing(String nodeId, String nodeName) async {
    setState(() => _isHealingInProgress = true);

    final success = await _pollingService.executeSelfHealing(nodeId);

    if (mounted) {
      setState(() => _isHealingInProgress = false);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Self-Healing Handshake Success: $nodeName recovered.',
            ),
            backgroundColor: Colors.teal.shade800,
          ),
        );
      }
    }
  }

  Color _getStatusColor(HealthStatus status, ColorScheme colorScheme) {
    switch (status) {
      case HealthStatus.healthy:
        return Colors.green.shade700;
      case HealthStatus.degraded:
        return Colors.amber.shade900;
      case HealthStatus.failed:
        return colorScheme.error;
    }
  }

  String _getStatusText(HealthStatus status) {
    switch (status) {
      case HealthStatus.healthy:
        return '200 OK (Healthy)';
      case HealthStatus.degraded:
        return 'High Latency (Degraded)';
      case HealthStatus.failed:
        return 'Connection Failed (503)';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final nodes = _pollingService.nodes;
    final secondsRemaining = _pollingService.secondsUntilNextPoll;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liveness Handshake Monitor'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // 16px Grid Margins
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. 30-SECOND POLLING COUNTDOWN BANNER
            // =========================================================
            Card.filled(
              color: Colors.teal.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.teal.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.sync, color: Colors.teal.shade800),
                            const SizedBox(width: 8),
                            Text(
                              '30s Client Polling Loop Active',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.teal.shade900,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Next poll in ${secondsRemaining}s',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.teal.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: (30 - secondsRemaining) / 30.0,
                      backgroundColor: Colors.teal.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.teal.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 2. MONITORED INFRASTRUCTURE ENDPOINTS
            // =========================================================
            Text(
              'Infrastructure Endpoint Health State',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            ...nodes.map((node) {
              final statusColor = _getStatusColor(node.status, colorScheme);

              return Card.outlined(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              node.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: statusColor),
                            ),
                            child: Text(
                              _getStatusText(node.status),
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        node.endpointUrl,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Latency: ${node.latencyMs > 0 ? "${node.latencyMs}ms" : "N/A"}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            'Self-Healed: ${node.selfHealingCount} times',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),

                      // SELF-HEALING ACTION BUTTON IF FAILED OR DEGRADED (>=48px Touch Target)
                      if (node.status != HealthStatus.healthy) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 48, // Minimum 48px Touch Target
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: node.isFailed
                                  ? colorScheme.error
                                  : Colors.amber.shade900,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _isHealingInProgress
                                ? null
                                : () => _triggerSelfHealing(node.id, node.name),
                            icon: const Icon(Icons.healing_rounded),
                            label: const Text(
                              'Trigger Self-Healing Handshake',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
