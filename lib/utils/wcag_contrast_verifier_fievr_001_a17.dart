// FIEVR-001-A17 — Assessment Scoring Contrast Verifier & Score Panel.
// Verifies WCAG 2.1 AA contrast for all state colors and renders M3 score panel with warning banners.
import 'package:flutter/material.dart';

/// WCAG 2.1 AA thresholds.
class WcagThresholds {
  static const double normalTextAA = 4.5;
  static const double largeTextAA = 3.0;
  static const double uiComponentAA = 3.0;
  static const double normalTextAAA = 7.0;
  static const double largeTextAAA = 4.5;
}

/// Represents a single state color to verify.
@immutable
class AssessedStateColor {
  final String colorName;
  final Color foreground;
  final Color background;
  final String colorScheme;
  final String applicationMap;
  final bool isLargeText;
  final bool isUiComponent;

  const AssessedStateColor({
    required this.colorName,
    required this.foreground,
    required this.background,
    required this.colorScheme,
    required this.applicationMap,
    this.isLargeText = false,
    this.isUiComponent = false,
  });

  String get hexForeground => '#${foreground.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  String get hexBackground => '#${background.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
}

/// Result of a single contrast check.
@immutable
class ContrastCheckResult {
  final AssessedStateColor input;
  final double ratio;
  final double requiredRatio;
  final bool passesAA;
  final bool passesAAA;

  const ContrastCheckResult({
    required this.input,
    required this.ratio,
    required this.requiredRatio,
    required this.passesAA,
    required this.passesAAA,
  });

  String get verdict => passesAA ? 'Pass' : 'Fail';
}

/// Pure-Dart WCAG 2.1 contrast calculator per W3C relative-luminance formula.
class WcagContrastVerifier {
  const WcagContrastVerifier._();

  static double relativeLuminance(Color c) {
    double channel(int v) {
      final s = v / 255.0;
      return s <= 0.03928 ? s / 12.92 : _pow((s + 0.055) / 1.055, 2.4);
    }
    final r = channel(c.red);
    final g = channel(c.green);
    final b = channel(c.blue);
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double _pow(double base, double exp) {
    // Avoid dart:math import overhead in UI isolate; simple fast pow.
    double result = 1.0;
    // Use iterative approximation via exp/log would need dart:math, so use direct.
    // Fallback to manual exponentiation using dart:math-free Newton is overkill;
    // We implement via repeated multiplication-free approach using built-in.
    return _powImpl(base, exp);
  }

  static double _powImpl(double b, double e) {
    // Minimal dependency-free pow using exponentiation by squaring for 2.4
    // 2.4 = 12/5 -> pow(b, 12) then 5th root via Newton iterations.
    double p12 = 1.0;
    for (int i = 0; i < 12; i++) {
      p12 *= b;
    }
    double x = b; // initial guess
    for (int i = 0; i < 20; i++) {
      final x4 = x * x * x * x;
      final x5 = x4 * x;
      if (x == 0) break;
      x = x - (x5 - p12) / (5 * x4);
    }
    return x;
  }

  static double contrastRatio(Color a, Color b) {
    final l1 = relativeLuminance(a);
    final l2 = relativeLuminance(b);
    final lighter = l1 > l2 ? l1 : l2;
    final darker = l1 > l2 ? l2 : l1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  static double requiredRatioFor(AssessedStateColor s) {
    if (s.isUiComponent) return WcagThresholds.uiComponentAA;
    if (s.isLargeText) return WcagThresholds.largeTextAA;
    return WcagThresholds.normalTextAA;
  }

  static ContrastCheckResult verifyOne(AssessedStateColor s) {
    final ratio = contrastRatio(s.foreground, s.background);
    final req = requiredRatioFor(s);
    final passesAA = ratio >= req;
    final aaaReq = s.isLargeText || s.isUiComponent
        ? WcagThresholds.largeTextAAA
        : WcagThresholds.normalTextAAA;
    return ContrastCheckResult(
      input: s,
      ratio: double.parse(ratio.toStringAsFixed(2)),
      requiredRatio: req,
      passesAA: passesAA,
      passesAAA: ratio >= aaaReq,
    );
  }

  static List<ContrastCheckResult> verifyAll(List<AssessedStateColor> states) {
    return states.map(verifyOne).toList(growable: false);
  }

  static WcagVerificationReport buildReport(List<ContrastCheckResult> results) {
    if (results.isEmpty) {
      return const WcagVerificationReport(passRate: 0, total: 0, passed: 0);
    }
    final passed = results.where((e) => e.passesAA).length;
    final rate = passed / results.length * 100.0;
    return WcagVerificationReport(
      passRate: double.parse(rate.toStringAsFixed(1)),
      total: results.length,
      passed: passed,
    );
  }
}

/// QA gate report: Floor 90%, Optimal 98-100%, Ceiling 100% + CI automation.
@immutable
class WcagVerificationReport {
  final double passRate;
  final int total;
  final int passed;
  const WcagVerificationReport({required this.passRate, required this.total, required this.passed});
  bool get meetsFloor => passRate >= 90.0;
  bool get meetsOptimal => passRate >= 98.0;
  bool get isCeiling => passRate >= 100.0;
  String get verdict => meetsFloor ? 'Pass' : 'Fail';
}

/// Material 3 responsive panel showing per-state contrast + high-contrast warning banner.
class AssessmentContrastScorePanelFievr001A17 extends StatelessWidget {
  final List<AssessedStateColor> states;
  final VoidCallback? onRequestFix;
  final String title;

  const AssessmentContrastScorePanelFievr001A17({
    super.key,
    required this.states,
    this.onRequestFix,
    this.title = 'Assessment Scoring — Contrast Verification',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final results = WcagContrastVerifier.verifyAll(states);
    final report = WcagContrastVerifier.buildReport(results);
    final hasFailure = results.any((e) => !e.passesAA);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 520;
        return Card(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(title: title, report: report, colorScheme: colorScheme),
              if (hasFailure)
                Material(
                  color: colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, color: colorScheme.onErrorContainer),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${report.total - report.passed} state color(s) fail WCAG 2.1 AA. Fix before release.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onErrorContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (onRequestFix != null)
                          TextButton(
                            onPressed: onRequestFix,
                            child: const Text('Review'),
                          ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: isNarrow
                    ? Column(children: [for (final r in results) _StateRow(result: r)])
                    : Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [for (final r in results) SizedBox(width: 320, child: _StateRow(result: r))],
                      ),
              ),
              _Footer(report: report),
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final WcagVerificationReport report;
  final ColorScheme colorScheme;
  const _Header({required this.title, required this.report, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pass = report.verdict == 'Pass';
    return Container(
      color: colorScheme.surfaceContainerHigh,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                  'WCAG 2.1 AA • ${report.passed}/${report.total} passed • ${report.passRate}%',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Semantics(
            label: 'Verification ${report.verdict}',
            child: Chip(
              label: Text(report.verdict),
              backgroundColor: pass ? colorScheme.primaryContainer : colorScheme.errorContainer,
              labelStyle: TextStyle(
                color: pass ? colorScheme.onPrimaryContainer : colorScheme.onErrorContainer,
                fontWeight: FontWeight.w700,
              ),
              avatar: Icon(pass ? Icons.verified : Icons.error, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _StateRow extends StatelessWidget {
  final ContrastCheckResult result;
  const _StateRow({required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final s = result.input;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: s.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: cs.outlineVariant),
                ),
                alignment: Alignment.center,
                child: Text('Aa', style: TextStyle(color: s.foreground, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.colorName, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                    Text('${s.hexForeground} on ${s.hexBackground} • ${s.applicationMap}',
                        style: theme.textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Chip(
                label: Text(result.verdict),
                visualDensity: VisualDensity.compact,
                backgroundColor: result.passesAA ? cs.primaryContainer : cs.errorContainer,
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: result.passesAA ? cs.onPrimaryContainer : cs.onErrorContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (result.ratio / 21.0).clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: cs.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(result.passesAA ? cs.primary : cs.error),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Ratio ${result.ratio}:1 • Required ${result.requiredRatio}:1 • ${s.colorScheme}',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final WcagVerificationReport report;
  const _Footer({required this.report});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: Text(
        'Gate: Floor 90% • Optimal 98–100% • Ceiling 100% + CI. Current: ${report.passRate}% — ${report.verdict} (Scale: Pass/Fail).',
        style: theme.textTheme.bodySmall,
      ),
    );
  }
}
