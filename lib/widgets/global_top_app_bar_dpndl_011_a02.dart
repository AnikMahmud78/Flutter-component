// DPNDL-011-A02 — Build Global Top Application Bar.
// Enforces a strict 64dp vertical layout limit, anchors leftmost navigation triggers,
// dynamically binds active location titles, and adds phantom target padding around vector actions.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Layout validation metrics for the Global Top App Bar.
class TopAppBarValidationMetrics {
  final String layoutType;
  final Size layoutGridDimensions;
  final double verticalLimit;
  final EdgeInsets spacingRules;
  final String layoutValidationStatus;
  final String completionStatus; // 'Good' | 'Average' | 'Poor'
  final DateTime timestamp;
  final String? userId;

  const TopAppBarValidationMetrics({
    required this.layoutType,
    required this.layoutGridDimensions,
    required this.verticalLimit,
    required this.spacingRules,
    required this.layoutValidationStatus,
    required this.completionStatus,
    required this.timestamp,
    this.userId,
  });

  Map<String, dynamic> toMap() => {
        'layoutType': layoutType,
        'layoutGridDimensions': '${layoutGridDimensions.width}x${layoutGridDimensions.height}',
        'verticalLimit': verticalLimit,
        'spacingRules': spacingRules.toString(),
        'layoutValidationStatus': layoutValidationStatus,
        'completionStatus': completionStatus,
        'timestamp': timestamp.toIso8601String(),
        'userId': userId ?? 'anonymous',
      };
}

/// Master Global Top Header Bar conforming to Material 3 and modern UI specifications.
///
/// Enforces:
/// - Strict 64dp vertical height limit.
/// - Leftmost navigation/drawer trigger frame with minimum 48x48dp phantom touch targets.
/// - Dynamic center title binding with overflow protection.
/// - Rightmost utility action zone with bounded horizontal spacing.
class GlobalTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Standard Material Design 3 top bar vertical limit.
  static const double kStrictHeightLimit = 64.0;
  static const double kMinTouchTargetSize = 48.0;

  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onMenuPressed;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final ValueChanged<TopAppBarValidationMetrics>? onLayoutValidated;
  final String? userId;

  const GlobalTopAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onMenuPressed,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0.0,
    this.onLayoutValidated,
    this.userId,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kStrictHeightLimit);

  void _reportLayoutStatus(BuildContext context, BoxConstraints constraints) {
    if (onLayoutValidated == null) return;

    final isHeightCompliant = constraints.maxHeight <= kStrictHeightLimit;
    final completionGrade = isHeightCompliant ? 'Good' : 'Average';

    final metrics = TopAppBarValidationMetrics(
      layoutType: 'GlobalTopAppBar',
      layoutGridDimensions: Size(constraints.maxWidth, kStrictHeightLimit),
      verticalLimit: kStrictHeightLimit,
      spacingRules: const EdgeInsets.symmetric(horizontal: 8.0),
      layoutValidationStatus: isHeightCompliant ? 'Compliant' : 'ExceedsHeightLimit',
      completionStatus: completionGrade,
      timestamp: DateTime.now(),
      userId: userId,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onLayoutValidated!(metrics);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveBgColor = backgroundColor ?? colorScheme.surface;
    final effectiveFgColor = foregroundColor ?? colorScheme.onSurface;

    return LayoutBuilder(
      builder: (context, constraints) {
        _reportLayoutStatus(context, constraints);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                ThemeData.estimateBrightnessForColor(effectiveBgColor) ==
                        Brightness.dark
                    ? Brightness.light
                    : Brightness.dark,
          ),
          child: Material(
            color: effectiveBgColor,
            elevation: elevation,
            surfaceTintColor: colorScheme.surfaceTint,
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: kStrictHeightLimit,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAlignment.center,
                    children: [
                      // Leftmost anchor: Sidebar menu trigger or custom leading
                      _buildLeadingFrame(context, effectiveFgColor),

                      const SizedBox(width: 8.0),

                      // Dynamic center view title anchor
                      Expanded(
                        child: _buildTitleFrame(context, effectiveFgColor),
                      ),

                      const SizedBox(width: 8.0),

                      // Rightmost utility action shortcut zone
                      if (actions != null && actions!.isNotEmpty)
                        _buildActionsFrame(context, effectiveFgColor),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeadingFrame(BuildContext context, Color fgColor) {
    if (leading != null) {
      return _wrapWithTouchTarget(leading!);
    }

    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;

    return _wrapWithTouchTarget(
      IconButton(
        icon: const Icon(Icons.menu_rounded),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        color: fgColor,
        onPressed: onMenuPressed ??
            () {
              if (hasDrawer) {
                scaffold?.openDrawer();
              } else {
                Navigator.maybePop(context);
              }
            },
      ),
    );
  }

  Widget _buildTitleFrame(BuildContext context, Color fgColor) {
    final textTheme = Theme.of(context).textTheme;

    final titleWidget = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: centerTitle ? TextAlign.center : TextAlign.start,
      style: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: fgColor,
        letterSpacing: 0.15,
      ),
    );

    if (subtitle == null) {
      return titleWidget;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          centerTitle ? CrossAlignment.center : CrossAlignment.start,
      children: [
        titleWidget,
        Text(
          subtitle!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.labelSmall?.copyWith(
            color: fgColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildActionsFrame(BuildContext context, Color fgColor) {
    return IconTheme(
      data: IconThemeData(color: fgColor, size: 24.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions!
            .map((action) => _wrapWithTouchTarget(action))
            .toList(),
      ),
    );
  }

  /// Injects phantom target padding ensuring minimum 48x48dp interactive bounds.
  Widget _wrapWithTouchTarget(Widget child) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: kMinTouchTargetSize,
        minHeight: kMinTouchTargetSize,
      ),
      child: Center(child: child),
    );
  }
}
