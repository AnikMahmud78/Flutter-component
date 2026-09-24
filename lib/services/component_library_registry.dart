class ComponentLibraryRegistry {
  static final Set<String> _registeredByts = {};

  static void registerByt(String bytName) {
    _registeredByts.add(bytName);
  }

  static bool isBytRegistered(String bytName) {
    return _registeredByts.contains(bytName);
  }
}
