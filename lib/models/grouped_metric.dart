class GroupedMetric {
  final String title;
  final String value;
  final String unit;
  final String status; // 'Real-time', 'Near Real-time', 'Delayed'

  GroupedMetric({
    required this.title,
    required this.value,
    required this.unit,
    required this.status,
  });
}
