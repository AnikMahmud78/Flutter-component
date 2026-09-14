// CSIVW-003-A11 — Quantitative Rating Input Element with Read-Only and Disabled States.
// Implements number-selection toggle arrays mapped to linear scales, providing distinct
// interactive hover/focus states when active and immutable visual feedback when disabled or read-only.

import 'package:flutter/material.dart';

/// Represents an execution record captured upon rating interaction or state changes.
class RatingStepOutcome {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final int? scoreValue;
  final String? userId;

  const RatingStepOutcome({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    this.scoreValue,
    this.userId,
  });

  Map<String, dynamic> toJson() => {
        'stepExecutionId': stepExecutionId,
        'executionStatus': executionStatus,
        'executionTimestamp': executionTimestamp.toIso8601String(),
        'scoreValue': scoreValue,
        'userId': userId,
      };
}

/// Production-ready quantitative rating input element supporting active, disabled,
/// and read-only presentation modes with linear score toggle mapping.
class QuantitativeRatingInput extends StatefulWidget {
  final int minScale;
  final int maxScale;
  final int? selectedScore;
  final bool isDisabled;
  final bool isReadOnly;
  final ValueChanged<int>? onRatingChanged;
  final ValueChanged<RatingStepOutcome>? onInteractionRecorded;
  final String? label;
  final String? stepExecutionId;
  final String? userId;

  const QuantitativeRatingInput({
    super.key,
    this.minScale = 1,
    this.maxScale = 5,
    this.selectedScore,
    this.isDisabled = false,
    this.isReadOnly = false,
    this.onRatingChanged,
    this.onInteractionRecorded,
    this.label,
    this.stepExecutionId,
    this.userId,
  }) : assert(minScale < maxScale, 'minScale must be strictly less than maxScale');

  @override
  State<QuantitativeRatingInput> createState() => _QuantitativeRatingInputState();
}

class _QuantitativeRatingInputState extends State<QuantitativeRatingInput> {
  int? _hoveredScore;
  int? _currentScore;

  @override
  void initState() {
    super.initState();
    _currentScore = widget.selectedScore;
  }

  @override
  void didUpdateWidget(covariant QuantitativeRatingInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedScore != widget.selectedScore) {
      setState(() {
        _currentScore = widget.selectedScore;
      });
    }
  }

  bool get _isInteractionBlocked => widget.isDisabled || widget.isReadOnly;

  void _handleSelection(int score) {
    if (_isInteractionBlocked) return;

    setState(() {
      _currentScore = score;
    });

    widget.onRatingChanged?.call(score);

    if (widget.onInteractionRecorded != null) {
      widget.onInteractionRecorded!(
        RatingStepOutcome(
          stepExecutionId: widget.stepExecutionId ?? 'CSIVW-003-A11-EXEC',
          executionStatus: 'Complete',
          executionTimestamp: DateTime.now().toUtc(),
          scoreValue: score,
          userId: widget.userId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveDisabledColor = colorScheme.onSurface.withValues(alpha: 0.38);
    final effectiveSelectedColor = _isInteractionBlocked
        ? colorScheme.outline
        : colorScheme.primary;

    return Semantics(
      container: true,
      readOnly: widget.isReadOnly,
      enabled: !widget.isDisabled,
      label: widget.label ?? 'Quantitative Rating Scale',
      value: _currentScore != null ? '$_currentScore' : 'Not rated',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            Row(
              children: [
                Text(
                  widget.label!,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: _isInteractionBlocked
                        ? effectiveDisabledColor
                        : colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.isReadOnly) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Read-only',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
          ],
          LayoutBuilder(
            builder: (context, constraints) {
              final totalItems = widget.maxScale - widget.minScale + 1;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.minWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(totalItems, (index) {
                      final score = widget.minScale + index;
                      final isSelected = _currentScore == score;
                      final isHovered = _hoveredScore == score && !_isInteractionBlocked;

                      Color backgroundColor;
                      Color foregroundColor;
                      BorderSide borderSide;

                      if (_isInteractionBlocked) {
                        if (isSelected) {
                          backgroundColor = colorScheme.surfaceContainerHighest;
                          foregroundColor = colorScheme.onSurfaceVariant;
                          borderSide = BorderSide(color: effectiveSelectedColor, width: 1.5);
                        } else {
                          backgroundColor = colorScheme.surface.withValues(alpha: 0.12);
                          foregroundColor = effectiveDisabledColor;
                          borderSide = BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.4));
                        }
                      } else if (isSelected) {
                        backgroundColor = colorScheme.primary;
                        foregroundColor = colorScheme.onPrimary;
                        borderSide = BorderSide(color: colorScheme.primary, width: 2);
                      } else if (isHovered) {
                        backgroundColor = colorScheme.primaryContainer.withValues(alpha: 0.3);
                        foregroundColor = colorScheme.primary;
                        borderSide = BorderSide(color: colorScheme.primary, width: 1.5);
                      } else {
                        backgroundColor = colorScheme.surface;
                        foregroundColor = colorScheme.onSurface;
                        borderSide = BorderSide(color: colorScheme.outline, width: 1);
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: MouseRegion(
                          cursor: _isInteractionBlocked
                              ? SystemMouseCursors.forbidden
                              : SystemMouseCursors.click,
                          onEnter: (_) {
                            if (!_isInteractionBlocked) {
                              setState(() => _hoveredScore = score);
                            }
                          },
                          onExit: (_) {
                            if (!_isInteractionBlocked) {
                              setState(() => _hoveredScore = null);
                            }
                          },
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: _isInteractionBlocked ? null : () => _handleSelection(score),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeInOut,
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.fromBorderSide(borderSide),
                                boxShadow: isHovered && !_isInteractionBlocked
                                    ? [
                                        BoxShadow(
                                          color: colorScheme.primary.withValues(alpha: 0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        )
                                      ]
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '$score',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: foregroundColor,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    }),
                  ),
                );
            },
          ),
        ],
      ),
    );
  }
}
