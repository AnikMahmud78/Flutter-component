import 'dart:async';
import 'dart:math';
import '../models/liveness_service_model.dart';

/// Client-side service executing automated 30-second health check polling
class HealthPollingService {
  Timer? _pollingTimer;
  Timer? _countdownTimer;

  int _secondsUntilNextPoll = 30;
  final Random _random = Random();

  final List<LivenessServiceNode> _nodes = [
    LivenessServiceNode(
      id: 'SVC-AUTH',
      name: 'Authentication & IAM Service',
      endpointUrl: 'https://auth.internal.net/health',
      lastChecked: DateTime.now(),
    ),
    LivenessServiceNode(
      id: 'SVC-PAYMENT',
      name: 'Payment Processing Gateway',
      endpointUrl: 'https://pay.internal.net/health',
      lastChecked: DateTime.now(),
    ),
    LivenessServiceNode(
      id: 'SVC-INGRESS',
      name: 'Analytics Stream Ingress',
      endpointUrl: 'https://ingress.internal.net/health',
      lastChecked: DateTime.now(),
    ),
    LivenessServiceNode(
      id: 'SVC-NOTIF',
      name: 'Notification Push Engine',
      endpointUrl: 'https://push.internal.net/health',
      lastChecked: DateTime.now(),
    ),
  ];

  List<LivenessServiceNode> get nodes => _nodes;
  int get secondsUntilNextPoll => _secondsUntilNextPoll;

  // Start automated 30-second polling cycle
  void startPolling({required Function() onUpdate}) {
    _stopTimers();

    // 1-second interval timer for countdown UI
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsUntilNextPoll > 1) {
        _secondsUntilNextPoll--;
      } else {
        _secondsUntilNextPoll = 30;
        _executeHealthChecks();
      }
      onUpdate();
    });

    // Execute initial check immediately
    _executeHealthChecks();
    onUpdate();
  }

  void _executeHealthChecks() {
    for (var node in _nodes) {
      node.lastChecked = DateTime.now();

      // Simulate network health status evaluation
      final randVal = _random.nextDouble();
      if (randVal > 0.85) {
        node.status = HealthStatus.failed;
        node.latencyMs = 0;
      } else if (randVal > 0.70) {
        node.status = HealthStatus.degraded;
        node.latencyMs = 280 + _random.nextInt(200);
      } else {
        node.status = HealthStatus.healthy;
        node.latencyMs = 20 + _random.nextInt(60);
      }
    }
  }

  // Self-Healing Handshake Action
  Future<bool> executeSelfHealing(String nodeId) async {
    final index = _nodes.indexWhere((n) => n.id == nodeId);
    if (index == -1) return false;

    // Simulate endpoint re-handshake / failover reset delay
    await Future.delayed(const Duration(milliseconds: 600));

    _nodes[index].status = HealthStatus.healthy;
    _nodes[index].latencyMs = 35;
    _nodes[index].lastChecked = DateTime.now();
    _nodes[index].selfHealingCount++;
    return true;
  }

  void _stopTimers() {
    _pollingTimer?.cancel();
    _countdownTimer?.cancel();
  }

  void dispose() {
    _stopTimers();
  }
}
