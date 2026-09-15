// ERMWD-026 — Contractor Binary Confirmation Panel, thumb-reach binary actions.
// Singular-selection bottom block with outlined instruction box, grid dividers and instant visual confirmation for MTO contractors.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Binary decision for contractor task confirmation.
enum ContractorDecision { none, confirmed, declined }

/// Displays simple binary confirmation buttons within easy thumb reach.
///
/// Meets ERMWD-026 mobile UX: singular selection block, structural grid
/// lines, outlined instruction label, and immediate visual confirmation.
/// Designed for bottom placement to protect view space and thumb ergonomics.
class ContractorBinaryConfirmPanel extends StatefulWidget {
  const ContractorBinaryConfirmPanel({
    super.key,
    required this.instructionText,
    this.confirmLabel = 'Accept Task',
    this.declineLabel = 'Decline',
    this.initialDecision = ContractorDecision.none,
    this.enabled = true,
    this.isSecure = true,
    this.onDecisionChanged,
  });

  final String instructionText;
  final String confirmLabel;
  final String declineLabel;
  final ContractorDecision initialDecision;
  final bool enabled;
  final bool isSecure;
  final ValueChanged<ContractorDecision>? onDecisionChanged;

  /// Shows panel as thumb-reach bottom sheet.
  static Future<ContractorDecision?> showAsBottomSheet(
    BuildContext context, {
    required String instructionText,
    String confirmLabel = 'Accept Task',
    String declineLabel = 'Decline',
  }) {
    return showModalBottomSheet<ContractorDecision>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (ctx) => SingleChildScrollView(
        child: ContractorBinaryConfirmPanel(
          instructionText: instructionText,
          confirmLabel: confirmLabel,
          declineLabel: declineLabel,
          onDecisionChanged: (d) => Navigator.of(ctx).pop(d),
        ),
      ),
    );
  }

  @override
  State<ContractorBinaryConfirmPanel> createState() =>
      _ContractorBinaryConfirmPanelState();
}

class _ContractorBinaryConfirmPanelState
    extends State<ContractorBinaryConfirmPanel> {
  late ContractorDecision _decision;

  @override
  void initState() {
    super.initState();
    _decision = widget.initialDecision;
  }

  void _select(ContractorDecision next) {
    if (!widget.enabled) return;
    if (_decision == next) return;
    HapticFeedback.selectionClick();
    setState(() => _decision = next);
    widget.onDecisionChanged?.call(next);
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.hideCurrentSnackBar();
    messenger?.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              next == ContractorDecision.confirmed
                  ? Icons.check_circle
                  : Icons.cancel,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                next == ContractorDecision.confirmed
                    ? 'Confirmed: ${widget.confirmLabel}'
                    : 'Declined: ${widget.declineLabel}',
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.isSecure)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.lock, size: 14, color: scheme.outline),
                  const SizedBox(width: 4),
                  Text(
                    'Encrypted',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: scheme.outline,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: scheme.primary, width: 2),
                borderRadius: BorderRadius.circular(12),
                color: scheme.primaryContainer.withOpacity(0.25),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: scheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.instructionText,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: scheme.outlineVariant),
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: scheme.outlineVariant,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: _buildDeclineButton(context)),
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: scheme.outlineVariant,
                        ),
                        Expanded(child: _buildConfirmButton(context)),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: scheme.outlineVariant,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _decision == ContractorDecision.none
                  ? Text(
                      'Tap one option to continue',
                      key: const ValueKey('hint'),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.outline,
                      ),
                    )
                  : Row(
                      key: const ValueKey('confirmed'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _decision == ContractorDecision.confirmed
                              ? Icons.check_circle
                              : Icons.remove_circle,
                          size: 16,
                          color: _decision == ContractorDecision.confirmed
                              ? scheme.primary
                              : scheme.error,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _decision == ContractorDecision.confirmed
                              ? 'Selection confirmed'
                              : 'Selection recorded',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: _decision == ContractorDecision.confirmed
                                ? scheme.primary
                                : scheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeclineButton(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final selected = _decision == ContractorDecision.declined;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      color: selected ? scheme.errorContainer : Colors.transparent,
      child: SizedBox(
        height: 60,
        child: OutlinedButton.icon(
          onPressed: widget.enabled ? () => _select(ContractorDecision.declined) : null,
          icon: Icon(selected ? Icons.close : Icons.close_outlined, size: 22),
          label: Text(widget.declineLabel),
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            side: BorderSide.none,
            foregroundColor: selected ? scheme.onErrorContainer : scheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final selected = _decision == ContractorDecision.confirmed;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      color: selected ? scheme.primaryContainer : scheme.primary.withOpacity(0.06),
      child: SizedBox(
        height: 60,
        child: FilledButton.icon(
          onPressed: widget.enabled ? () => _select(ContractorDecision.confirmed) : null,
          icon: AnimatedScale(
            scale: selected ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 180),
            child: Icon(selected ? Icons.check_circle : Icons.check, size: 22),
          ),
          label: Text(widget.confirmLabel),
          style: FilledButton.styleFrom(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
      ),
    );
  }
}
