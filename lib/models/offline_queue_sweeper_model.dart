// lib/models/offline_queue_sweeper_model.dart
// Task GEN-00348: Build the background sync worker OfflineQueueSweeper inside @gacl/offline-storage.

class OfflineQueueSweeperModel {
  final String workerName;
  final int sweptItemsCount;
  final double syncSuccessRate;
  final String reliabilityStandard;
  final String timestamp;

  const OfflineQueueSweeperModel({
    required this.workerName,
    required this.sweptItemsCount,
    required this.syncSuccessRate,
    required this.reliabilityStandard,
    required this.timestamp,
  });
}
