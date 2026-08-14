import 'package:flutter/material.dart';
import '../models/viewport_metadata_model.dart';

class ResponsiveViewportListenerWidget extends StatefulWidget {
  const ResponsiveViewportListenerWidget({super.key});

  @override
  State<ResponsiveViewportListenerWidget> createState() =>
      _ResponsiveViewportListenerWidgetState();
}

class _ResponsiveViewportListenerWidgetState
    extends State<ResponsiveViewportListenerWidget> {
  final List<ViewportAuditLogRecord> _auditLogs = [];

  bool _simulateParsingFailure = false;
  bool _isValidationFrozen = false;
  String _previousAspectSetting = 'INITIALIZING';

  @override
  void initState() {
    super.initState();
    _recordAuditLog(
      parameter: 'VIEWPORT_LISTENER_INIT',
      current: 'ACTIVE_LISTENER',
      previous: 'OFFLINE',
      log: 'Responsive layout listener initialized.',
    );
  }

  void _recordAuditLog({
    required String parameter,
    required String current,
    required String previous,
    required String log,
  }) {
    final record = ViewportAuditLogRecord(
      configurationParameter: parameter,
      currentSetting: current,
      previousSetting: previous,
      changeLog: log,
      configurationTimestamp: DateTime.now().toUtc().toIso8601String(),
    );

    setState(() {
      _auditLogs.insert(0, record);
      if (_auditLogs.length > 10) _auditLogs.removeLast();
    });
  }

  void _toggleSimulatedParsingFailure() {
    setState(() {
      _simulateParsingFailure = !_simulateParsingFailure;
      _isValidationFrozen = _simulateParsingFailure;
    });

    if (_simulateParsingFailure) {
      _recordAuditLog(
        parameter: 'VIEWPORT_PARSING_EXCEPTION',
        current: 'STATE_FROZEN_FAIL_CLOSED',
        previous: 'VALIDATED',
        log:
            'PARSING EXCEPTION: Corrupted viewport metadata string detected. Validation frozen.',
      );
    } else {
      _recordAuditLog(
        parameter: 'VIEWPORT_PARSING_RESTORED',
        current: 'VALIDATED',
        previous: 'STATE_FROZEN_FAIL_CLOSED',
        log:
            'Parsing restored. Structural component validation state unlocked.',
      );
    }
  }

  String _calculateAspectString(double width, double height) {
    if (height == 0) return 'UNKNOWN';
    final ratio = width / height;
    if (ratio > 1.7) return '19.5:9 (Tall Phone)';
    if (ratio > 1.4) return '16:9 (Standard Widescreen)';
    if (ratio > 1.2) return '4:3 (Tablet Aspect)';
    return '1:1 (Square Layout)';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Viewport Aspect Listener'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;
          final double ratio = height > 0 ? width / height : 1.0;
          final String rawAspectStr = _calculateAspectString(width, height);

          final String currentSettingStr =
              '${width.toInt()}x${height.toInt()}dp ($rawAspectStr)';

          // Detect viewport change and update audit log
          if (currentSettingStr != _previousAspectSetting &&
              !_isValidationFrozen) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _recordAuditLog(
                parameter: 'VIEWPORT_ASPECT_RECONFIGURED',
                current: currentSettingStr,
                previous: _previousAspectSetting,
                log:
                    'Dynamic layout listener recalculated aspect ratio coordinates.',
              );
              _previousAspectSetting = currentSettingStr;
            });
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0), // Standard 16dp outer margin
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================================================
                // 1. PROCESS EXECUTION QUALITY SCORE BANNER
                // =========================================================
                Card.filled(
                  color: _isValidationFrozen
                      ? colorScheme.errorContainer
                      : Colors.green.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: _isValidationFrozen
                          ? colorScheme.error
                          : Colors.green.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Icon(
                          _isValidationFrozen
                              ? Icons.gpp_bad_rounded
                              : Icons.verified_rounded,
                          color: _isValidationFrozen
                              ? colorScheme.error
                              : Colors.green.shade800,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isValidationFrozen
                                    ? 'PARSING FAILURE: VALIDATION FROZEN'
                                    : 'Process Execution Quality: 100% (Good)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: _isValidationFrozen
                                      ? colorScheme.onErrorContainer
                                      : Colors.green.shade900,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _isValidationFrozen
                                    ? 'Structural component validation locked per ISO 9001:2015 fail-closed policy.'
                                    : 'Compliant with ISO 9001:2015 Quality Management Standard.',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: _isValidationFrozen
                                      ? colorScheme.onErrorContainer
                                      : Colors.black87,
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
                // 2. LIVE VIEWPORT ASPECT METADATA CARD
                // =========================================================
                Text(
                  'Live Viewport Aspect Metrics',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Aspect Config String',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: _isValidationFrozen
                                    ? colorScheme.errorContainer
                                    : Colors.indigo.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _isValidationFrozen
                                    ? 'CORRUPTED_PARSING'
                                    : rawAspectStr,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: _isValidationFrozen
                                      ? colorScheme.onErrorContainer
                                      : Colors.indigo.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isValidationFrozen
                              ? 'ERROR: [PARSE_ERR_0X2382] UNABLE_TO_MAP_COORDINATES'
                              : '${width.toStringAsFixed(1)} dp x ${height.toStringAsFixed(1)} dp (Ratio: ${ratio.toStringAsFixed(2)})',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _isValidationFrozen
                                ? colorScheme.error
                                : colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =========================================================
                // 3. RELATIVE COORDINATE COMPOSITION & SIMULATOR
                // =========================================================
                Text(
                  'Scalable Relative Composition Box',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isValidationFrozen
                        ? Colors.grey.shade300
                        : colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isValidationFrozen
                          ? colorScheme.error
                          : colorScheme.secondary,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isValidationFrozen
                            ? Icons.lock_rounded
                            : Icons.aspect_ratio_rounded,
                        color: _isValidationFrozen
                            ? colorScheme.error
                            : colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isValidationFrozen
                            ? 'STRUCTURAL LAYOUT FROZEN'
                            : 'Relative Scaling Box (${(width * 0.9).toInt()}dp Width)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: _isValidationFrozen
                              ? colorScheme.error
                              : colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // PARSING FAILURE SIMULATION TRIGGER (>= 48DP TOUCH TARGET)
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 48.0,
                    minHeight: 48.0, // Minimum 48dp Touch Target
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.0,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _simulateParsingFailure
                            ? Colors.teal.shade800
                            : colorScheme.error,
                        side: BorderSide(
                          color: _simulateParsingFailure
                              ? Colors.teal.shade800
                              : colorScheme.error,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: _toggleSimulatedParsingFailure,
                      icon: Icon(
                        _simulateParsingFailure
                            ? Icons.refresh_rounded
                            : Icons.bug_report_rounded,
                      ),
                      label: Text(
                        _simulateParsingFailure
                            ? 'Restore Viewport Parsing Validation'
                            : 'Simulate Viewport Parsing Exception',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // =========================================================
                // 4. ATOMIC ISO 9001:2015 AUDIT LOGS
                // =========================================================
                Text(
                  'ISO 9001:2015 Configuration Audit Logs',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                Card.outlined(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _auditLogs.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final log = _auditLogs[index];
                      return ListTile(
                        dense: true,
                        title: Text(
                          log.configurationParameter,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          '${log.changeLog}\nPrev: ${log.previousSetting} → Curr: ${log.currentSetting}',
                          style: const TextStyle(fontSize: 11),
                        ),
                        trailing: Text(
                          log.configurationTimestamp.substring(11, 19),
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            color: Colors.grey.shade600,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
