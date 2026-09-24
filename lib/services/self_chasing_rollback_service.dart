import 'package:flutter/foundation.dart';

class SelfChasingRollbackService {
  static String? _lastKnownGoodConfig = 'CONFIG_V1_STABLE';
  static String _activeConfig = 'CONFIG_V2_PENDING';

  static Future<bool> handleApiResponse(int statusCode) async {
    if (statusCode == 500) {
      debugPrint('HTTP 500 Detected! Triggering Self-Chasing Reversion...');
      _activeConfig = _lastKnownGoodConfig ?? 'CONFIG_SAFE_FALLBACK';
      await Future.delayed(const Duration(milliseconds: 80));
      debugPrint('Configuration safely reverted to: $_activeConfig');
      return true;
    }
    return false;
  }
}
