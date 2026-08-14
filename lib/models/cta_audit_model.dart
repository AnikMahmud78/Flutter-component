/// Data model tracking atomic CTA audit metadata fields
class CtaAuditRecord {
  final String auditType;
  final String auditDate;
  final String auditResult;
  final String auditTrail;
  final String auditorInformation;

  CtaAuditRecord({
    required this.auditType,
    required this.auditDate,
    required this.auditResult,
    required this.auditTrail,
    required this.auditorInformation,
  });
}

/// System-Verb CTA Character Limit Rules Engine
class CtaCharacterRules {
  static const int maxCharacterLimit = 20;
  static const int maxWordLimit = 2;

  static bool isWithinCharLimit(String text) =>
      text.length <= maxCharacterLimit;

  static bool isWithinWordLimit(String text) {
    final words = text.trim().split(RegExp(r'\s+|_'));
    return words.length <= maxWordLimit;
  }

  static bool isUppercase(String text) => text == text.toUpperCase();

  static bool isCompliant(String text) =>
      isWithinCharLimit(text) && isWithinWordLimit(text) && isUppercase(text);
}
