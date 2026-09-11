// CSIVW-003-A03 — Quantitative Rating Input Element with configurable step increment.
// Defines integer and half-step rating scales and blocks free-text entry through selection-only input.

import 'package:flutter/material.dart';

@immutable
class RatingStepIncrement {
  const RatingStepIncrement({
    this.min = 1,
    this.max = 5,
    this.step = 1,
  }) : assert(step > 0),
       assert(max >= min);

  final double min;
  final double max;
  final double step;

  List<double> get values {
    final out = <double>[];
    for (double value = min; value <= max + 1e-9; value += step) {
      out.add(_normalize(value));
    }
    return List<double>.unmodifiable(out);
  }

  double _normalize(double value) => double.parse(value.toStringAsFixed(10));

  String format(double value) {
    if ((value - value.roundToDouble()).abs() < 1e-9) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }
}

class QuantitativeRatingInput extends StatefulWidget {
  const QuantitativeRatingInput({
    super.key,
    required this.label,
    required this.onChanged,
    this.config = const RatingStepIncrement(),
    this.initialValue,
    this.enabled = true,
  });

  final String label;
  final RatingStepIncrement config;
  final double? initialValue;
  final ValueChanged<double?> onChanged;
  final bool enabled;

  @override
  State<QuantitativeRatingInput> createState() => _QuantitativeRatingInputState();
}

class _QuantitativeRatingInputState extends State<QuantitativeRatingInput> {
  double? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  bool _isSelected(double option) => _value != null && (_value! - option).abs() < 1e-9;

  void _select(double option) {
    if (!widget.enabled) return;
    setState(() => _value = option);
    widget.onChanged(option);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final options = widget.config.values;

    return FormField<double>(
      initialValue: _value,
      validator: (value) {
        if (value == null) return 'Please select a rating value.';
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.label, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in options)
                  ChoiceChip(
                    label: Text(widget.config.format(option)),
                    selected: _isSelected(option) || field.value == option,
                    onSelected: widget.enabled
                        ? (_) {
                            _select(option);
                            field.didChange(option);
                          }
                        : null,
                  ),
              ],
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  field.errorText!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
