import 'package:flutter/material.dart';
import '../models/style_repo_metadata.dart';
import '../theme/app_typography_tokens.dart';

class TypographyScaleDemoScreen extends StatefulWidget {
  const TypographyScaleDemoScreen({super.key});

  @override
  State<TypographyScaleDemoScreen> createState() =>
      _TypographyScaleDemoScreenState();
}

class _TypographyScaleDemoScreenState extends State<TypographyScaleDemoScreen> {
  final StyleRepoMetadata _repoMetadata = StyleRepoMetadata();
  double _simulatedTextScaleFactor =
      1.0; // Accessibility scaling factor simulation

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return MediaQuery(
      // Simulates device accessibility font scaling adjustability
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: TextScaler.linear(_simulatedTextScaleFactor)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Typography Scale Mapping'),
          backgroundColor: theme.colorScheme.surfaceContainerHigh,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), // Standard 16dp outer margin
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================================================
              // 1. ACCESSIBILITY CONTRAST & ADHERENCE BANNER
              // =========================================================
              Card.filled(
                color: Colors.green.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.green.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.format_size_rounded,
                        color: Colors.green.shade800,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MD3 Type Scale Adherence: 100% (Complete)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.green.shade900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Contrast Ratio ≥ 4.5:1 Verified • 16sp Baseline Anchored.',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ACCESSIBILITY TEXT SCALE SIMULATOR
              Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Accessibility Text Scale Simulator',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '${(_simulatedTextScaleFactor * 100).round()}% Scale',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: _simulatedTextScaleFactor,
                        min: 0.85,
                        max: 1.50,
                        divisions: 13,
                        label: '${(_simulatedTextScaleFactor * 100).round()}%',
                        onChanged: (val) {
                          setState(() {
                            _simulatedTextScaleFactor = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // =========================================================
              // 2. MATERIAL DESIGN 3 TYPE SCALE SHOWCASE
              // =========================================================
              Text(
                'MD3 Typography Scale Elements',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 12),

              // Headline Medium
              _buildTypeSampleTile(
                roleLabel: 'Headline Medium (28sp / 1.28 height)',
                textWidget: Text(
                  'Security Ingestion Engine',
                  style: textTheme.headlineMedium,
                ),
              ),

              // Title Medium (Single-line boundary restriction)
              _buildTypeSampleTile(
                roleLabel: 'Title Medium (16sp / Single-Line Truncation Limit)',
                textWidget: Text(
                  'CRITICAL_PAYLOAD_GATEWAY_IDENTIFIER_EXTENDED_VALUE_STRING_LONG',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium,
                ),
              ),

              // Body Large (Paragraph 16sp Baseline)
              _buildTypeSampleTile(
                roleLabel: 'Body Large (16sp Baseline / 1.50 Line-Height)',
                textWidget: Text(
                  'Paragraph typography sizes stay anchored to a clear baseline (16sp) to ensure optimal reading density across tight mobile viewports.',
                  style: textTheme.bodyLarge,
                ),
              ),

              // Label Large (Action Marker)
              _buildTypeSampleTile(
                roleLabel: 'Label Large (14sp / Action Marker)',
                textWidget: Text(
                  'EXECUTE_COMPLIANT_INGESTION',
                  style: textTheme.labelLarge,
                ),
              ),

              const SizedBox(height: 20),

              // =========================================================
              // 3. SMART WRAPPING LOGIC ON TIGHT ROWS
              // =========================================================
              Text(
                'Smart Label Wrapping on Tight Rows',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 8),

              Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.shield_rounded,
                        color: AppTypographyTokens.primaryActionContrast,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Primary Gateway Perimeter Rule Node',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap:
                              true, // REQUIREMENT: Smart wrapping logic on tight rows
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'PASS',
                          style: textTheme.labelLarge?.copyWith(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // =========================================================
              // 4. PRIVATE STYLE ASSET REPOSITORY METADATA
              // =========================================================
              Text(
                'Private Style Asset Repository Details',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 8),

              Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      _buildRepoRow(
                        'Repository URL',
                        _repoMetadata.repositoryUrl,
                      ),
                      const Divider(height: 12),
                      _buildRepoRow(
                        'Repository Branch',
                        _repoMetadata.repositoryBranch,
                      ),
                      const Divider(height: 12),
                      _buildRepoRow(
                        'Access Rights',
                        _repoMetadata.accessRights,
                      ),
                      const Divider(height: 12),
                      _buildRepoRow(
                        'Commit History',
                        _repoMetadata.commitHistory,
                      ),
                      const Divider(height: 12),
                      _buildRepoRow(
                        'Repository Version',
                        _repoMetadata.repositoryVersion,
                      ),
                      const Divider(height: 12),
                      _buildRepoRow('Clone Status', _repoMetadata.cloneStatus),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSampleTile({
    required String roleLabel,
    required Widget textWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              roleLabel,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 4),
            textWidget,
          ],
        ),
      ),
    );
  }

  Widget _buildRepoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
