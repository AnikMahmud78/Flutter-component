// EDBAA-020-A04 — System Verb Lexicon Modal Compliance.
// Enforces automated system verbs (Validate/Calculate/Aggregate), bans human narrative verbs, and validates modal scrim 60-80% per Material 3.
import 'package:flutter/material.dart';

/// Global unalterable system lexicon rules (EDBAA-020-A04).
/// Purges human-action verbs from UI copy and aligns labels with BigQuery/SQL functions.
class SystemVerbLexicon {
  const SystemVerbLexicon._();

  /// Banned human narrative tokens — linter blocks deployment if found.
  static const Set<String> bannedTokens = {
    'review',
    'decide',
    'think',
    'feel',
    'discuss',
    'consider',
    'explore',
    'story',
    'imagine',
    'guess',
  };

  /// Approved automated system verbs aligned to data-engine functions.
  static const Set<String> allowedVerbs = {
    'Validate',
    'Calculate',
    'Aggregate',
    'Sync',
    'Filter',
    'Export',
    'Refresh',
    'Apply',
    'Confirm',
    'Execute',
  };

  /// Suggested replacement map for banned -> system verb.
  static const Map<String, String> replacements = {
    'review': 'Validate',
    'decide': 'Confirm',
    'consider': 'Filter',
    'explore': 'Aggregate',
    'discuss': 'Sync',
  };

  /// Returns true if [text] contains zero banned tokens (case-insensitive, word-boundary).
  static bool isCompliant(String text) {
    final lower = text.toLowerCase();
    for (final token in bannedTokens) {
      final pattern = RegExp('\\b${RegExp.escape(token)}\\b');
      if (pattern.hasMatch(lower)) return false;
    }
    return true;
  }

  /// Substitutes flagged terms with automated system verbs.
  static String sanitize(String text) {
    var out = text;
    replacements.forEach((banned, replacement) {
      out = out.replaceAll(
        RegExp('\\b$banned\\b', caseSensitive: false),
        replacement,
      );
    });
    return out;
  }

  /// Audits a list of widget descriptions / modal headers. Returns offending entries.
  static List<String> audit(List<String> candidates) {
    return candidates.where((e) => !isCompliant(e)).toList();
  }
}

/// Modal/Overlay Interaction Compliance evaluator.
/// Floor: 80% scrim minimum for focus separation | Optimal: 60-80% | Ceiling: 90%.
class ModalComplianceConfig {
  const ModalComplianceConfig({this.scrimOpacity = 0.7});

  final double scrimOpacity;

  /// Good = 0.6-0.8 optimal, Average = 0.8-0.9 ceiling zone, Poor = outside.
  String evaluate() => evaluateScrim(scrimOpacity);

  static String evaluateScrim(double opacity) {
    if (opacity >= 0.6 && opacity <= 0.8) return 'Good';
    if (opacity > 0.8 && opacity <= 0.9) return 'Average';
    return 'Poor';
  }

  Color barrierColor(BuildContext context) {
    return Colors.black.withOpacity(scrimOpacity.clamp(0.0, 0.9));
  }
}

/// Lock metadata record required by AL-AQ analysis.
class LexiconLockRecord {
  const LexiconLockRecord({
    required this.lockType,
    required this.lockStatus,
    required this.lockedBy,
    required this.lockTimestamp,
    required this.lockReason,
    this.completionStatus = 'Good',
    this.userSessionId = '',
  });

  final String lockType;
  final String lockStatus;
  final String lockedBy;
  final DateTime lockTimestamp;
  final String lockReason;
  final String completionStatus;
  final String userSessionId;

  Map<String, dynamic> toJson() => {
        'Lock Type': lockType,
        'Lock Status': lockStatus,
        'Locked By': lockedBy,
        'Lock Timestamp': lockTimestamp.toIso8601String(),
        'Lock Reason': lockReason,
        'Completion Status': completionStatus,
        'Action/Event Timestamp': DateTime.now().toUtc().toIso8601String(),
        'User/Session ID': userSessionId,
      };
}

/// Material 3 system command button with explicit outline border,
/// scalable padding, and smooth progress-track overlay on tap.
class SystemCommandButton extends StatelessWidget {
  const SystemCommandButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isSelected = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Enforce lexicon at build time in debug; sanitize in release.
    assert(
      SystemVerbLexicon.isCompliant(label),
      'EDBAA-020-A04: banned narrative verb in button label: $label',
    );
    final safeLabel = SystemVerbLexicon.sanitize(label);
    final textStyle = theme.textTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
          label: Padding(
            // Scalable padding for scannability on small viewports.
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(safeLabel, style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            minimumSize: const Size(88, 44),
            side: BorderSide(
              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
              width: isSelected ? 2.0 : 1.0,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            foregroundColor: theme.colorScheme.onSurface,
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: theme.colorScheme.surface.withOpacity(0.6),
                alignment: Alignment.bottomCenter,
                child: const LinearProgressIndicator(minHeight: 3),
              ),
            ),
          ),
      ],
    );
  }
}

/// Sanitized modal header — extracts widget description blocks for lexical evaluation.
class LexiconModalHeader extends StatelessWidget {
  const LexiconModalHeader({super.key, required this.rawTitle, this.subtitle});

  final String rawTitle;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = SystemVerbLexicon.sanitize(rawTitle);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            SystemVerbLexicon.sanitize(subtitle!),
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ],
    );
  }
}

/// Compliant modal dialog wrapper enforcing scrim + lexicon + lock audit trail.
class LexiconCompliantModal extends StatelessWidget {
  const LexiconCompliantModal({
    super.key,
    required this.title,
    required this.child,
    required this.actions,
    this.compliance = const ModalComplianceConfig(),
  });

  final String title;
  final Widget child;
  final List<Widget> actions;
  final ModalComplianceConfig compliance;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget Function(BuildContext) builder,
    List<Widget> actions = const [],
    ModalComplianceConfig compliance = const ModalComplianceConfig(),
  }) {
    return showDialog<T>(
      context: context,
      barrierColor: compliance.barrierColor(context),
      barrierDismissible: true,
      builder: (ctx) => LexiconCompliantModal(
        title: title,
        actions: actions,
        compliance: compliance,
        child: builder(ctx),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LexiconModalHeader(rawTitle: title),
              const SizedBox(height: 12),
              Flexible(child: child),
              if (actions.isNotEmpty) ...[
                const SizedBox(height: 16),
                Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.end, children: actions),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
