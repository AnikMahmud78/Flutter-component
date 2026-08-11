import 'package:flutter/material.dart';
import '../utils/circuit_breaker.dart';

class CircuitBreakerDemo extends StatefulWidget {
  const CircuitBreakerDemo({super.key});

  @override
  State<CircuitBreakerDemo> createState() => _CircuitBreakerDemoState();
}

class _CircuitBreakerDemoState extends State<CircuitBreakerDemo> {
  final CircuitBreaker _breaker = CircuitBreaker(
    failureThreshold: 3,
    resetTimeout: const Duration(seconds: 5),
  );

  bool _isBackendHealthy = true;
  bool _isLoading = false;
  String _responseMessage = 'System Ready - Perform request simulation.';
  bool _isFallbackActive = false;

  // Simulated backend endpoint call
  Future<String> _simulatedBackendRequest() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (!_isBackendHealthy) {
      throw Exception('500 Internal Server Error: Service Deployment Failure');
    }
    return '200 OK: Benefits Enrollment Payload Received Successfully';
  }

  Future<void> _makeRequest() async {
    setState(() {
      _isLoading = true;
      _isFallbackActive = false;
    });

    final result = await _breaker.execute<String>(
      action: _simulatedBackendRequest,
      fallback: () {
        _isFallbackActive = true;
        return 'FALLBACK ACTIVE: Backend deployment unavailable. Displaying cached emergency enrollment state.';
      },
    );

    if (mounted) {
      setState(() {
        _responseMessage = result;
        _isLoading = false;
      });
    }
  }

  Color _getCircuitStateColor(CircuitState state) {
    switch (state) {
      case CircuitState.closed:
        return Colors.green.shade700;
      case CircuitState.open:
        return Colors.red.shade700;
      case CircuitState.halfOpen:
        return Colors.orange.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentState = _breaker.state;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- CIRCUIT BREAKER MONITORING CARD ---
          Card(
            color: Colors.blueGrey.shade900,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Istio Circuit Breaker Status:',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getCircuitStateColor(currentState),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          currentState.name.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Consecutive Failures: ${_breaker.failureCount} / 3',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(() => _breaker.reset()),
                        child: const Text(
                          'Reset Circuit',
                          style: TextStyle(color: Colors.cyanAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- SIMULATED BACKEND HEALTH CONTROLS ---
          const Text(
            'Backend Deployment Health Simulator',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text('Backend Healthy (200 OK)'),
                  selected: _isBackendHealthy,
                  selectedColor: Colors.green.shade100,
                  onSelected: (val) => setState(() => _isBackendHealthy = true),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ChoiceChip(
                  label: const Text('Simulate Outage (500 Error)'),
                  selected: !_isBackendHealthy,
                  selectedColor: Colors.red.shade100,
                  onSelected: (val) =>
                      setState(() => _isBackendHealthy = false),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // --- TRIGGER ACTION BUTTON ---
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
              ),
              onPressed: _isLoading ? null : _makeRequest,
              icon: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.send_rounded),
              label: Text(
                _isLoading ? 'Evaluating Request...' : 'Trigger API Request',
              ),
            ),
          ),

          const SizedBox(height: 24),

          // --- RESPONSE DISPLAY / EMERGENCY FALLBACK BANNER ---
          if (_isFallbackActive) ...[
            // ACTIONABLE FALLBACK ALERT BANNER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade400, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shield_rounded,
                    color: Colors.red.shade800,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Circuit Breaker Tripped (Open State)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Failing requests bypass network to protect mobile app from hanging or crashing.',
                          style: TextStyle(
                            color: Colors.red.shade800,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payload Status Stream:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  _responseMessage,
                  style: TextStyle(
                    color: _isFallbackActive
                        ? Colors.red.shade800
                        : Colors.black87,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
