class ErrorMappingRegistry {
  static final Map<String, String> _errorBytMap = {
    'ERR_NET_429': 'RateLimitBannerByt',
    'ERR_AUTH_401': 'SessionExpiredByt',
    'ERR_DOC_MISSING': 'DocumentCheckmarkByt',
  };

  static String resolveBytForError(String errorCode) {
    return _errorBytMap[errorCode] ?? 'GenericErrorByt';
  }
}
