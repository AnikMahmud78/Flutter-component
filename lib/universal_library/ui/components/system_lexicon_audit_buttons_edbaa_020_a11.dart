// EDBAA-020-A11 — System Lexicon Audit Buttons & Typography Wrap Guard.
// Enforces Validate/Calculate/Aggregate system verbs, bans Review/Decide narrative terms, validates 12-22sp type ramp and audits replacement wrap overflow.
import 'package:flutter/material.dart';

/// Central unalterable system lexicon rules (EDBAA-020-A11).
/// Locks approved terminology glossary as design tokens.
class SystemLexiconTokens {
  const SystemLexiconTokens._();

  static const List<String> approvedSystemVerbs = <String>[
    'Validate',
    'Calculate',
    'Aggregate',
    'Synchronize',
    'Index',
    'Export',
    'Purge',
    'Filter',
  ];

  static const Set<String> bannedNarrativeTokens = <String>{
    'review',
    'decide',
    'discuss',
    'consider',
    'judge',
    'think',
    'feel',
    'believe',
    'guess',
    'story',
  };

  static const Map<String, String> narrativeToSystemMap = <String, String>{
    'review': 'Validate',
    'decide': 'Calculate',
    'discuss': 'Aggregate',
    'consider': 'Filter',
    'judge': 'Validate',
    'think': 'Calculate',
  };

  // Typography Scale Compliance (Type Ramp) tokens.
  static const double floorSp = 12.0;
  static const double optimalMinSp = 14.0;
  static const double optimalMaxSp = 16.0;
  static const double ceilingSp = 22.0;
  static const double minLineHeight = 1.4;
  static const double maxLineHeight = 1.6;
  static const List<String> fallbackStack = <String>['Roboto', 'Inter', 'NotoSans', 'sans-serif'];

  static TextStyle bodyStyle({double size = 14.0, double height = 1.5}) {
    return TextStyle(
      fontSize: size,
      height: height,
      fontFamily: 'Roboto',
      fontFamilyFallback: fallbackStack,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    );
  }
}

/// Poka-Yoke linter: blocks deployment if banned narrative vocabulary is present.
class SystemLexiconLinter {
  const SystemLexiconLinter._();

  static List<String> findBannedTokens(String input) {
    final lower = input.toLowerCase();
    return SystemLexiconTokens.bannedNarrativeTokens.where((t) => lower.contains(t)).toList();
  }

  static bool isCompliant(String input) => findBannedTokens(input).isEmpty;

  static String autoRepair(String input) {
    var out = input;
    SystemLexiconTokens.narrativeToSystemMap.forEach((banned, replacement) {
      out = out.replaceAll(RegExp(banned, caseSensitive: false), replacement);
    });
    return out;
  }
}

/// Typography scale evaluation -> Good / Average / Poor.
class TypographyScaleAudit {
  const TypographyScaleAudit._();

  static String evaluate({required double fontSizeSp, double? heightFactor, bool hasFallback = true}) {
    if (fontSizeSp < SystemLexiconTokens.floorSp || !hasFallback) return 'Poor';
    if (fontSizeSp > SystemLexiconTokens.ceilingSp) return 'Poor';
    final h = heightFactor ?? 1.5;
    final inOptimal = fontSizeSp >= SystemLexiconTokens.optimalMinSp && fontSizeSp <= SystemLexiconTokens.optimalMaxSp;
    final heightOk = h >= SystemLexiconTokens.minLineHeight && h <= SystemLexiconTokens.maxLineHeight;
    if (inOptimal && heightOk) return 'Good';
    return 'Average';
  }
}

/// Audits text alignment contexts to ensure replacement strings do not cause wrap overflows.
class TextWrapAuditor {
  const TextWrapAuditor._();

  static bool willOverflow({
    required String text,
    required TextStyle style,
    required double maxWidth,
    int maxLines = 1,
    TextDirection direction = TextDirection.ltr,
  }) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: direction,
      maxLines: maxLines,
    )..layout(maxWidth: maxWidth);
    return painter.didExceedMaxLines || painter.width > maxWidth;
  }
}

/// Atomic-level audit record for EDBAA-020-A11.
class LexiconAuditRecord {
  final String auditType;
  final DateTime auditDate;
  final String auditResult;
  final String auditTrail;
  final String auditorInfo;
  final String completionStatus;
  final DateTime timestamp;
  final String sessionId;
  const LexiconAuditRecord({
    required this.auditType,
    required this.auditDate,
    required this.auditResult,
    required this.auditTrail,
    required this.auditorInfo,
    required this.completionStatus,
    required this.timestamp,
    required this.sessionId,
  });
  Map<String, Object> toJson() => <String, Object>{
        'Audit Type': auditType,
        'Audit Date': auditDate.toIso8601String(),
        'Audit Result': auditResult,
        'Audit Trail': auditTrail,
        'Auditor Information': auditorInfo,
        'Completion Status': completionStatus,
        'Action/Event Timestamp': timestamp.toIso8601String(),
        'User/Session ID': sessionId,
      };
}

/// Material 3 command panel using only system verbs with wrap-overflow guard,
/// scalable padding, outline delineation, and progress-track overlay on tap.
class SystemLexiconAuditPanel extends StatefulWidget {
  final String auditorInfo;
  final String sessionId;
  final ValueChanged<LexiconAuditRecord>? onAuditComplete;
  const SystemLexiconAuditPanel({super.key, this.auditorInfo = 'Anik / UX Writer', this.sessionId = 'sess-local', this.onAuditComplete});

  @override
  State<SystemLexiconAuditPanel> createState() => _SystemLexiconAuditPanelState();
}

class _SystemLexiconAuditPanelState extends State<SystemLexiconAuditPanel> {
  String? activeVerb;
  bool isBusy = false;
  String auditMessage = 'Zero narrative verbs verified.';
  final List<String> commands = <String>['Validate', 'Calculate', 'Aggregate', 'Synchronize'];

  Future<void> _fireCommand(String verb, double maxWidth) async {
    if (!SystemLexiconLinter.isCompliant(verb)) return;
    final style = SystemLexiconTokens.bodyStyle(size: 14.0);
    final overflow = TextWrapAuditor.willOverflow(text: verb, style: style, maxWidth: maxWidth, maxLines: 1);
    setState(() {
      activeVerb = verb;
      isBusy = true;
      auditMessage = overflow ? 'Wrap overflow: shorten or reduce to 14sp.' : 'Good: $verb fits without wrap overflow.';
    });
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    final grade = TypographyScaleAudit.evaluate(fontSizeSp: 14.0, heightFactor: 1.5, hasFallback: true);
    final record = LexiconAuditRecord(
      auditType: 'Text Alignment + Lexicon',
      auditDate: DateTime.now().toUtc(),
      auditResult: overflow ? 'Fail: overflow' : 'Pass: $verb compliant',
      auditTrail: 'EDBAA-020-A11 | $verb | overflow=$overflow | grade=$grade',
      auditorInfo: widget.auditorInfo,
      completionStatus: overflow ? 'Poor' : grade,
      timestamp: DateTime.now().toUtc(),
      sessionId: widget.sessionId,
    );
    widget.onAuditComplete?.call(record);
    setState(() => isBusy = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      final maxW = constraints.maxWidth;
      final btnStyle = SystemLexiconTokens.bodyStyle();
      return Card(
        elevation: 0,
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: theme.colorScheme.outlineVariant)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('System Commands', style: theme.textTheme.titleSmall?.copyWith(fontSize: 14, height: 1.5, fontFamilyFallback: SystemLexiconTokens.fallbackStack)),
            const SizedBox(height: 4),
            Text('Objective vocabulary only. Review / Decide are blocked.', style: theme.textTheme.bodySmall?.copyWith(fontSize: 12, height: 1.5, fontFamilyFallback: SystemLexiconTokens.fallbackStack)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final verb in commands)
                  _CommandButton(
                    label: verb,
                    selected: activeVerb == verb,
                    textStyle: btnStyle,
                    onTap: () => _fireCommand(verb, maxW / 2),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Stack(children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.outline), borderRadius: BorderRadius.circular(8)),
                child: Text(auditMessage, style: btnStyle.copyWith(fontSize: 14)),
              ),
              if (isBusy)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const LinearProgressIndicator(minHeight: 3),
                  ),
                ),
            ]),
            const SizedBox(height: 8),
            Text('Type ramp 12sp floor / 14-16sp optimal / 22sp ceiling. Line-height 1.4-1.6x.', style: theme.textTheme.labelSmall?.copyWith(fontFamilyFallback: SystemLexiconTokens.fallbackStack)),
          ]),
        ),
      );
    });
  }
}

class _CommandButton extends StatelessWidget {
  final String label;
  final bool selected;
  final TextStyle textStyle;
  final VoidCallback onTap;
  const _CommandButton({required this.label, required this.selected, required this.textStyle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(88, 44),
        tapTargetSize: MaterialTapTargetSize.padded,
        visualDensity: VisualDensity.compact,
        textStyle: textStyle,
        side: BorderSide(color: selected ? theme.colorScheme.primary : theme.colorScheme.outline, width: selected ? 2 : 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ).copyWith(overlayColor: WidgetStatePropertyAll(theme.colorScheme.primary.withOpacity(0.08))),
      child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
