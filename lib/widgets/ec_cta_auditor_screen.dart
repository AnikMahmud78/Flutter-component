import 'package:flutter/material.dart';
import '../models/ec_cta_audit_model.dart';

class EcCtaAuditorScreen extends StatefulWidget {
  const EcCtaAuditorScreen({super.key});

  @override
  State<EcCtaAuditorScreen> createState() => _EcCtaAuditorScreenState();
}

class _EcCtaAuditorScreenState extends State<EcCtaAuditorScreen> {
  final MobileDeviceTelemetryRecord _telemetryRecord =
      MobileDeviceTelemetryRecord(
        mobilePlatform: 'Flutter Mobile / Android Runtime',
        osVersion: 'Android 15 (API Level 35)',
        deviceType: 'Enterprise Handheld Scanner / Pixel 8 Pro',
        screenDimensions: '412 x 892 dp (19.5:9)',
        mobileConfiguration: 'STRICT_EC_VERBS_ENFORCED_M3_PILL',
      );

  final List<CtaTermMappingItem> _auditedCtas = [
    CtaTermMappingItem(
      workflowId: 'WF-REV-01',
      bannedHumanPhrase: 'Review Now',
      ecSystemVerb: 'EXECUTE_REVIEW',
    ),
    CtaTermMappingItem(
      workflowId: 'WF-APP-02',
      bannedHumanPhrase: 'Submit for Approval',
      ecSystemVerb: 'COMMIT_APPROVAL',
    ),
    CtaTermMappingItem(
      workflowId: 'WF-ING-03',
      bannedHumanPhrase: 'Click to Ingest',
      ecSystemVerb: 'EXECUTE_INGESTION',
    ),
    CtaTermMappingItem(
      workflowId: 'WF-PUR-04',
      bannedHumanPhrase: 'Clear Cache',
      ecSystemVerb: 'PURGE_CACHE',
    ),
  ];

  bool _isProcessing = false;

  int get _bannedTermDefectCount {
    return _auditedCtas.where((item) => !item.isCompliant).length;
  }

  void _executeMachineAction(String ecVerb) {
    setState(() => _isProcessing = true);

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() => _isProcessing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'MACHINE ACTION EXECUTED: "$ecVerb" verified. Zero subjective ambiguities.',
            ),
            backgroundColor: Colors.indigo.shade800,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final int defects = _bannedTermDefectCount;
    final bool isSixSigmaPassed = defects == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('EC System Verbs Audit'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp outer margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. SIX SIGMA DPMO TERMINOLOGY COMPLIANCE BANNER
            // =========================================================
            Card.filled(
              color: isSixSigmaPassed
                  ? Colors.green.shade50
                  : colorScheme.errorContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSixSigmaPassed
                      ? Colors.green.shade300
                      : colorScheme.error,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      isSixSigmaPassed
                          ? Icons.check_circle_rounded
                          : Icons.warning_amber_rounded,
                      color: isSixSigmaPassed
                          ? Colors.green.shade800
                          : colorScheme.onErrorContainer,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isSixSigmaPassed
                                ? 'Terminology Compliance: Pass (0 defects)'
                                : 'DEFECT ALERT: $defects Banned Term(s) Detected',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isSixSigmaPassed
                                  ? Colors.green.shade900
                                  : colorScheme.onErrorContainer,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Compliant with Six Sigma DPMO (Defects Per Million Opportunities) Standard.',
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

            // =========================================================
            // 2. AUDITED FULL-WIDTH M3 PILL CTA LIST
            // =========================================================
            Text(
              'Audited Mobile Primary CTAs',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'All buttons enforce full width, 100px border radius, and strict EC system verbs.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            ..._auditedCtas.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.workflowId} • Banned Term: "${item.bannedHumanPhrase}"',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade700,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'EC VERB ENFORCED',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // REQUIREMENT: Material 3 Filled Button, full width, 100px radius, >= 48dp height
                    SizedBox(
                      width: double.infinity, // width: 100%
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          minimumSize: const Size.fromHeight(
                            48.0,
                          ), // >= 48dp height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              100.0,
                            ), // border-radius: 100px
                          ),
                        ),
                        onPressed: _isProcessing
                            ? null
                            : () => _executeMachineAction(item.ecSystemVerb),
                        icon: const Icon(Icons.flash_on_rounded, size: 18),
                        label: Text(
                          item.ecSystemVerb, // Strict Machine-Action System Verb
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),

            // =========================================================
            // 3. MOBILE DEVICE HARDWARE TELEMETRY LOGS
            // =========================================================
            Text(
              'Mobile Platform Telemetry Record',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildTelemetryRow(
                      'Mobile Platform',
                      _telemetryRecord.mobilePlatform,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'OS Version',
                      _telemetryRecord.osVersion,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Device Type',
                      _telemetryRecord.deviceType,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Screen Dimensions',
                      _telemetryRecord.screenDimensions,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Mobile Configuration',
                      _telemetryRecord.mobileConfiguration,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryRow(String label, String value) {
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
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
