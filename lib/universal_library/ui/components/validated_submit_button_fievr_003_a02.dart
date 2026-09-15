// FIEVR-003-A02 — Validated Submit Button with A-B=0 Gate.
// State-aware MD3 button that stays disabled at 38% opacity until local A-B balance verifies, with smooth theme transition and zero backend calls.
import 'package:flutter/material.dart';

/// Token: exact 38% opacity for un-validated surfaces (MD3 disabled spec).
const double kUnvalidatedOpacityFievr003A02 = 0.38;

/// Token: smooth color transition to active brand theme when compliance passes.
const Duration kBalanceTransitionFievr003A02 = Duration(milliseconds: 250);

/// Atomic-level data field definition for A / B variables.
@immutable
class BalanceFieldDefinitionFievr003A02 {
  final String definitionId;
  final String definitionName;
  final String definitionType;
  final Map<String, Object?> definitionParameters;

  const BalanceFieldDefinitionFievr003A02({
    required this.definitionId,
    required this.definitionName,
    required this.definitionType,
    this.definitionParameters = const {},
  });
}

/// Local client-side A-B=0 check logic. No network / Cloud Run calls.
class ABBalanceGateFievr003A02 {
  const ABBalanceGateFievr003A02._();

  static double variance({required double valueA, required double valueB}) => valueA - valueB;

  static bool isBalanced({
    required double valueA,
    required double valueB,
    double tolerance = 0.0,
  }) {
    if (valueA.isNaN || valueB.isNaN) return false;
    if (valueA.isInfinite || valueB.isInfinite) return false;
    return (valueA - valueB).abs() <= tolerance.abs();
  }

  static String varianceLabel({required double valueA, required double valueB}) {
    final v = variance(valueA: valueA, valueB: valueB);
    if (v == 0) return 'Balanced • A-B=0';
    return v > 0 ? 'Over by ${v.toStringAsFixed(2)}' : 'Short by ${(-v).toStringAsFixed(2)}';
  }
}

/// Mathematical validation form wrapper component (reusable).
/// Provides [isBalanced] to descendants without any backend call.
class MathBalanceFormWrapperFievr003A02 extends StatelessWidget {
  final double valueA;
  final double valueB;
  final double tolerance;
  final BalanceFieldDefinitionFievr003A02 definitionA;
  final BalanceFieldDefinitionFievr003A02 definitionB;
  final Widget Function(BuildContext context, bool isBalanced, double variance) builder;

  const MathBalanceFormWrapperFievr003A02({
    super.key,
    required this.valueA,
    required this.valueB,
    required this.definitionA,
    required this.definitionB,
    required this.builder,
    this.tolerance = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final balanced = ABBalanceGateFievr003A02.isBalanced(
      valueA: valueA,
      valueB: valueB,
      tolerance: tolerance,
    );
    final v = ABBalanceGateFievr003A02.variance(valueA: valueA, valueB: valueB);
    return builder(context, balanced, v);
  }
}

/// State-aware MD3 primary submission button gated by A-B=0.
///
/// - Default: unclickable disabled, muted gray, 38% opacity, no hover/focus/ripple.
/// - Enabled: only when local [valueA]-[valueB]==0 within [tolerance].
/// - Smoothly transitions colors to primary theme fills when balanced.
class ValidatedSubmitButtonFievr003A02 extends StatelessWidget {
  final double valueA;
  final double valueB;
  final double tolerance;
  final BalanceFieldDefinitionFievr003A02 definitionA;
  final BalanceFieldDefinitionFievr003A02 definitionB;
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final bool showVarianceLabel;
  final FocusNode? focusNode;

  const ValidatedSubmitButtonFievr003A02({
    super.key,
    required this.valueA,
    required this.valueB,
    required this.definitionA,
    required this.definitionB,
    required this.onPressed,
    required this.label,
    this.tolerance = 0.0,
    this.isLoading = false,
    this.showVarianceLabel = true,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isBalanced = ABBalanceGateFievr003A02.isBalanced(
      valueA: valueA,
      valueB: valueB,
      tolerance: tolerance,
    );
    final canSubmit = isBalanced && !isLoading;
    final variance = ABBalanceGateFievr003A02.variance(valueA: valueA, valueB: valueB);

    // Poka-Yoke: onPressed is null when unbalanced -> physically impossible to click early.
    // Double-guard inside callback prevents rapid-hit bypass.
    final VoidCallback? effectiveOnPressed = canSubmit
        ? () {
            if (!ABBalanceGateFievr003A02.isBalanced(valueA: valueA, valueB: valueB, tolerance: tolerance)) return;
            onPressed?.call();
          }
        : null;

    final buttonStyle = ButtonStyle(
      // Smooth color transition handled by ButtonStyle animation + AnimatedOpacity below.
      animationDuration: kBalanceTransitionFievr003A02,
      // Complete removal of hover/focus/ripple feedback when disabled.
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return Colors.transparent;
        return null;
      }),
      splashFactory: NoSplash.splashFactory,
      mouseCursor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return SystemMouseCursors.basic;
        return SystemMouseCursors.click;
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return scheme.onSurface.withOpacity(0.12);
        return scheme.primary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return scheme.onSurface.withOpacity(kUnvalidatedOpacityFievr003A02);
        return scheme.onPrimary;
      }),
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return 0;
        return null;
      }),
    );

    return Semantics(
      button: true,
      enabled: canSubmit,
      label: '$label. ${ABBalanceGateFievr003A02.varianceLabel(valueA: valueA, valueB: valueB)}',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedOpacity(
            duration: kBalanceTransitionFievr003A02,
            opacity: canSubmit ? 1.0 : kUnvalidatedOpacityFievr003A02,
            child: AnimatedContainer(
              duration: kBalanceTransitionFievr003A02,
              curve: Curves.easeInOut,
              child: FilledButton(
                focusNode: focusNode,
                onPressed: effectiveOnPressed,
                style: buttonStyle,
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: scheme.onPrimary),
                      )
                    : Text(label),
              ),
            ),
          ),
          if (showVarianceLabel)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: AnimatedDefaultTextStyle(
                duration: kBalanceTransitionFievr003A02,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: isBalanced ? scheme.primary : scheme.onSurfaceVariant,
                ),
                child: Text(
                  isBalanced
                      ? 'Ready • A (${definitionA.definitionName}) - B (${definitionB.definitionName}) = 0'
                      : 'Awaiting balance • A-B=${variance.toStringAsFixed(2)} (A: ${definitionA.definitionName}, B: ${definitionB.definitionName})',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
