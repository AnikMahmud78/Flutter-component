import 'package:flutter/material.dart';

/// Universal Design System Tokens & Component Primitives
/// Package Reference: core.packages.universal_ui
class UniversalUiTheme {
  // Spacing Scale Tokens (HABOT 6-point spacing system)
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double space2Xl = 48.0;

  // Minimum Mobile Touch Target Size
  static const double minTouchTargetDp = 48.0;

  // Corner Radius Tokens
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusFull = 100.0;
}

/// Standardized Filled Button Primitive
class UniversalFilledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  const UniversalFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: UniversalUiTheme.minTouchTargetDp,
        minHeight: UniversalUiTheme.minTouchTargetDp,
      ),
      child: SizedBox(
        width: double.infinity,
        height: UniversalUiTheme.minTouchTargetDp,
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UniversalUiTheme.radiusFull),
            ),
          ),
          onPressed: isLoading ? null : onPressed,
          icon: isLoading
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.onPrimary,
                  ),
                )
              : Icon(icon ?? Icons.flash_on_rounded, size: 18),
          label: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

/// Standardized Universal Card Container
class UniversalSurfaceCard extends StatelessWidget {
  final Widget child;
  final Color? borderColor;

  const UniversalSurfaceCard({
    super.key,
    required this.child,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UniversalUiTheme.radiusMd),
        side: BorderSide(
          color: borderColor ?? theme.colorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(UniversalUiTheme.spaceMd),
        child: child,
      ),
    );
  }
}
