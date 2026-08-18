// Location: lib/widgets/isolated_byt_component.dart
import 'package:flutter/material.dart';
import '../models/isolated_byt_state_model.dart';

/// Self-contained Component managing local M3 states (Hover, Focus, Pressed)
/// with zero global state mutations.
class IsolatedBytComponent extends StatefulWidget {
  final BytStateRecord record;
  final ValueChanged<BytStateRecord> onStateChanged;

  const IsolatedBytComponent({
    super.key,
    required this.record,
    required this.onStateChanged,
  });

  @override
  State<IsolatedBytComponent> createState() => _IsolatedBytComponentState();
}

class _IsolatedBytComponentState extends State<IsolatedBytComponent> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (mounted) {
        setState(() => _isFocused = _focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = widget.record.isSelected;

    return Focus(
      focusNode: _focusNode,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer
                : (_isHovered
                      ? colorScheme.surfaceContainerHigh
                      : colorScheme.surface),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: _isFocused
                  ? colorScheme.primary
                  : (isSelected
                        ? colorScheme.primary
                        : colorScheme.outlineVariant),
              width: _isFocused ? 2.0 : 1.0,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {
                // Pure state update (immutable clone dispatch)
                final updated = widget.record.copyWith(isSelected: !isSelected);
                widget.onStateChanged(updated);
              },
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 56.0, // HABOT touch target & spacing baseline
                  minWidth: 48.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_rounded,
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                        size: 22,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.record.displayLabel,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: isSelected
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Byt ID: ${widget.record.bytId} ➔ Field: ${widget.record.destinationField}',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_isFocused || _isHovered)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _isFocused ? 'FOCUS' : 'HOVER',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSecondaryContainer,
                            ),
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
