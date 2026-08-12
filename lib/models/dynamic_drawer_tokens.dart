/// Data model tracking shared design system library directory metadata & tokens
class DynamicDrawerTokens {
  final String directoryPath;
  final String directoryContents;
  final String accessPermissions;
  final String lastModifiedDate;
  final String systemName;
  final String systemVersion;
  final List<String> componentList;
  final Map<String, dynamic> tokenValues;
  final String documentationLinks;
  final String systemConfigurationDetails;

  DynamicDrawerTokens({
    this.directoryPath = 'lib/widgets/dynamic_contextual_drawer.dart',
    this.directoryContents =
        'DynamicContextualDrawer Widget, Gestural Controllers, Scrim Handlers',
    this.accessPermissions = 'READ_WRITE_VERSION_CONTROLLED',
    this.lastModifiedDate = '2026-08-12T17:47:00Z',
    this.systemName = 'Shared Design System Library',
    this.systemVersion = 'v3.2.0-MD3',
    this.componentList = const [
      'DynamicContextualDrawer',
      'SideSheetResponsiveWrapper',
      'ElevationMatrixTokens',
    ],
    this.tokenValues = const {
      'elevationToken': 8.0,
      'topCornerRadiusDp': 28.0,
      'minTouchTargetDp': 48.0,
      'scrimAlphaToken': 0.54,
      'anchorHeights': [0.25, 0.50, 0.90],
    },
    this.documentationLinks =
        'https://design.internal.net/components/dynamic-drawer',
    this.systemConfigurationDetails =
        'MD3 Responsive Layout Engine: Mobile Bottom Sheet / Desktop Side Sheet Switcher',
  });
}
