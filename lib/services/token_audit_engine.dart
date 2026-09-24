class TokenAuditEngine {
  double auditSourceCode(List<String> codeLines) {
    if (codeLines.isEmpty) return 1.0;
    int totalStyles = 0;
    int tokenizedStyles = 0;

    for (var line in codeLines) {
      if (line.contains('color:') || line.contains('padding:')) {
        totalStyles++;
        if (line.contains('md.sys.color') || line.contains('Spacing.')) {
          tokenizedStyles++;
        }
      }
    }

    return totalStyles == 0 ? 1.0 : tokenizedStyles / totalStyles;
  }
}
