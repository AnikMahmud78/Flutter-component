// FIEVR-014 — Form Field Analytics Wrapper (Focus, Latency & Backspace Instrumentation).
// A core UI framework wrapper that maps focus events, keystroke latency, and backspace
// analytics parameters onto any input field, emitting structured events for the data pipeline.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Types of analytics events captured by [FormFieldAnalyticsWrapper].
enum FieldAnalyticsEventType {
  focusGained,
  focusLost,
  keystrokeLatency,
  backspace,
  fieldCompleted,
}

/// Immutable analytics payload emitted for every instrumented interaction.
@immutable
class FieldAnalyticsEvent {
  const FieldAnalyticsEvent({
    required this.type,
    required this.fieldKey,
    required this.timestamp,
    this.latencyMs,
    this.backspaceCount,
    this.sessionId,
    this.metadata,
  });

  final FieldAnalyticsEventType type;
  final String fieldKey;
  final DateTime timestamp;

  /// Milliseconds elapsed since the previous keystroke (for [keystrokeLatency]).
  final int? latencyMs;

  /// Running total of backspace presses observed on this field.
  final int? backspaceCount;

  /// Optional user/session identifier attached by the host app.
  final String? sessionId;

  /// Free-form extra context (e.g. object path, screen route).
  final Map<String, Object?>? metadata;

  Map<String, Object?> toJson() => <String, Object?>{
        'type': type.name,
        'fieldKey': fieldKey,
        'timestamp': timestamp.toIso8601String(),
        if (latencyMs != null) 'latencyMs': latencyMs,
        if (backspaceCount != null) 'backspaceCount': backspaceCount,
        if (sessionId != null) 'sessionId': sessionId,
        if (metadata != null) 'metadata': metadata,
      };
}

/// Signature for the analytics sink that receives [FieldAnalyticsEvent]s.
typedef FieldAnalyticsSink = void Function(FieldAnalyticsEvent event);

/// A Material 3 compliant wrapper that instruments an input field with
/// focus tracking, keystroke-latency measurement, and backspace detection.
///
/// Usage:
/// ```dart
/// FormFieldAnalyticsWrapper(
///   fieldKey: 'email',
///   onAnalyticsEvent: AnalyticsService.instance.record,
///   builder: (context, controller, focusNode) => TextFormField(
///     controller: controller,
///     focusNode: focusNode,
///     decoration: const InputDecoration(labelText: 'Email'),
///   ),
/// )
/// ```
class FormFieldAnalyticsWrapper extends StatefulWidget {
  const FormFieldAnalyticsWrapper({
    super.key,
    required this.fieldKey,
    required this.builder,
    this.onAnalyticsEvent,
    this.sessionId,
    this.controller,
    this.focusNode,
    this.latencySampleEvery = 1,
    this.metadata,
  }) : assert(latencySampleEvery > 0, 'latencySampleEvery must be >= 1');

  /// Stable identifier for the instrumented field (used in every event).
  final String fieldKey;

  /// Builds the actual input using the provided controller and focus node so
  /// the wrapper can observe text and focus changes.
  final Widget Function(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
  ) builder;

  /// Sink receiving all analytics events. If null, events are silently dropped.
  final FieldAnalyticsSink? onAnalyticsEvent;

  /// Optional session/user id attached to every emitted event.
  final String? sessionId;

  /// Externally supplied controller/focus node; the wrapper creates its own
  /// when these are omitted (and disposes only what it created).
  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// Emit a latency event every N keystrokes (1 = every keystroke).
  final int latencySampleEvery;

  /// Extra context merged into every event payload.
  final Map<String, Object?>? metadata;

  @override
  State<FormFieldAnalyticsWrapper> createState() =>
      _FormFieldAnalyticsWrapperState();
}

class _FormFieldAnalyticsWrapperState extends State<FormFieldAnalyticsWrapper> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final bool _ownsController;
  late final bool _ownsFocusNode;

  DateTime? _lastKeystrokeAt;
  int _keystrokeCount = 0;
  int _backspaceCount = 0;
  int _previousTextLength = 0;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _ownsFocusNode = widget.focusNode == null;
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _previousTextLength = _controller.text.length;

    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _controller.removeListener(_handleTextChange);
    if (_ownsFocusNode) _focusNode.dispose();
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  void _emit(FieldAnalyticsEventType type, {int? latencyMs}) {
    final sink = widget.onAnalyticsEvent;
    if (sink == null) return;
    sink(
      FieldAnalyticsEvent(
        type: type,
        fieldKey: widget.fieldKey,
        timestamp: DateTime.now().toUtc(),
        latencyMs: latencyMs,
        backspaceCount:
            type == FieldAnalyticsEventType.backspace ? _backspaceCount : null,
        sessionId: widget.sessionId,
        metadata: widget.metadata,
      ),
    );
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _lastKeystrokeAt = null;
      _emit(FieldAnalyticsEventType.focusGained);
    } else {
      _emit(FieldAnalyticsEventType.focusLost);
      if (_controller.text.trim().isNotEmpty) {
        _emit(FieldAnalyticsEventType.fieldCompleted);
      }
    }
  }

  void _handleTextChange() {
    final now = DateTime.now().toUtc();
    final currentLength = _controller.text.length;

    // Backspace detection: text shrank without a selection replacement.
    if (currentLength < _previousTextLength) {
      _backspaceCount += _previousTextLength - currentLength;
      _emit(FieldAnalyticsEventType.backspace);
    }
    _previousTextLength = currentLength;

    // Keystroke latency: delta from the previous keystroke, sampled.
    _keystrokeCount++;
    final last = _lastKeystrokeAt;
    _lastKeystrokeAt = now;
    if (last != null &&
        _keystrokeCount % widget.latencySampleEvery == 0) {
      _emit(
        FieldAnalyticsEventType.keystrokeLatency,
        latencyMs: now.difference(last).inMilliseconds,
      );
    }
  }

  /// Hardware-key fallback for backspace detection on platforms where the
  /// controller diff is unreliable (e.g. some Android IMEs).
  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      // Counted here only when the text did not change (empty field edge case).
      if (_controller.text.isEmpty) {
        _backspaceCount++;
        _emit(FieldAnalyticsEventType.backspace);
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: _handleKeyEvent,
      child: widget.builder(context, _controller, _focusNode),
    );
  }
}
