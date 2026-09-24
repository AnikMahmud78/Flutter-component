enum NetworkHealthState { connected, partialRecovery, disconnected }

class ConnectionStatePayload {
  final NetworkHealthState state;
  final int retryCount;

  ConnectionStatePayload({required this.state, required this.retryCount});
}
