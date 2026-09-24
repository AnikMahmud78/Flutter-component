class PackageCommitManifest {
  final String componentName;
  final String libraryTarget;
  final String versionTag;
  final bool isCommitted;

  PackageCommitManifest({
    required this.componentName,
    required this.libraryTarget,
    required this.versionTag,
    required this.isCommitted,
  });
}
