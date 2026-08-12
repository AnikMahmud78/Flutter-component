import 'package:flutter/material.dart';
import '../models/security_rate_limit_model.dart';

class SecurityDashboardWidget extends StatefulWidget {
  const SecurityDashboardWidget({super.key});

  @override
  State<SecurityDashboardWidget> createState() =>
      _SecurityDashboardWidgetState();
}

class _SecurityDashboardWidgetState extends State<SecurityDashboardWidget> {
  late Stopwatch _stopwatch;
  RailLoadPerformance? _railPerformance;
  bool _isLoading = true;

  // Sample API Endpoint Throttling Telemetry
  final List<BlockedEndpointMetric> _endpointMetrics = [
    BlockedEndpointMetric(
      endpointPath: '/api/v1/auth/login',
      totalRequests: 14200,
      blockedRequests: 1240,
      rateLimitThreshold: 100,
    ),
    BlockedEndpointMetric(
      endpointPath: '/api/v1/checkout/pay',
      totalRequests: 8900,
      blockedRequests: 310,
      rateLimitThreshold: 50,
    ),
    BlockedEndpointMetric(
      endpointPath: '/api/v1/telemetry/stream',
      totalRequests: 45000,
      blockedRequests: 4120,
      rateLimitThreshold: 500,
    ),
  ];

  // Sample Blocked Source IP Telemetry
  final List<BlockedIpMetric> _ipMetrics = [
    BlockedIpMetric(
      ipAddress: '198.51.100.42',
      locationRegion: 'US-East (Botnet Cluster)',
      blockedCount: 2840,
      threatLevel: 'HIGH',
    ),
    BlockedIpMetric(
      ipAddress: '203.0.113.195',
      locationRegion: 'EU-Central (Credential Stuffing)',
      blockedCount: 1150,
      threatLevel: 'HIGH',
    ),
    BlockedIpMetric(
      ipAddress: '192.0.2.88',
      locationRegion: 'AP-South (Rate Limit Burst)',
      blockedCount: 420,
      threatLevel: 'MEDIUM',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();

    // Simulate Cloud Monitoring Dashboard Load (< 2.0s RAIL Target)
    Future.delayed(const Duration(milliseconds: 380), () {
      _stopwatch.stop();
      if (mounted) {
        setState(() {
          _railPerformance = RailLoadPerformance(
            loadTimeSeconds: _stopwatch.elapsedMilliseconds / 1000.0,
          );
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Gateway Threat Protection'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text(
                    'Measuring Dashboard Load Time (Google RAIL Standard)...',
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0), // 16px Grid Margins
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =========================================================
                  // 1. GOOGLE RAIL PERFORMANCE METRIC CARD
                  // =========================================================
                  Card.filled(
                    color: Colors.blueGrey.shade900,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dashboard Load Performance',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Google RAIL Load Standard',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  _railPerformance?.performanceRating == 'Good'
                                  ? Colors.green.shade800
                                  : Colors.orange.shade800,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.speed,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${_railPerformance?.loadTimeSeconds.toStringAsFixed(3)}s (${_railPerformance?.performanceRating})',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =========================================================
                  // 2. BLOCKED REQUEST RATES PER ENDPOINT
                  // =========================================================
                  Text(
                    'Throttled Requests per API Endpoint',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  ..._endpointMetrics.map((ep) {
                    return Card.outlined(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ep.endpointPath,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                    fontSize: 13,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.errorContainer,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${ep.blockedRequests} Blocked (${ep.blockPercentage}%)',
                                    style: TextStyle(
                                      color: colorScheme.onErrorContainer,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            LinearProgressIndicator(
                              value: ep.blockRateRatio,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.error,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Requests: ${ep.totalRequests}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  'Rate Ceiling: ${ep.rateLimitThreshold} req/min',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // =========================================================
                  // 3. BLOCKED REQUEST RATES PER SOURCE IP
                  // =========================================================
                  Text(
                    'Top Blocked Source IP Addresses',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Card.outlined(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _ipMetrics.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final ip = _ipMetrics[index];
                        final isHighThreat = ip.threatLevel == 'HIGH';

                        return ListTile(
                          dense: true,
                          leading: CircleAvatar(
                            backgroundColor: isHighThreat
                                ? colorScheme.errorContainer
                                : Colors.amber.shade100,
                            child: Icon(
                              isHighThreat ? Icons.gpp_bad : Icons.shield,
                              color: isHighThreat
                                  ? colorScheme.error
                                  : Colors.amber.shade900,
                              size: 18,
                            ),
                          ),
                          title: Text(
                            ip.ipAddress,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              fontSize: 13,
                            ),
                          ),
                          subtitle: Text(
                            ip.locationRegion,
                            style: const TextStyle(fontSize: 11),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${ip.blockedCount} Blocked',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isHighThreat
                                      ? colorScheme.error
                                      : Colors.black87,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Threat: ${ip.threatLevel}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isHighThreat
                                      ? colorScheme.error
                                      : Colors.amber.shade900,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
