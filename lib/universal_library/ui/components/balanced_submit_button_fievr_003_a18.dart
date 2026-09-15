// FIEVR-003-A18 — Balanced Submit Button (A-B=0 Disabled Logic).
// State-aware MD3 button that stays disabled at 38% opacity with no ripple until local A-B==0 check passes, then animates to primary fill.
import 'package:flutter/material.dart';

/// Pure, unit-testable balance logic for FIEVR-003-A18.
///
/// Covers zero (balanced), positive (A > B), and negative (A < B) results.
/// Use [BalanceValidator.isBalanced] as the single gate for button enablement
/// to avoid backend calls with unbalanced payloads.
class BalanceValidator {
  const BalanceValidator._();

  /// Tolerance for floating-point comparison. Defaults to 1e-9.
  static const double kEpsilon = 1e-9;

  /// Returns `a - b`. Zero means balanced.
  static double calculate(double a, double b) => a - b;

  /// Returns true only when `|a - b| <= epsilon`.
  static bool isBalanced(double a, double b, [double epsilon = kEpsilon]) {
    if (a.isNaN || b.isNaN) return false;
    if (a.isInfinite || b.isInfinite) return false;
    return (a - b).abs() <= epsilon;
  }

  /// Human-readable variance label for inline feedback.
  static String varianceLabel(double a, double b) {
    final v = calculate(a, b);
    if (isBalanced(a, b)) return 'Balanced • A-B = 0';
    final sign = v > 0 ? '+' : '';
    return 'Variance $sign${v.toStringAsFixed(2)} — adjust to balance';
  }
}

/// MD3 state-aware submit button gated by local `A-B == 0` verification.
///
/// - Default: disabled, unclickable (`onPressed: null`), 38% opacity, no hover/focus/ripple.
/// - Balanced: animates to primary fill and enables clicks.
/// - Rapid taps while unbalanced are impossible (no gesture handler attached).
class Fievr003A18BalancedSubmitButton extends StatelessWidget {
  const Fievr003A18BalancedSubmitButton({
    super.key,
    required this.valueA,
    required this.valueB,
    required this.onSubmit,
    this.label = 'Submit',
    this.epsilon = BalanceValidator.kEpsilon,
    this.showVarianceHint = true,
  });

  final double valueA;
  final double valueB;
  final VoidCallback onSubmit;
  final String label;
  final double epsilon;
  final bool showVarianceHint;

  bool get _balanced => BalanceValidator.isBalanced(valueA, valueB, epsilon);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final balanced = _balanced;

    // MD3 disabled tokens: muted gray surface at exactly 38% opacity.
    // Enabled tokens: primary fill with onPrimary content.
    final bg = balanced ? scheme.primary : scheme.onSurface.withOpacity(0.12);
    final fg = balanced
        ? scheme.onPrimary
        : scheme.onSurface.withOpacity(0.38);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
          ),
          // Opacity token: 38% on content layer when un-validated.
          child: Opacity(
            opacity: balanced ? 1.0 : 0.38,
            child: FilledButton(
              // Null disables natively: no click, no focus, no ripple.
              onPressed: balanced ? onSubmit : null,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return Colors.transparent;
                  }
                  return scheme.primary;
                }),
                foregroundColor: WidgetStateProperty.all(fg),
                // Complete removal of hover/focus/ripple feedback when disabled.
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return Colors.transparent;
                  }
                  return null;
                }),
                splashFactory: balanced ? InkSparkle.splashFactory : NoSplash.splashFactory,
                enableFeedback: balanced,
                animationDuration: const Duration(milliseconds: 250),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Row(
                  key: ValueKey<bool>(balanced),
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      balanced ? Icons.lock_open_rounded : Icons.lock_outline_rounded,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Flexible(child: Text(label)),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (showVarianceHint) ...[
          const SizedBox(height: 6),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: balanced ? scheme.primary : scheme.onSurfaceVariant,
                ),
            child: Semantics(
              liveRegion: true,
              child: Text(
                BalanceValidator.isBalanced(valueA, valueB, epsilon)
                    ? 'Ready — balances verified locally.'
                    : BalanceValidator.varianceLabel(valueA, valueB),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Mathematical validation form wrapper for reuse across forms/data streams.
///
/// Wraps any submit control and exposes [balanced] to builders so callers
/// never wire `onPressed` directly to unbalanced values.
class Fievr003A18BalanceGate extends StatelessWidget {
  const Fievr003A18BalanceGate({
    super.key,
    required this.valueA,
    required this.valueB,
    required this.builder,
    this.epsilon = BalanceValidator.kEpsilon,
  });

  final double valueA;
  final double valueB;
  final double epsilon;
  final Widget Function(BuildContext context, bool balanced, double variance) builder;

  @override
  Widget build(BuildContext context) {
    final variance = BalanceValidator.calculate(valueA, valueB);
    final balanced = BalanceValidator.isBalanced(valueA, valueB, epsilon);
    return builder(context, balanced, variance);
  }
}
