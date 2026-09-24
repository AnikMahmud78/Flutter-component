class CountdownModel {
  final int totalSeconds;
  final int remainingSeconds;
  final bool isExpired;

  CountdownModel({
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.isExpired,
  });

  String get formattedTime {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
