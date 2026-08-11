import 'dart:async';

enum CircuitState { closed, open, halfOpen }

/// Circuit Breaker resilience utility to prevent mobile app hangs and crashes
class CircuitBreaker {
  final int failureThreshold;
  final Duration resetTimeout;

  CircuitState _state = CircuitState.closed;
  int _failureCount = 0;
  DateTime? _lastStateChangeTime;

  CircuitBreaker({
    this.failureThreshold = 3,
    this.resetTimeout = const Duration(seconds: 5),
  });

  CircuitState get state {
    // Check if open state has passed reset timeout -> Transition to Half-Open
    if (_state == CircuitState.open && _lastStateChangeTime != null) {
      if (DateTime.now().difference(_lastStateChangeTime!) > resetTimeout) {
        _state = CircuitState.halfOpen;
        _lastStateChangeTime = DateTime.now();
      }
    }
    return _state;
  }

  int get failureCount => _failureCount;

  /// Executes a request protected by the Circuit Breaker pattern
  Future<T> execute<T>({
    required Future<T> Function() action,
    required T Function() fallback,
  }) async {
    final currentState = state;

    // REQUIREMENT: Open State -> Fail fast immediately, serve fallback UI without network wait
    if (currentState == CircuitState.open) {
      return fallback();
    }

    try {
      final result = await action();
      _onSuccess();
      return result;
    } catch (e) {
      _onFailure();
      return fallback();
    }
  }

  void _onSuccess() {
    _failureCount = 0;
    _state = CircuitState.closed;
    _lastStateChangeTime = DateTime.now();
  }

  void _onFailure() {
    _failureCount++;
    if (_failureCount >= failureThreshold || _state == CircuitState.halfOpen) {
      _state = CircuitState.open;
      _lastStateChangeTime = DateTime.now();
    }
  }

  void reset() {
    _failureCount = 0;
    _state = CircuitState.closed;
    _lastStateChangeTime = DateTime.now();
  }
}
