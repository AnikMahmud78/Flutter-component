// Location: lib/utils/null_handler_util.dart

/// Unified string evaluation utility providing safe fallback defaults
class NullHandlerUtil {
  static final List<String> fallbackTrackingLog = [];

  /// Evaluates nullable string and returns a fallback string if null or empty
  static String safeString(
    String? input, {
    String fallback = '[UNSPECIFIED_VALUE]',
    required String fieldKey,
  }) {
    if (input == null || input.trim().isEmpty) {
      _trackFallback(fieldKey, fallback);
      return fallback;
    }
    return input.trim();
  }

  /// Safely formats nullable numeric values, preventing arithmetic exceptions
  static String safeCurrency(
    double? amount, {
    String symbol = '\$',
    double fallback = 0.00,
    required String fieldKey,
  }) {
    if (amount == null || amount.isNaN || amount.isInfinite) {
      _trackFallback(fieldKey, '$symbol${fallback.toStringAsFixed(2)}');
      return '$symbol${fallback.toStringAsFixed(2)}';
    }
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  /// Safely parses division ratios without throwing DivisionByZero exceptions
  static double safeDivide(
    double? numerator,
    double? denominator, {
    double fallback = 0.0,
  }) {
    if (numerator == null ||
        denominator == null ||
        denominator == 0.0 ||
        denominator.isNaN) {
      return fallback;
    }
    return numerator / denominator;
  }

  static void _trackFallback(String fieldKey, String valueApplied) {
    final timestamp = DateTime.now().toUtc().toIso8601String().substring(
      11,
      19,
    );
    fallbackTrackingLog.insert(
      0,
      '[$timestamp] FIELD_FALLBACK: "$fieldKey" assigned fallback "$valueApplied"',
    );
    if (fallbackTrackingLog.length > 20) {
      fallbackTrackingLog.removeLast();
    }
  }
}
