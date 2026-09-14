// DPNDL-002-A04 — Mobile-First Global Breakpoint Variable Set & Layout.
// Establishes Material 3 window size classes (Compact, Medium, Expanded) with compact 360dp pinned as the root token,
// responsive 12-column to 1-column fluid stacking, 48x48dp/44x44px minimum touch targets, and viewport conditional processing.

import 'package:flutter/material.dart';

/// Enumeration representing Material 3 window size classes.
enum WindowSizeClass {
  compact,
  medium,
  expanded,
}

/// Immutable specification defining layout parameters for a specific breakpoint.
@immutable
class BreakpointSpec {
  final WindowSizeClass sizeClass;
  final double minWidth;
  final double maxWidth;
  final int columnCount;
  final double gutter;
  final double margin;
  final double maxContentWidth;
  final bool allowAnalyticsTables;
  final int maxVisibleMetrics;
  final double minInteractiveTarget;

  const BreakpointSpec({
    required this.sizeClass,
    required this.minWidth,
    required this.maxWidth,
    required this.columnCount,
    required this.gutter,
    required this.margin,
    required this.maxContentWidth,
    required this.allowAnalyticsTables,
    required this.maxVisibleMetrics,
    required this.minInteractiveTarget,
  });
}

/// Global design token library for breakpoints, grid metrics, and touch targets.
abstract final class AppBreakpoints {
  /// Absolute root design token for mobile-first views.
  static const double compactRootWidth = 360.0;
  static const double mediumBreakpoint = 600.0;
  static const double expandedBreakpoint = 840.0;
  static const double desktopBreakpoint = 1200.0;
  static const double maxDesktopContainerWidth = 1440.0;

  /// Touch target constraints for accessible mobile interaction.
  static const double minTouchTargetCompact = 44.0;
  static const double minTouchTargetStandard = 48.0;
  static const BoxConstraints touchTargetConstraint = BoxConstraints(
    minWidth: minTouchTargetStandard,
    minHeight: minTouchTargetStandard,
  );

  /// Layout parameter specifications per window class.
  static const BreakpointSpec compactSpec = BreakpointSpec(
    sizeClass: WindowSizeClass.compact,
    minWidth: 0.0,
    maxWidth: 599.9,
    columnCount: 1,
    gutter: 16.0,
    margin: 16.0,
    maxContentWidth: compactRootWidth,
    allowAnalyticsTables: false,
    maxVisibleMetrics: 3,
    minInteractiveTarget: minTouchTargetCompact,
  );

  static const BreakpointSpec mediumSpec = BreakpointSpec(
    sizeClass: WindowSizeClass.medium,
    minWidth: 600.0,
    maxWidth: 839.9,
    columnCount: 8,
    gutter: 24.0,
    margin: 24.0,
    maxContentWidth: 840.0,
    allowAnalyticsTables: true,
    maxVisibleMetrics: 6,
    minInteractiveTarget: minTouchTargetStandard,
  );

  static const BreakpointSpec expandedSpec = BreakpointSpec(
    sizeClass: WindowSizeClass.expanded,
    minWidth: 840.0,
    maxWidth: double.infinity,
    columnCount: 12,
    gutter: 24.0,
    margin: 32.0,
    maxContentWidth: maxDesktopContainerWidth,
    allowAnalyticsTables: true,
    maxVisibleMetrics: 12,
    minInteractiveTarget: minTouchTargetStandard,
  );

  /// Resolves the current [BreakpointSpec] based on width.
  static BreakpointSpec resolve(double width) {
    if (width < mediumBreakpoint) {
      return compactSpec;
    } else if (width < expandedBreakpoint) {
      return mediumSpec;
    } else {
      return expandedSpec;
    }
  }

  /// Resolves the [BreakpointSpec] directly from [BuildContext].
  static BreakpointSpec of(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return resolve(width);
  }
}

/// Audit and metadata tracking model for design system compliance.
@immutable
class BreakpointAuditRecord {
  final String layoutType;
  final Map<String, dynamic> gridDimensions;
  final Map<String, dynamic> spacingRules;
  final Alignment alignmentSettings;
  final String layoutValidationStatus;
  final String completionStatus;
  final DateTime timestamp;
  final String? userSessionId;

  BreakpointAuditRecord({
    required this.layoutType,
    required this.gridDimensions,
    required this.spacingRules,
    required this.alignmentSettings,
    required this.layoutValidationStatus,
    this.completionStatus = 'Complete (Scale: Complete/Partial/Not Complete)',
    DateTime? timestamp,
    this.userSessionId,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toTelemetryMap() => <String, dynamic>{
        'layout_type': layoutType,
        'grid_dimensions': gridDimensions,
        'spacing_rules': spacingRules,
        'alignment': 'Alignment(${alignmentSettings.x}, ${alignmentSettings.y})',
        'layout_validation_status': layoutValidationStatus,
        'completion_status': completionStatus,
        'timestamp': timestamp.toIso8601String(),
        'user_session_id': userSessionId ?? 'system',
      };
}

/// Responsive container widget applying breakpoint margins, gutters, and max-width clamping.
class ResponsiveLayoutContainer extends StatelessWidget {
  final Widget child;
  final Alignment alignment;

  const ResponsiveLayoutContainer({
    super.key,
    required this.child,
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    final BreakpointSpec spec = AppBreakpoints.of(context);

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: spec.maxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spec.margin),
          child: child,
        ),
      ),
    );
  }
}

/// Adaptive layout builder switching between mobile single-column summary stack
/// and desktop 12-column grid based on active breakpoint.
class MobileFirstAdaptiveLayout extends StatelessWidget {
  final Widget Function(BuildContext context, BreakpointSpec spec) mobileBuilder;
  final Widget Function(BuildContext context, BreakpointSpec spec)? tabletBuilder;
  final Widget Function(BuildContext context, BreakpointSpec spec) desktopBuilder;

  const MobileFirstAdaptiveLayout({
    super.key,
    required this.mobileBuilder,
    this.tabletBuilder,
    required this.desktopBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final BreakpointSpec spec = AppBreakpoints.of(context);

    switch (spec.sizeClass) {
      case WindowSizeClass.compact:
        return mobileBuilder(context, spec);
      case WindowSizeClass.medium:
        return (tabletBuilder ?? desktopBuilder)(context, spec);
      case WindowSizeClass.expanded:
        return desktopBuilder(context, spec);
    }
  }
}

/// Interactive wrapper ensuring tap targets honor the 48x48dp mobile boundary.
class AccessibleTouchTarget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double minSize;

  const AccessibleTouchTarget({
    super.key,
    required this.child,
    this.onTap,
    this.minSize = AppBreakpoints.minTouchTargetStandard,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minSize,
          minHeight: minSize,
        ),
        child: Center(child: child),
      ),
    );
  }
}
