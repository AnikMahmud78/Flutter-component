class SemanticNodeData {
  final int index;
  final String label;
  final String hint;
  final bool isHeader;

  SemanticNodeData({
    required this.index,
    required this.label,
    required this.hint,
    this.isHeader = false,
  });
}
