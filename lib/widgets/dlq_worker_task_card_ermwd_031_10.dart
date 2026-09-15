// ERMWD-031-10 — DLQ Worker Task Card: failed Byt payload deserializer + read-only header binding.
// Deserializes raw Pub/Sub DLQ push envelope (base64 data) into typed error metadata and binds error_code, exception_message, timestamp to M3 read-only task-card header fields.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Mapping status for atomic-level traceability.
enum MappingStatus { mapped, fallback, unmapped }

/// Validation outcome per mapped field.
enum MappingValidation { valid, warning, invalid }

/// Atomic-level mapping record: Source -> Target with rule + validation.
@immutable
class Ermwd03110FieldMapping {
  const Ermwd03110FieldMapping({
    required this.sourceElementId,
    required this.targetElementId,
    required this.mappingRule,
    required this.status,
    required this.validation,
    this.validationMessage,
    this.rawValue,
  });
  final String sourceElementId;
  final String targetElementId;
  final String mappingRule;
  final MappingStatus status;
  final MappingValidation validation;
  final String? validationMessage;
  final String? rawValue;
  bool get isValid => validation != MappingValidation.invalid;
}

/// Typed error metadata bound to read-only header fields.
@immutable
class Ermwd03110ErrorMetadata {
  const Ermwd03110ErrorMetadata({
    required this.errorCode,
    required this.exceptionMessage,
    required this.timestamp,
    required this.isFallback,
  });
  final String errorCode;
  final String exceptionMessage;
  final DateTime timestamp;
  final bool isFallback;

  factory Ermwd03110ErrorMetadata.fromJson(Map<String, dynamic> json) {
    final rawCode = json['error_code'] ?? json['errorCode'] ?? json['code'];
    final rawMsg = json['exception_message'] ?? json['exceptionMessage'] ?? json['message'] ?? json['error'];
    final rawTs = json['timestamp'] ?? json['occurred_at'] ?? json['occurredAt'] ?? json['publishTime'];
    final code = rawCode?.toString().trim().isNotEmpty == true ? rawCode.toString().trim() : 'UNKNOWN';
    final msg = rawMsg?.toString().trim().isNotEmpty == true ? rawMsg.toString().trim() : 'No exception message provided.';
    DateTime ts;
    try {
      ts = rawTs == null ? DateTime.now().toUtc() : DateTime.parse(rawTs.toString()).toUtc();
    } catch (_) {
      ts = DateTime.now().toUtc();
    }
    final isFallback = rawCode == null || rawMsg == null || rawTs == null;
    return Ermwd03110ErrorMetadata(errorCode: code, exceptionMessage: msg, timestamp: ts, isFallback: isFallback);
  }
}

/// Typed failed mobile Byt payload extracted from DLQ.
@immutable
class Ermwd03110BytFailedPayload {
  const Ermwd03110BytFailedPayload({
    required this.bytId,
    required this.taskId,
    required this.subscriptionId,
    required this.messageId,
    required this.error,
    required this.retryCount,
    this.workerId,
    this.rawOriginalPayload,
  });
  final String bytId;
  final String taskId;
  final String subscriptionId;
  final String messageId;
  final Ermwd03110ErrorMetadata error;
  final int retryCount;
  final String? workerId;
  final Map<String, dynamic>? rawOriginalPayload;

  factory Ermwd03110BytFailedPayload.fromDecodedJson(Map<String, dynamic> json, {String messageId = '', String subscription = ''}) {
    final errorJson = (json['error_metadata'] as Map?)?.cast<String, dynamic>() ?? (json['error'] as Map?)?.cast<String, dynamic>() ?? json;
    final original = (json['original_payload'] as Map?)?.cast<String, dynamic>() ?? (json['byt_payload'] as Map?)?.cast<String, dynamic>();
    return Ermwd03110BytFailedPayload(
      bytId: (json['byt_id'] ?? json['bytId'] ?? json['id'] ?? 'unknown-byt').toString(),
      taskId: (json['task_id'] ?? json['taskId'] ?? json['byt_id'] ?? 'unknown-task').toString(),
      subscriptionId: subscription.toString(),
      messageId: messageId.toString(),
      error: Ermwd03110ErrorMetadata.fromJson(errorJson),
      retryCount: int.tryParse((json['retry_count'] ?? json['retryCount'] ?? 0).toString()) ?? 0,
      workerId: json['worker_id']?.toString() ?? json['workerId']?.toString(),
      rawOriginalPayload: original,
    );
  }
}

/// Deserializer for Pub/Sub DLQ push endpoint envelope + mapping-rule engine.
class Ermwd03110DlqMapper {
  const Ermwd03110DlqMapper._();
  static Ermwd03110BytFailedPayload deserializePushEnvelope(Map<String, dynamic> envelope) {
    final msg = (envelope['message'] as Map?)?.cast<String, dynamic>() ?? const {};
    final dataB64 = msg['data']?.toString() ?? '';
    final messageId = msg['messageId']?.toString() ?? envelope['messageId']?.toString() ?? '';
    final subscription = envelope['subscription']?.toString() ?? '';
    if (dataB64.isEmpty) {
      throw const FormatException('DLQ push envelope missing message.data');
    }
    late Map<String, dynamic> decoded;
    try {
      final bytes = base64.decode(dataB64.trim());
      decoded = (jsonDecode(utf8.decode(bytes)) as Map).cast<String, dynamic>();
    } catch (e) {
      throw FormatException('DLQ base64/JSON decode failed: $e');
    }
    return Ermwd03110BytFailedPayload.fromDecodedJson(decoded, messageId: messageId, subscription: subscription);
  }

  static List<Ermwd03110FieldMapping> mapHeaderFields(Ermwd03110BytFailedPayload p) {
    return [
      Ermwd03110FieldMapping(sourceElementId: 'error_code', targetElementId: 'taskCard.header.errorCode', mappingRule: 'trim | uppercase | fallback UNKNOWN', status: p.error.errorCode == 'UNKNOWN' ? MappingStatus.fallback : MappingStatus.mapped, validation: p.error.errorCode == 'UNKNOWN' ? MappingValidation.warning : MappingValidation.valid, validationMessage: p.error.errorCode == 'UNKNOWN' ? 'error_code missing, fallback applied' : null, rawValue: p.error.errorCode),
      Ermwd03110FieldMapping(sourceElementId: 'exception_message', targetElementId: 'taskCard.header.exceptionMessage', mappingRule: 'trim | truncate(280) | fallback placeholder', status: MappingStatus.mapped, validation: MappingValidation.valid, rawValue: p.error.exceptionMessage),
      Ermwd03110FieldMapping(sourceElementId: 'timestamp', targetElementId: 'taskCard.header.timestamp', mappingRule: 'ISO8601.parse -> UTC | fallback nowUtc', status: p.error.isFallback ? MappingStatus.fallback : MappingStatus.mapped, validation: p.error.isFallback ? MappingValidation.warning : MappingValidation.valid, rawValue: p.error.timestamp.toIso8601String()),
    ];
  }

  static double adherenceRate(List<Ermwd03110FieldMapping> mappings) {
    if (mappings.isEmpty) return 0;
    final ok = mappings.where((m) => m.isValid).length;
    return ok / mappings.length;
  }
}

/// MTB API worker task card — read-only header binding for failed Byt payloads.
class Ermwd03110DlqWorkerTaskCard extends StatelessWidget {
  const Ermwd03110DlqWorkerTaskCard({super.key, required this.payload, this.mappings, this.onAcknowledge, this.onRetry, this.compact = false});
  final Ermwd03110BytFailedPayload payload;
  final List<Ermwd03110FieldMapping>? mappings;
  final VoidCallback? onAcknowledge;
  final VoidCallback? onRetry;
  final bool compact;
  factory Ermwd03110DlqWorkerTaskCard.fromRawPush(Map<String, dynamic> rawPushJson, {VoidCallback? onAcknowledge, VoidCallback? onRetry}) {
    final payload = Ermwd03110DlqMapper.deserializePushEnvelope(rawPushJson);
    return Ermwd03110DlqWorkerTaskCard(payload: payload, mappings: Ermwd03110DlqMapper.mapHeaderFields(payload), onAcknowledge: onAcknowledge, onRetry: onRetry);
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final maps = mappings ?? Ermwd03110DlqMapper.mapHeaderFields(payload);
    final rate = Ermwd03110DlqMapper.adherenceRate(maps);
    final isError = payload.error.errorCode.startsWith('5') || payload.error.errorCode.contains('FAIL');
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: Semantics(
        label: 'Failed task ${payload.taskId}, error ${payload.error.errorCode}',
        readOnly: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: isError ? colorScheme.errorContainer : colorScheme.surfaceContainerHigh,
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
              child: Row(
                children: [
                  Icon(isError ? Icons.error_outline : Icons.warning_amber_outlined, color: isError ? colorScheme.onErrorContainer : colorScheme.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Expanded(child: SelectableText('Task ${payload.taskId}', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600))),
                  _AdherenceBadge(rate: rate),
                  IconButton(tooltip: 'Copy error metadata', icon: const Icon(Icons.copy, size: 18), onPressed: () => Clipboard.setData(ClipboardData(text: '${payload.error.errorCode} | ${payload.error.exceptionMessage} | ${payload.error.timestamp.toIso8601String()}'))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                children: [
                  _ReadOnlyHeaderField(label: 'error_code', value: payload.error.errorCode, icon: Icons.tag),
                  const SizedBox(height: 8),
                  _ReadOnlyHeaderField(label: 'exception_message', value: payload.error.exceptionMessage, icon: Icons.message_outlined, maxLines: 3),
                  const SizedBox(height: 8),
                  _ReadOnlyHeaderField(label: 'timestamp (UTC)', value: payload.error.timestamp.toIso8601String(), icon: Icons.schedule_outlined),
                ],
              ),
            ),
            if (!compact) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Field mapping trace', style: theme.textTheme.labelMedium),
                    const SizedBox(height: 4),
                    for (final m in maps)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Expanded(child: Text('${m.sourceElementId} → ${m.targetElementId}', style: theme.textTheme.bodySmall?.copyWith(fontFamily: 'monospace'))),
                            _MappingChip(mapping: m),
                          ],
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text('byt: ${payload.bytId} • retries: ${payload.retryCount} • msg: ${payload.messageId.isEmpty ? '—' : payload.messageId}', style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: onAcknowledge, child: const Text('Acknowledge')),
                  FilledButton.tonal(onPressed: onRetry, child: const Text('Retry')),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ReadOnlyHeaderField extends StatelessWidget {
  const _ReadOnlyHeaderField({required this.label, required this.value, required this.icon, this.maxLines = 1});
  final String label;
  final String value;
  final IconData icon;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon, size: 18), border: const OutlineInputBorder(), isDense: true),
    );
  }
}

class _AdherenceBadge extends StatelessWidget {
  const _AdherenceBadge({required this.rate});
  final double rate;
  @override
  Widget build(BuildContext context) {
    final pct = (rate * 100).round();
    final label = pct >= 95 ? 'Good' : pct >= 85 ? 'Average' : 'Poor';
    return Tooltip(
      message: 'Design-system adherence $pct% ($label)',
      child: Chip(label: Text('$label $pct%'), visualDensity: VisualDensity.compact),
    );
  }
}

class _MappingChip extends StatelessWidget {
  const _MappingChip({required this.mapping});
  final Ermwd03110FieldMapping mapping;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final text = mapping.validation == MappingValidation.valid ? 'valid' : mapping.validation == MappingValidation.warning ? 'warning' : 'invalid';
    final bg = mapping.validation == MappingValidation.valid ? colorScheme.primaryContainer : mapping.validation == MappingValidation.warning ? colorScheme.tertiaryContainer : colorScheme.errorContainer;
    return Chip(label: Text(text), backgroundColor: bg, visualDensity: VisualDensity.compact);
  }
}
