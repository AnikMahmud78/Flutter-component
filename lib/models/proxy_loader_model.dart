/// Data model tracking UI Component Library proxy loader metadata & task expiration state
class ProxyLoaderModel {
  final String libraryName;
  final String libraryVersion;
  final int componentCount;
  final String installationStatus;
  final List<String> dependencyList;
  final String libraryLocationPath;

  bool isTaskExpired;
  bool isEscalationDispatched;

  ProxyLoaderModel({
    this.libraryName = 'OptimizedImageProxyLoader',
    this.libraryVersion = 'v2.8.4-CDN-PROXY',
    this.componentCount = 14,
    this.installationStatus = 'INSTALLED_AND_VERIFIED',
    this.dependencyList = const [
      'flutter_cache_manager',
      'cdn_image_proxy_core',
      'async_timing_engine',
    ],
    this.libraryLocationPath = 'packages/proxies/OptimizedImageProxyLoader',
    this.isTaskExpired = false,
    this.isEscalationDispatched = false,
  });
}
