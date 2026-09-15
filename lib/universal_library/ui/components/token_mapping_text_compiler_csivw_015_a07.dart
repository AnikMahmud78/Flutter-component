// CSIVW-015-A07 — Token-Mapping Automated Text Compiler Preview Engine.
// Uneditable tone-to-brand rule matrix with regex-guarded {{token}} substitution, 2KB budget, and M3 preview dialog.
import 'dart:convert';
import 'package:flutter/material.dart';

/// Brand communication tones aligned to brand identity standards.
enum BrandTone { supportive, professional, celebratory, urgent }

/// Immutable rule for one tone. Uneditable by design (const).
@immutable
class ToneBrandRule {
  final BrandTone tone;
  final String voiceDescriptor;
  final String greetingStyle;
  final String closingStyle;
  final int maxExclamations;
  final bool allowEmoji;
  const ToneBrandRule({
    required this.tone,
    required this.voiceDescriptor,
    required this.greetingStyle,
    required this.closingStyle,
    required this.maxExclamations,
    required this.allowEmoji,
  });
}

/// CSIVW-015-A07: Uneditable rule matrix mapping language tone -> brand identity.
/// Private ctor + const map prevents mutation / extension at runtime.
final class BrandToneRuleMatrix {
  const BrandToneRuleMatrix._();
  static const Map<BrandTone, ToneBrandRule> rules = {
    BrandTone.supportive: ToneBrandRule(
      tone: BrandTone.supportive,
      voiceDescriptor: 'Warm, direct support',
      greetingStyle: 'Hi {{parentName}},',
      closingStyle: 'We are here for you — Team Habot',
      maxExclamations: 1,
      allowEmoji: false,
    ),
    BrandTone.professional: ToneBrandRule(
      tone: BrandTone.professional,
      voiceDescriptor: 'Clear, operational, trusted',
      greetingStyle: 'Hello {{parentName}},',
      closingStyle: 'Regards, Habot Growth Team',
      maxExclamations: 0,
      allowEmoji: false,
    ),
    BrandTone.celebratory: ToneBrandRule(
      tone: BrandTone.celebratory,
      voiceDescriptor: 'Encouraging milestone praise',
      greetingStyle: 'Congratulations {{parentName}},',
      closingStyle: 'Keep it up — Team Habot',
      maxExclamations: 1,
      allowEmoji: false,
    ),
    BrandTone.urgent: ToneBrandRule(
      tone: BrandTone.urgent,
      voiceDescriptor: 'Concise, action-oriented',
      greetingStyle: 'Hi {{parentName}}, quick update:',
      closingStyle: 'Action needed — Habot Support',
      maxExclamations: 0,
      allowEmoji: false,
    ),
  };
  static ToneBrandRule of(BrandTone tone) => rules[tone]!;
}

/// Enriched customer packet (atomic-level data fields).
@immutable
class CustomerPacket {
  final String parentName;
  final String specialistTag;
  final String milestoneScore;
  final String schoolName;
  final String billingPath;
  final String objectId;
  final DateTime creationDate;
  final String createdBy;
  final String creationMethod;
  final String initialConfiguration;
  const CustomerPacket({
    required this.parentName,
    required this.specialistTag,
    required this.milestoneScore,
    required this.schoolName,
    required this.billingPath,
    required this.objectId,
    required this.creationDate,
    required this.createdBy,
    required this.creationMethod,
    required this.initialConfiguration,
  });
  Map<String, String> toTokenMap() => {
        'parentName': parentName,
        'specialistTag': specialistTag,
        'milestoneScore': milestoneScore,
        'schoolName': schoolName,
        'billingPath': billingPath,
        'objectId': objectId,
      };
}

/// Result with mapping-accuracy metric (Floor 90%, Optimal 100%).
@immutable
class CompilationResult {
  final String output;
  final bool success;
  final List<String> missingTokens;
  final bool hasLeakedTokens;
  final int byteSize;
  final double mappingAccuracy;
  final String completionStatus;
  const CompilationResult({
    required this.output,
    required this.success,
    required this.missingTokens,
    required this.hasLeakedTokens,
    required this.byteSize,
    required this.mappingAccuracy,
    required this.completionStatus,
  });
}

/// Habot Central Communication String Compiler (pure Dart, <1s, <2KB).
final class TokenMappingTextCompiler {
  const TokenMappingTextCompiler._();
  static final RegExp tokenRegex = RegExp(r'\{\{\s*([a-zA-Z0-9_.]+)\s*\}\}');
  static const int maxBytes = 2048;
  static const String corporateMarker = '[Habot Verified]';

  static CompilationResult compile({
    required String template,
    required CustomerPacket packet,
    required BrandTone tone,
  }) {
    final values = packet.toTokenMap();
    final matches = tokenRegex.allMatches(template).toList();
    final referenced = matches.map((m) => m.group(1)!).toSet().toList();
    if (referenced.isEmpty) {
      final base = _applyBrandEnvelope(template, tone, packet);
      return _finalize(base, referenced, const [], values);
    }
    final missing = referenced.where((k) => !values.containsKey(k) || values[k]!.trim().isEmpty).toList();
    // Self-chasing rollback: block corrupted / incomplete layouts from rendering live.
    if (missing.isNotEmpty) {
      return CompilationResult(
        output: '',
        success: false,
        missingTokens: missing,
        hasLeakedTokens: true,
        byteSize: 0,
        mappingAccuracy: (referenced.length - missing.length) / referenced.length,
        completionStatus: 'Not Complete',
      );
    }
    var rendered = template;
    for (final key in referenced) {
      rendered = rendered.replaceAll(tokenRegexWithKey(key), values[key]!);
    }
    // Poka-Yoke: strict regex scan, block dispatch if raw bracket tokens leak.
    final leaked = tokenRegex.hasMatch(rendered);
    if (leaked) {
      return CompilationResult(
        output: '',
        success: false,
        missingTokens: referenced,
        hasLeakedTokens: true,
        byteSize: 0,
        mappingAccuracy: 0,
        completionStatus: 'Not Complete',
      );
    }
    final enveloped = _applyBrandEnvelope(rendered, tone, packet);
    return _finalize(enveloped, referenced, const [], values);
  }

  static RegExp tokenRegexWithKey(String key) => RegExp(r'\{\{\s*' + RegExp.escape(key) + r'\s*\}\}');

  static String _applyBrandEnvelope(String body, BrandTone tone, CustomerPacket packet) {
    final rule = BrandToneRuleMatrix.of(tone);
    var out = body.trim();
    // Enforce exclamation budget per brand matrix.
    final exclCount = RegExp(r'!').allMatches(out).length;
    if (exclCount > rule.maxExclamations) {
      var removed = 0;
      final toRemove = exclCount - rule.maxExclamations;
      out = out.replaceAllMapped(RegExp(r'!'), (m) {
        if (removed < toRemove) {
          removed++;
          return '.';
        }
        return '!';
      });
    }
    final tracking = 'tid:${packet.objectId}';
    return '$out\n${rule.closingStyle} $corporateMarker [$tracking]';
  }

  static CompilationResult _finalize(String output, List<String> referenced, List<String> missing, Map<String, String> values) {
    final bytes = utf8.encode(output).length;
    // Mobile-first: pack inside lightweight preference tokens under 2KB.
    final fits = bytes <= maxBytes;
    final accuracy = referenced.isEmpty ? 1.0 : (referenced.length - missing.length) / referenced.length;
    final status = !fits || missing.isNotEmpty ? 'Not Complete' : (accuracy >= 1.0 ? 'Complete' : (accuracy >= 0.9 ? 'Partial' : 'Not Complete'));
    return CompilationResult(
      output: fits ? output : '',
      success: fits && missing.isEmpty,
      missingTokens: missing,
      hasLeakedTokens: missing.isNotEmpty,
      byteSize: fits ? bytes : bytes,
      mappingAccuracy: accuracy,
      completionStatus: fits ? status : 'Not Complete',
    );
  }

  /// Packs compiled string for push / preference storage, enforces 2KB.
  static String packToPreferenceToken(String compiled) {
    final bytes = utf8.encode(compiled);
    if (bytes.length <= maxBytes) return compiled;
    var truncated = compiled;
    while (utf8.encode('$truncated…').length > maxBytes && truncated.isNotEmpty) {
      truncated = truncated.substring(0, truncated.length - 1);
    }
    return '$truncated…';
  }
}

/// M3 preview renderer module for internal campaign manager terminal.
class TextCompilerPreviewCard extends StatelessWidget {
  final String template;
  final CustomerPacket packet;
  final BrandTone tone;
  final CompilationResult? presetResult;
  const TextCompilerPreviewCard({super.key, required this.template, required this.packet, required this.tone, this.presetResult});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final result = presetResult ?? TokenMappingTextCompiler.compile(template: template, packet: packet, tone: tone);
    final ok = result.success;
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        // Comfortable padding framework for cross-device checks.
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Message preview', style: theme.textTheme.labelMedium),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                ok ? result.output : 'Blocked: ${result.missingTokens.join(', ')} missing — rollback engaged.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MetricChip(label: 'Accuracy ${(result.mappingAccuracy * 100).toStringAsFixed(0)}%'),
                _MetricChip(label: '${result.byteSize}B / 2048B'),
                _MetricChip(label: result.completionStatus),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: ok ? () => showDialog(context: context, builder: (_) => TextCompilerPreviewDialog(result: result, tone: tone)) : null,
                    style: FilledButton.styleFrom(textStyle: const TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w700)),
                    child: const Text('Preview'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: ok ? () {} : null,
                    style: OutlinedButton.styleFrom(textStyle: const TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w700)),
                    child: const Text('Approve'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  final String label;
  const _MetricChip({required this.label});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(label: Text(label, style: theme.textTheme.labelSmall), visualDensity: VisualDensity.compact);
  }
}

/// Material 3 Center Dialog overlay for text rendering check.
class TextCompilerPreviewDialog extends StatelessWidget {
  final CompilationResult result;
  final BrandTone tone;
  const TextCompilerPreviewDialog({super.key, required this.result, required this.tone});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rendering check — ${tone.name}', style: theme.textTheme.labelMedium),
              const SizedBox(height: 12),
              Text(result.output, style: theme.textTheme.bodyLarge),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                style: FilledButton.styleFrom(textStyle: const TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w700)),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
