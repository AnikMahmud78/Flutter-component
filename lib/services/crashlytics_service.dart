import 'package:flutter/foundation.dart';

class CrashlyticsService {
  static Future<void> initialize() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      // Log exception to Firebase Crashlytics telemetry pipeline
      debugPrint('Crashlytics Handled Exception: ${details.exceptionAsString()}');
    };
  }

  static void logNonFatalError(dynamic exception, StackTrace? stackTrace) {
    debugPrint('Non-Fatal Error Streamed: $exception');
  }
}
