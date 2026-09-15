// ERMWD-024-A03 — MTOI Single-Action Mobile Interface.
// Centered 8dp ElevatedCard with cropped image + single masked input and full-width submit; 1 Screen = 1 Task reflex flow.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Spacing / Padding Grid Compliance (4pt-8pt baseline).
/// Floor=4, Optimal=8, Ceiling=24. All paddings must be multiples of 4.
class MtoiSpacing {
  static const double unit = 4.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s16 = 16.0;
  static const double s24 = 24.0;
  static const double maxCardWidth = 420.0;
  static const double submitHeight = 56.0;
}

/// Atomic-level execution payload for dashboard velocity/accuracy tracking.
class MtoiTaskExecutionPayload {
  final String stepExecutionId;
  final String userId;
  final DateTime executionTimestamp;
  final String executionStatus;
  final String stepOutcome;
  final String completionStatus;
  final Duration elapsed;

  const MtoiTaskExecutionPayload({
    required this.stepExecutionId,
    required this.userId,
    required this.executionTimestamp,
    required this.executionStatus,
    required this.stepOutcome,
    required this.completionStatus,
    required this.elapsed,
  });
}

/// MTOI Single-Action Mobile Interface — 1 Screen = 1 Task.
///
/// Enforces zero decision-making: cropped visual snippet -> single masked
/// input -> massive primary submit. Submit stays disabled until mask is met
/// (poka-yoke + self-chasing). Reused for every MTOI task.
class MtoiSingleActionTaskScreen extends StatefulWidget {
  final ImageProvider image;
  final String taskLabel;
  final String hintText;
  final String stepExecutionId;
  final String userId;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final RegExp validMask;
  final int? maxLength;
  final ValueChanged<MtoiTaskExecutionPayload>? onSubmit;
  final String submitLabel;

  const MtoiSingleActionTaskScreen({
    super.key,
    required this.image,
    required this.taskLabel,
    required this.stepExecutionId,
    required this.userId,
    required this.validMask,
    this.hintText = 'Enter value',
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.maxLength,
    this.onSubmit,
    this.submitLabel = 'Submit',
  });

  @override
  State<MtoiSingleActionTaskScreen> createState() =>
      _MtoiSingleActionTaskScreenState();
}

class _MtoiSingleActionTaskScreenState
    extends State<MtoiSingleActionTaskScreen> {
  late final TextEditingController _controller;
  late final DateTime _startTime;
  bool _isValid = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    final trimmed = value.trim();
    final valid =
        trimmed.isNotEmpty && widget.validMask.hasMatch(trimmed);
    setState(() {
      _isValid = valid;
      _error = trimmed.isEmpty
          ? null
          : (valid ? null : 'Does not match required format');
    });
  }

  void _handleSubmit() {
    if (!_isValid) return;
    final now = DateTime.now();
    final payload = MtoiTaskExecutionPayload(
      stepExecutionId: widget.stepExecutionId,
      userId: widget.userId,
      executionTimestamp: now,
      executionStatus: 'COMPLETED',
      stepOutcome: _controller.text.trim(),
      completionStatus: 'Complete',
      elapsed: now.difference(_startTime),
    );
    widget.onSubmit?.call(payload);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task submitted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(MtoiSpacing.s16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: MtoiSpacing.maxCardWidth,
              ),
              child: Card(
                elevation: 8.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MtoiSpacing.s16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(MtoiSpacing.s16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.taskLabel,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: MtoiSpacing.s16),
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(MtoiSpacing.s12),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image(
                            image: widget.image,
                            fit: BoxFit.cover,
                            semanticLabel: 'Cropped task snippet',
                            errorBuilder: (c, e, s) => Container(
                              color: theme.colorScheme.surfaceContainerHigh,
                              child: const Center(
                                child: Icon(Icons.image_outlined, size: 48),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: MtoiSpacing.s16),
                      TextField(
                        controller: _controller,
                        keyboardType: widget.keyboardType,
                        inputFormatters: widget.inputFormatters,
                        maxLength: widget.maxLength,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        textInputAction: TextInputAction.done,
                        onChanged: _onChanged,
                        onSubmitted: (_) => _handleSubmit(),
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          errorText: _error,
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: MtoiSpacing.s16,
                            vertical: MtoiSpacing.s12,
                          ),
                          suffixIcon: _isValid
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : null,
                        ),
                      ),
                      const SizedBox(height: MtoiSpacing.s16),
                      SizedBox(
                        height: MtoiSpacing.submitHeight,
                        child: FilledButton(
                          onPressed: _isValid ? _handleSubmit : null,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(
                                MtoiSpacing.submitHeight),
                            textStyle: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: Text(widget.submitLabel),
                        ),
                      ),
                      const SizedBox(height: MtoiSpacing.s8),
                      Text(
                        '1 Screen = 1 Task • Mask enforced',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
