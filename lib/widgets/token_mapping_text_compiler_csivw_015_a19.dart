// CSIVW-015-A19 — Token-Mapping Automated Text Compiler & Preview Interface.
// High-performance dynamic string compilation engine and Material 3 center dialog preview card
// verifying sub-second token replacement, strict bracket regex validation (Poka-Yoke), and under-2KB payload packing.

import 'dart:convert';
import 'package:flutter/material.dart';

/// Represents an individual atomic-level token mapping field.
class TokenMappingField {
  final String sourceElementId;
  final String targetElementId;
  final String mappingRule;
  final String mappingStatus;
  final bool mappingValidation;

  const TokenMappingField({
    required this.sourceElementId,
    required this.targetElementId,
    required this.mappingRule,
    required this.mappingStatus,
    required this.mappingValidation,
  });
}

/// Outcome of the text compilation execution.
class CompilationResult {
  final String compiledText;
  final bool isSuccess;
  final String status; // 'Pass' or 'Fail'
  final double executionTimeMs;
  final int payloadSizeBytes;
  final List<String> unmappedTokens;
  final String? errorMessage;
  final String corporateTrackingMarker;

  const CompilationResult({
    required this.compiledText,
    required this.isSuccess,
    required this.status,
    required this.executionTimeMs,
    required this.payloadSizeBytes,
    required this.unmappedTokens,
    this.errorMessage,
    required this.corporateTrackingMarker,
  });
}

/// Compiler engine enforcing strict substitution, tone guidelines, and Poka-Yoke regex validation.
class TokenMappingCompilerEngine {
  static final RegExp _bracketRegex = RegExp(r'\{\{([^}]+)\}\}');
  static const String trackingPixelId = '<pixel:habot_sys_tk_csivw_015_a19>';
  static const String corporateMarker = '[HABOT-VERIFIED-ID: HBT-NOTIF-2025-015]';

  static CompilationResult compile({
    required String template,
    required Map<String, dynamic> tokenContext,
    String tone = 'Warm & Encouraging',
  }) {
    final stopwatch = Stopwatch()..start();
    final List<String> unmapped = [];

    // 1. String variable substitution
    String compiled = template.replaceAllMapped(_bracketRegex, (match) {
      final tokenKey = match.group(1)?.trim() ?? '';
      if (tokenContext.containsKey(tokenKey)) {
        final val = tokenContext[tokenKey]?.toString() ?? '';
        if (val.trim().isEmpty) {
          unmapped.add(tokenKey);
          return match.group(0)!;
        }
        return val;
      } else {
        unmapped.add(tokenKey);
        return match.group(0)!;
      }
    });

    // 2. Append tone modulation suffix according to standard brand guidelines
    if (tone == 'Professional Milestone') {
      compiled = '$compiled\n\nOur specialists are committed to tracking and supporting your progress.';
    } else if (tone == 'Warm & Encouraging') {
      compiled = '$compiled\n\nWe are cheering you and your child on every step of the way!';
    }

    // 3. Append corporate identification marker and system tracking pixel
    compiled = '$compiled\n\n$corporateMarker\n$trackingPixelId';

    // 4. Mistake-Proofing (Poka-Yoke): Regex scan for remaining unmapped bracket tokens
    final remainingMatches = _bracketRegex.allMatches(compiled);
    final bool containsUnmappedLeak = remainingMatches.isNotEmpty || unmapped.isNotEmpty;

    stopwatch.stop();
    final elapsedMs = stopwatch.elapsedMicroseconds / 1000.0;
    final payloadBytes = utf8.encode(compiled).length;

    // Nielsen Response-Time verification (Floor: 100ms / Optimal: 1000ms / Ceiling: 10000ms)
    final bool underOneSecond = elapsedMs <= 1000.0;
    final bool payloadUnder2Kb = payloadBytes <= 2048;
    final bool passed = !containsUnmappedLeak && underOneSecond && payloadUnder2Kb;

    return CompilationResult(
      compiledText: compiled,
      isSuccess: passed,
      status: passed ? 'Pass' : 'Fail',
      executionTimeMs: elapsedMs,
      payloadSizeBytes: payloadBytes,
      unmappedTokens: unmapped,
      errorMessage: containsUnmappedLeak
          ? 'Compilation halted: Unmapped template tokens detected (${unmapped.join(", ")}).'
          : (!payloadUnder2Kb
              ? 'Payload exceeds 2KB mobile push container limit ($payloadBytes bytes).'
              : null),
      corporateTrackingMarker: '$corporateMarker | $trackingPixelId',
    );
  }
}

/// Material 3 Center Dialog card overlaying the text rendering check interfaces.
class TokenMappingTextCompilerDialog extends StatefulWidget {
  final String initialTemplate;
  final Map<String, dynamic> sampleTokens;
  final void Function(CompilationResult result)? onVerified;

  const TokenMappingTextCompilerDialog({
    super.key,
    this.initialTemplate =
        'Hello {{parent_name}}, specialist {{specialist_tag}} has updated the progress evaluation. Milestone score: {{milestone_score}}.',
    this.sampleTokens = const {
      'parent_name': 'Eleanor Vance',
      'specialist_tag': 'Pediatric Speech Specialist',
      'milestone_score': '94/100',
    },
    this.onVerified,
  });

  @override
  State<TokenMappingTextCompilerDialog> createState() =>
      _TokenMappingTextCompilerDialogState();
}

class _TokenMappingTextCompilerDialogState
    extends State<TokenMappingTextCompilerDialog> {
  late TextEditingController _templateController;
  late Map<String, dynamic> _tokenContext;
  CompilationResult? _lastResult;
  String _selectedTone = 'Warm & Encouraging';

  @override
  void initState() {
    super.initState();
    _templateController = TextEditingController(text: widget.initialTemplate);
    _tokenContext = Map<String, dynamic>.from(widget.sampleTokens);
    _runCompilation();
  }

  @override
  void dispose() {
    _templateController.dispose();
    super.dispose();
  }

  void _runCompilation() {
    final result = TokenMappingCompilerEngine.compile(
      template: _templateController.text,
      tokenContext: _tokenContext,
      tone: _selectedTone,
    );
    setState(() {
      _lastResult = result;
    });
    if (widget.onVerified != null) {
      widget.onVerified!(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Material 3 typography specifications with standard bold Gilroy for system actions
    const TextStyle gilroyButtonTextStyle = TextStyle(
      fontFamily: 'Gilroy',
      fontWeight: FontWeight.bold,
      fontSize: 14,
      letterSpacing: 0.5,
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620, maxHeight: 780),
        child: Padding(
          // Comfortable padding framework for administrative preview window
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dialog Title and Step Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Token-Mapping Automated Compiler',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildStatusPill(_lastResult?.status ?? 'Pass'),
                ],
              ),
              const SizedBox(height: 8.0),
              // Section subtitle relying on standard label scaling boundaries (md.sys.typescale.label-medium)
              Text(
                'CSIVW-015-A19 • Verify <1s latency & zero unmapped raw bracket leakage.',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(height: 1),
              const SizedBox(height: 16.0),

              // Main content scrollable container
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Template Editor Field
                      Text('Source Communication Template', style: theme.textTheme.labelLarge),
                      const SizedBox(height: 6.0),
                      TextField(
                        controller: _templateController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                          hintText: 'Enter template string with {{token_key}} brackets...',
                          contentPadding: const EdgeInsets.all(12.0),
                        ),
                        onChanged: (_) => _runCompilation(),
                      ),
                      const SizedBox(height: 16.0),

                      // Tone Criteria Matrix Dropdown
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Brand Tone Matrix', style: theme.textTheme.labelMedium),
                                const SizedBox(height: 6.0),
                                DropdownButtonFormField<String>(
                                  value: _selectedTone,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  items: const [
                                    DropdownMenuItem(value: 'Warm & Encouraging', child: Text('Warm & Encouraging')),
                                    DropdownMenuItem(value: 'Professional Milestone', child: Text('Professional Milestone')),
                                    DropdownMenuItem(value: 'Standard Notification', child: Text('Standard Notification')),
                                  ],
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() => _selectedTone = val);
                                      _runCompilation();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // Interactive Injected Values Configuration
                      Text('Dynamic Injected Values', style: theme.textTheme.labelMedium),
                      const SizedBox(height: 6.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 6.0,
                        children: _tokenContext.entries.map((entry) {
                          return Chip(
                            label: Text('${entry.key}: ${entry.value}', style: const TextStyle(fontSize: 12)),
                            backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16.0),

                      // Live Administrative Message Preview Frame
                      Text('Rendered Preview (Mobile Push / Email Container)', style: theme.textTheme.labelMedium),
                      const SizedBox(height: 6.0),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                            color: _lastResult?.isSuccess == true
                                ? theme.colorScheme.outlineVariant
                                : theme.colorScheme.error,
                          ),
                        ),
                        child: Text(
                          _lastResult?.compiledText ?? 'No preview available.',
                          style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                        ),
                      ),
                      if (_lastResult?.errorMessage != null) ...[
                        const SizedBox(height: 8.0),
                        Text(
                          '⚠️ ${_lastResult!.errorMessage}',
                          style: TextStyle(color: theme.colorScheme.error, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                      const SizedBox(height: 16.0),

                      // Performance & Latency Telemetry Grid
                      _buildBenchmarkMetrics(theme),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16.0),
              const Divider(height: 1),
              const SizedBox(height: 12.0),

              // System Action Buttons mapping to bold Gilroy typography
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      textStyle: gilroyButtonTextStyle,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Text('Dismiss'),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _lastResult?.isSuccess == true
                        ? () {
                            Navigator.of(context).pop(_lastResult);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      textStyle: gilroyButtonTextStyle,
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Text('Confirm & Dispatch'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusPill(String status) {
    final bool isPass = status == 'Pass';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: isPass ? Colors.green.shade50 : Colors.red.shade50,
        border: Border.all(color: isPass ? Colors.green : Colors.red, width: 1.2),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        isPass ? 'PASS (Nielsen <1.0s)' : 'FAIL',
        style: TextStyle(
          color: isPass ? Colors.green.shade800 : Colors.red.shade800,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildBenchmarkMetrics(ThemeData theme) {
    final latency = _lastResult?.executionTimeMs ?? 0.0;
    final sizeBytes = _lastResult?.payloadSizeBytes ?? 0;
    final underOneSec = latency <= 1000.0;
    final isInstantaneous = latency <= 100.0;

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricCell(
            title: 'Compilation Latency',
            value: '${latency.toStringAsFixed(2)} ms',
            isHealthy: underOneSec,
            subtitle: isInstantaneous ? 'Floor (<0.1s: Instant)' : 'Optimal (<1.0s: Flow)',
          ),
          Container(width: 1, height: 36, color: theme.colorScheme.outlineVariant),
          _buildMetricCell(
            title: 'Payload Size',
            value: '${sizeBytes} B',
            isHealthy: sizeBytes <= 2048,
            subtitle: '<2KB Push Constraint',
          ),
          Container(width: 1, height: 36, color: theme.colorScheme.outlineVariant),
          _buildMetricCell(
            title: 'Unmapped Tokens',
            value: '${_lastResult?.unmappedTokens.length ?? 0}',
            isHealthy: (_lastResult?.unmappedTokens.isEmpty ?? true),
            subtitle: 'Poka-Yoke Zero-Leak',
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCell({
    required String title,
    required String value,
    required bool isHealthy,
    required String subtitle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 2.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isHealthy ? Colors.green.shade700 : Colors.red.shade700,
          ),
        ),
        const SizedBox(height: 1.0),
        Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.black54)),
      ],
    );
  }
}
