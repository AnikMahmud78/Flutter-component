import 'dart:async';

class HeaderInjector {
  final String authToken;
  final String appVersion;

  HeaderInjector({required this.authToken, this.appVersion = '2.24.7'});

  Map<String, String> injectHeaders(Map<String, String> originalHeaders, String traceId) {
    final Map<String, String> updatedHeaders = Map.from(originalHeaders);
    updatedHeaders['Authorization'] = 'Bearer \$authToken';
    updatedHeaders['X-Trace-ID'] = traceId;
    updatedHeaders['X-App-Version'] = appVersion;
    updatedHeaders['X-Client-Platform'] = 'HABOT-Mobile-Flutter';
    updatedHeaders['Content-Type'] = 'application/json';
    return updatedHeaders;
  }
}
