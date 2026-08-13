/// Data model tracking private style assets repository telemetry (/styles/typography)
class StyleRepoMetadata {
  final String repositoryUrl;
  final String repositoryBranch;
  final String accessRights;
  final String commitHistory;
  final String repositoryVersion;
  final String cloneStatus;
  final double typographyScaleAdherenceRate; // Target: 1.0 (100%)
  final String completionStatus; // Complete

  StyleRepoMetadata({
    this.repositoryUrl =
        'https://github.com/enterprise/private-styles.git/styles/typography',
    this.repositoryBranch = 'main',
    this.accessRights = 'READ_ONLY_TOKEN_SYNC',
    this.commitHistory = 'a902030 (Task TTIAS-012 Typography Scale Mapping)',
    this.repositoryVersion = 'v3.9.0-MD3-TYPE',
    this.cloneStatus = 'CLONED_AND_VERIFIED',
    this.typographyScaleAdherenceRate = 1.0,
    this.completionStatus = 'Complete',
  });
}
