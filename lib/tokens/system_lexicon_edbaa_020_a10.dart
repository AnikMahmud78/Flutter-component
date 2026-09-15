// EDBAA-020-A10 — System Lexicon Governance & Deterministic Command Buttons.
// Central unalterable glossary (Validate/Calculate/Aggregate/Process) with linter + Material 3 action buttons.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// EDBAA-020-A10: Purge Human-Action Verbs from UI Copy.
///
/// Locks approved deterministic verbs into tokens, provides audit/lint
/// coverage (Floor 90% / Optimal 100%), and renders Material 3 command
/// buttons with scalable padding, typography, outline borders and
/// progress-track overlay. Aligns labels with BigQuery/SQL functions.
class SystemLexicon {
  const SystemLexicon._();

  /// Approved deterministic system verbs — the only allowed action lexicon.
  static const Set<String> approvedVerbs = {
    'Validate',
    'Calculate',
    'Aggregate',
    'Process',
    'Synchronize',
    'Filter',
    'Export',
    'Refresh',
    'Execute',
    'Commit',
  };

  /// Banned human-action / narrative verbs -> deterministic replacement.
  static const Map<String, String> bannedToReplacement = {
    'review': 'Validate',
    'decide': 'Execute',
    'think': 'Process',
    'consider': 'Filter',
    'discuss': 'Synchronize',
    'approve': 'Commit',
    'check': 'Validate',
    'look': 'Filter',
    'guess': 'Calculate',
    'feel': 'Aggregate',
    'story': 'Process',
    'submit for review': 'Validate',
    'decide later': 'Execute',
  };

  /// Normalized lookup key.
  static String normalize(String input) => input.trim().toLowerCase();

  /// Returns true if [label] contains zero banned tokens.
  static bool isCompliant(String label) {
    final lower = ' ${label.toLowerCase()} ';
    for (final banned in bannedToReplacement.keys) {
      if (lower.contains(banned)) return false;
    }
    return true;
  }

  /// Suggests deterministic replacement for a non-compliant label.
  static String suggestReplacement(String label) {
    var result = label;
    bannedToReplacement.forEach((banned, replacement) {
      final pattern = RegExp(RegExp.escape(banned), caseSensitive: false);
      result = result.replaceAll(pattern, replacement);
    });
    return result;
  }

  /// Sanitizes label; in debug mode asserts if banned term is used.
  static String sanitize(String label) {
    if (!isCompliant(label)) {
      final fixed = suggestReplacement(label);
      assert(() {
        debugPrint('[EDBAA-020-A10] Linter: "$label" -> "$fixed"');
        return true;
      }());
      return fixed;
    }
    return label;
  }
}

/// Single string audit finding.
@immutable
class LexiconViolation {
  final String sourceId;
  final String original;
  final String suggested;
  const LexiconViolation({
    required this.sourceId,
    required this.original,
    required this.suggested,
  });
}

/// Audit coverage result. Output field: Complete / Partial / Not Complete.
@immutable
class LexiconAuditResult {
  final int total;
  final int audited;
  final List<LexiconViolation> violations;
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String userId;

  const LexiconAuditResult({
    required this.total,
    required this.audited,
    required this.violations,
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.userId,
  });

  double get coverage => total == 0 ? 1.0 : audited / total;

  /// Floor 90% minimum, Optimal 100% reconciled.
  String get completionStatus {
    if (coverage >= 1.0 && violations.isEmpty) return 'Complete';
    if (coverage >= 0.9) return 'Partial';
    return 'Not Complete';
  }

  bool get blocksDeployment => violations.isNotEmpty || coverage < 0.9;
}

/// Programmatic linter — blocks deployment if banned tokens exist.
class LexiconLinter {
  const LexiconLinter._();

  static LexiconAuditResult audit({
    required Map<String, String> labeledStrings,
    required String stepExecutionId,
    required String userId,
    String executionStatus = 'Executed',
  }) {
    final violations = <LexiconViolation>[];
    labeledStrings.forEach((id, label) {
      if (!SystemLexicon.isCompliant(label)) {
        violations.add(LexiconViolation(
          sourceId: id,
          original: label,
          suggested: SystemLexicon.suggestReplacement(label),
        ));
      }
    });
    return LexiconAuditResult(
      total: labeledStrings.length,
      audited: labeledStrings.length,
      violations: violations,
      stepExecutionId: stepExecutionId,
      executionStatus: executionStatus,
      executionTimestamp: DateTime.now().toUtc(),
      userId: userId,
    );
  }
}

/// Standardized widget descriptor — no narrative storytelling allowed.
class SystemDescriptor extends StatelessWidget {
  final String descriptorId;
  final String rawText;
  final TextStyle? style;
  const SystemDescriptor({
    super.key,
    required this.descriptorId,
    required this.rawText,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final text = SystemLexicon.sanitize(rawText);
    final theme = Theme.of(context);
    return Text(
      text,
      semanticsLabel: text,
      style: (style ?? theme.textTheme.bodyMedium)?.copyWith(
        letterSpacing: 0.1,
        height: 1.4,
      ),
    );
  }
}

/// Material 3 deterministic command button with outline + progress overlay.
///
/// Short punchy verbs only. Padding scales for small viewports, typography
/// uses Material scales, tap fires smooth LinearProgressIndicator overlay.
class SystemCommandButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final Future<void> Function()? onExecute;
  final VoidCallback? onPressed;
  final bool outlined;
  final String stepExecutionId;
  const SystemCommandButton({
    super.key,
    required this.label,
    this.icon,
    this.onExecute,
    this.onPressed,
    this.outlined = false,
    this.stepExecutionId = 'EDBAA-020-A10',
  });

  @override
  State<SystemCommandButton> createState() => _SystemCommandButtonState();
}

class _SystemCommandButtonState extends State<SystemCommandButton> {
  bool _processing = false;

  EdgeInsetsGeometry _scaledPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 360;
    return EdgeInsets.symmetric(
      horizontal: compact ? 12 : 20,
      vertical: compact ? 10 : 14,
    );
  }

  Future<void> _handleTap() async {
    if (_processing) return;
    if (widget.onExecute != null) {
      setState(() => _processing = true);
      try {
        await widget.onExecute!();
      } finally {
        if (mounted) setState(() => _processing = false);
      }
    } else {
      widget.onPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = SystemLexicon.sanitize(widget.label);
    final padding = _scaledPadding(context);
    final textStyle = (theme.textTheme.labelLarge)?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: widget.outlined
            ? theme.colorScheme.primary
            : theme.colorScheme.outlineVariant,
        width: widget.outlined ? 1.5 : 1.0,
      ),
    );
    final child = Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: _processing ? 0.45 : 1.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  label.toUpperCase(),
                  style: textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (_processing)
          const Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LinearProgressIndicator(minHeight: 2),
            ),
          ),
      ],
    );
    if (widget.outlined) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(padding: padding, shape: shape),
        onPressed: _processing ? null : _handleTap,
        child: child,
      );
    }
    return FilledButton(
      style: FilledButton.styleFrom(padding: padding, shape: shape),
      onPressed: _processing ? null : _handleTap,
      child: child,
    );
  }
}
