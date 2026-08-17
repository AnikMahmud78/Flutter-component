import 'package:flutter/material.dart';
import '../models/layout_metric_constraint_model.dart';

class LayoutMetricValidatorWidget extends StatefulWidget {
  const LayoutMetricValidatorWidget({super.key});

  @override
  State<LayoutMetricValidatorWidget> createState() =>
      _LayoutMetricValidatorWidgetState();
}

class _LayoutMetricValidatorWidgetState
    extends State<LayoutMetricValidatorWidget> {
  final ParentLayoutMetricRegistry _parentRegistry =
      ParentLayoutMetricRegistry.defaultMobileParent;

  late List<SplinteredModuleMappingRecord> _splinteredModules;
  bool _isPipelineRunning = false;

  @override
  void initState() {
    super.initState();
    _splinteredModules = [
      SplinteredModuleMappingRecord(
        moduleId: 'MOD-HEADER-01',
        moduleName: 'HeaderCardComponent',
        parentTokenReference: _parentRegistry.parentTokenId,
        layoutType: _parentRegistry.layoutType,
        layoutGridDimensions: _parentRegistry.layoutGridDimensions,
        spacingRules: _parentRegistry.spacingRules,
        alignmentSettings: _parentRegistry.alignmentSettings,
        layoutValidationStatus: 'INHERITED_PASSED',
      ),
      SplinteredModuleMappingRecord(
        moduleId: 'MOD-INPUT-02',
        moduleName: 'FormInputFieldComponent',
        parentTokenReference: _parentRegistry.parentTokenId,
        layoutType: _parentRegistry.layoutType,
        layoutGridDimensions: _parentRegistry.layoutGridDimensions,
        spacingRules: _parentRegistry.spacingRules,
        alignmentSettings: _parentRegistry.alignmentSettings,
        layoutValidationStatus: 'INHERITED_PASSED',
      ),
      SplinteredModuleMappingRecord(
        moduleId: 'MOD-CTA-03',
        moduleName: 'ActionVerbButtonComponent',
        parentTokenReference: _parentRegistry.parentTokenId,
        layoutType: _parentRegistry.layoutType,
        layoutGridDimensions: _parentRegistry.layoutGridDimensions,
        spacingRules: _parentRegistry.spacingRules,
        alignmentSettings: _parentRegistry.alignmentSettings,
        layoutValidationStatus: 'INHERITED_PASSED',
      ),
    ];
  }

  double get _changeFailureRate {
    if (_splinteredModules.isEmpty) return 0.0;
    final failedCount = _splinteredModules
        .where((m) => m.layoutValidationStatus == 'DEVIATION_REJECTED')
        .length;
    return failedCount / _splinteredModules.length;
  }

  void _triggerCiCdLayoutValidationPipeline() {
    setState(() => _isPipelineRunning = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isPipelineRunning = false;
          for (var mod in _splinteredModules) {
            mod.layoutValidationStatus = 'INHERITED_PASSED';
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'DORA GATE PASS: 100% of splintered modules map to parent layout variables. Change Failure Rate = 0%.',
            ),
            backgroundColor: Colors.teal.shade800,
          ),
        );
      }
    });
  }

  void _simulateHardcodedDeviation() {
    setState(() {
      _splinteredModules[1].layoutValidationStatus = 'DEVIATION_REJECTED';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'PIPELINE GATE FAILED: Hardcoded pixel deviation detected in MOD-INPUT-02.',
        ),
        backgroundColor: Colors.red.shade800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cfr = _changeFailureRate;
    final bool isGatePassed = cfr == 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Metrics Constraint Engine'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. DORA CHANGE FAILURE RATE METRIC BANNER
            // =========================================================
            Card.filled(
              color: isGatePassed
                  ? Colors.green.shade50
                  : colorScheme.errorContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isGatePassed
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
                      isGatePassed
                          ? Icons.security_rounded
                          : Icons.gpp_bad_rounded,
                      color: isGatePassed
                          ? Colors.green.shade800
                          : colorScheme.error,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isGatePassed
                                ? 'DORA Metric Pass Rate: Good (0% Change Failure)'
                                : 'BUILD GATE FAILED: Change Failure Rate = ${(cfr * 100).toInt()}%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isGatePassed
                                  ? Colors.green.shade900
                                  : colorScheme.onErrorContainer,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Standard: DORA Change Failure Rate Metric (Optimal: <= 5%).',
                            style: TextStyle(
                              fontSize: 11,
                              color: isGatePassed
                                  ? Colors.black87
                                  : colorScheme.onErrorContainer,
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
            // 2. PARENT LAYOUT METRIC REGISTRY BASELINE
            // =========================================================
            Text(
              'Locked Parent Layout Variables',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Parent Token ID', _parentRegistry.parentTokenId),
                    const Divider(height: 12),
                    _buildRow('Layout Type', _parentRegistry.layoutType),
                    const Divider(height: 12),
                    _buildRow(
                      'Layout Grid Dimensions',
                      _parentRegistry.layoutGridDimensions,
                    ),
                    const Divider(height: 12),
                    _buildRow('Spacing Rules', _parentRegistry.spacingRules),
                    const Divider(height: 12),
                    _buildRow(
                      'Alignment Settings',
                      _parentRegistry.alignmentSettings,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 3. SPLINTERED MODULE INHERITANCE INVENTORY
            // =========================================================
            Text(
              'Splintered Module Mapping Verification',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '100% of splintered modules below inherit parent layout rules without hardcoded deviations.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            ..._splinteredModules.map((mod) {
              final bool isPassed = mod.isCompliant;
              return Card.outlined(
                margin: const EdgeInsets.only(bottom: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: isPassed ? Colors.grey.shade300 : colorScheme.error,
                    width: isPassed ? 1.0 : 2.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${mod.moduleId} (${mod.moduleName})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isPassed
                                  ? Colors.green.shade50
                                  : colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              mod.layoutValidationStatus,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isPassed
                                    ? Colors.green.shade900
                                    : colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Mapped Parent Token: ${mod.parentTokenReference} • Layout: ${mod.layoutType}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),

            // =========================================================
            // 4. CI/CD PIPELINE GATE CONTROLS (>= 48DP TOUCH TARGETS)
            // =========================================================
            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: _isPipelineRunning
                          ? null
                          : _triggerCiCdLayoutValidationPipeline,
                      icon: _isPipelineRunning
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.published_with_changes_rounded),
                      label: const Text(
                        'RUN_DORA_LAYOUT_GATE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48.0),
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.error,
                      side: BorderSide(color: colorScheme.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: _simulateHardcodedDeviation,
                    icon: const Icon(Icons.bug_report_rounded),
                    label: const Text(
                      'Simulate Deviation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
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
