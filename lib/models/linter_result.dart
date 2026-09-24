class LinterResult {
  final int filesScanned;
  final int violationsCount;
  final bool isPassed;

  LinterResult({required this.filesScanned, required this.violationsCount, required this.isPassed});
}
