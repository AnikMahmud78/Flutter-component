// DSDD-006-A03 — Banned Terminology Filter & Template Sanitizer for Master Schema Registry.
// Sanitizes template configurations, types, names, and metadata prior to registry persistence,
// recording execution fidelity in adherence to ISO 9001:2015 Process Conformity Standards.

import 'dart:collection';

/// Quality standard identifier for process execution fidelity tracking.
const String kIso9001StandardRef =
    'ISO 9001:2015 Quality Management System – Process Conformity Standard';

/// Represents the classification/category of schema templates.
enum SchemaTemplateType {
  component,
  form,
  workflow,
  theme,
  custom,
}

/// Sanitization action strategy applied when a banned term is discovered.
enum SanitizationStrategy {
  mask,
  reject,
  redact,
}

/// Input schema template model prior to or following registry sanitization.
class SchemaTemplateItem {
  final String templateName;
  final String templateVersion;
  final SchemaTemplateType templateType;
  final Map<String, dynamic> templateConfiguration;
  final String userId;
  final String? sessionId;

  const SchemaTemplateItem({
    required this.templateName,
    required this.templateVersion,
    required this.templateType,
    required this.templateConfiguration,
    required this.userId,
    this.sessionId,
  });

  SchemaTemplateItem copyWith({
    String? templateName,
    String? templateVersion,
    SchemaTemplateType? templateType,
    Map<String, dynamic>? templateConfiguration,
    String? userId,
    String? sessionId,
  }) {
    return SchemaTemplateItem(
      templateName: templateName ?? this.templateName,
      templateVersion: templateVersion ?? this.templateVersion,
      templateType: templateType ?? this.templateType,
      templateConfiguration:
          templateConfiguration ?? Map.unmodifiable(this.templateConfiguration),
      userId: userId ?? this.userId,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'templateName': templateName,
      'templateVersion': templateVersion,
      'templateType': templateType.name,
      'templateConfiguration': templateConfiguration,
      'userId': userId,
      'sessionId': sessionId,
    };
  }
}

/// Result envelope capturing sanitized template and audit trail metrics.
class SanitizationResult {
  final bool isSuccess;
  final SchemaTemplateItem? sanitizedTemplate;
  final List<String> detectedBannedTerms;
  final String completionStatus;
  final DateTime timestamp;
  final double fidelityRate;
  final String qualityStandardRef;
  final String? rejectionReason;

  const SanitizationResult({
    required this.isSuccess,
    this.sanitizedTemplate,
    required this.detectedBannedTerms,
    required this.completionStatus,
    required this.timestamp,
    required this.fidelityRate,
    this.qualityStandardRef = kIso9001StandardRef,
    this.rejectionReason,
  });

  Map<String, dynamic> toAuditPayload() {
    return {
      'isSuccess': isSuccess,
      'templateName': sanitizedTemplate?.templateName,
      'templateVersion': sanitizedTemplate?.templateVersion,
      'templateType': sanitizedTemplate?.templateType.name,
      'templateConfiguration': sanitizedTemplate?.templateConfiguration,
      'detectedBannedTerms': detectedBannedTerms,
      'completionStatus': completionStatus,
      'actionTimestamp': timestamp.toIso8601String(),
      'userId': sanitizedTemplate?.userId,
      'sessionId': sanitizedTemplate?.sessionId,
      'processExecutionFidelity': fidelityRate,
      'standardReference': qualityStandardRef,
      'rejectionReason': rejectionReason,
    };
  }
}

/// Filter responsible for detecting and eliminating banned terminology prior to registry entry.
class BannedTerminologyFilter {
  final Set<String> _bannedTerms;
  final SanitizationStrategy defaultStrategy;
  final String maskReplacement;

  BannedTerminologyFilter({
    Set<String>? bannedDictionary,
    this.defaultStrategy = SanitizationStrategy.mask,
    this.maskReplacement = '[REDACTED]',
  }) : _bannedTerms = HashSet<String>.from(
          (bannedDictionary ?? _defaultProhibitedVocabulary)
              .map((term) => term.trim().toLowerCase()),
        );

  static const Set<String> _defaultProhibitedVocabulary = {
    'confidential_internal',
    'master_key',
    'raw_password',
    'sudo_override',
    'unverified_eval',
    'bypass_auth',
    'hardcoded_secret',
  };

  /// Register additional prohibited words into the active filtering dictionary.
  void addBannedTerms(Iterable<String> terms) {
    for (final term in terms) {
      if (term.trim().isNotEmpty) {
        _bannedTerms.add(term.trim().toLowerCase());
      }
    }
  }

  /// Examines and sanitizes the [SchemaTemplateItem] before it reaches the registry.
  SanitizationResult sanitizeTemplate(SchemaTemplateItem template) {
    final recordedTimestamp = DateTime.now().toUtc();
    final detectedTerms = <String>[];

    // 1. Validate template name
    final sanitizedName = _sanitizeString(template.templateName, detectedTerms);

    // 2. Reject early if strategy is strict and violations exist in the name
    if (defaultStrategy == SanitizationStrategy.reject && detectedTerms.isNotEmpty) {
      return SanitizationResult(
        isSuccess: false,
        sanitizedTemplate: null,
        detectedBannedTerms: List.unmodifiable(detectedTerms),
        completionStatus: 'Rejected',
        timestamp: recordedTimestamp,
        fidelityRate: 0.0,
        rejectionReason: 'Banned terms detected in template identifier or metadata.',
      );
    }

    // 3. Deep sanitize the template configuration map
    final sanitizedConfig = _sanitizeMap(template.templateConfiguration, detectedTerms);

    if (defaultStrategy == SanitizationStrategy.reject && detectedTerms.isNotEmpty) {
      return SanitizationResult(
        isSuccess: false,
        sanitizedTemplate: null,
        detectedBannedTerms: List.unmodifiable(detectedTerms),
        completionStatus: 'Rejected',
        timestamp: recordedTimestamp,
        fidelityRate: 0.0,
        rejectionReason: 'Banned terms found within template configuration payload.',
      );
    }

    final cleanedItem = template.copyWith(
      templateName: sanitizedName,
      templateConfiguration: sanitizedConfig,
    );

    // Fidelity is 1.0 (100% adherence) when executed to specification
    return SanitizationResult(
      isSuccess: true,
      sanitizedTemplate: cleanedItem,
      detectedBannedTerms: List.unmodifiable(detectedTerms),
      completionStatus: 'Complete',
      timestamp: recordedTimestamp,
      fidelityRate: 1.0,
    );
  }

  String _sanitizeString(String source, List<String> detectedTerms) {
    String processed = source;
    for (final term in _bannedTerms) {
      final regex = RegExp(RegExp.escape(term), caseSensitive: false);
      if (regex.hasMatch(processed)) {
        detectedTerms.add(term);
        if (defaultStrategy == SanitizationStrategy.mask ||
            defaultStrategy == SanitizationStrategy.redact) {
          processed = processed.replaceAll(regex, maskReplacement);
        }
      }
    }
    return processed;
  }

  Map<String, dynamic> _sanitizeMap(
    Map<String, dynamic> map,
    List<String> detectedTerms,
  ) {
    final sanitizedMap = <String, dynamic>{};

    for (final entry in map.entries) {
      final cleanedKey = _sanitizeString(entry.key, detectedTerms);
      final cleanedValue = _sanitizeValue(entry.value, detectedTerms);
      sanitizedMap[cleanedKey] = cleanedValue;
    }

    return sanitizedMap;
  }

  dynamic _sanitizeValue(dynamic value, List<String> detectedTerms) {
    if (value is String) {
      return _sanitizeString(value, detectedTerms);
    } else if (value is Map<String, dynamic>) {
      return _sanitizeMap(value, detectedTerms);
    } else if (value is List) {
      return value.map((item) => _sanitizeValue(item, detectedTerms)).toList();
    }
    return value;
  }
}
