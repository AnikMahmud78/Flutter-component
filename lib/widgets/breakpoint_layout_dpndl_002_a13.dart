// DPNDL-002-A13 — Mobile-First Global Breakpoint Layout & Adaptive Window Classes.
// Implements Material 3 responsive window size classes (<600dp compact, 600-840dp medium, >=840dp expanded)
// with hardcoded 48x48dp touch boundaries, progressive disclosure of metrics, and automated layout validation.

import 'package:flutter/material.dart';

/// Window size classes conforming to Material Design Responsive Specifications.
enum WindowSizeClass {
  compact,
  medium,
  expanded,
}

/// Global design token constants for responsive boundaries and interactive hit targets.
class BreakpointTokens {
  const BreakpointTokens._();

  /// Root compact device baseline width (360dp).
  static const double rootCompactWidth = 360.0;

  /// Boundary where Compact transitions into Medium.
  static const double compactMax = 600.0;

  /// Boundary where Medium transitions into Expanded.
  static const double mediumMax = 840.0;

  /// Standard 12-column grid layout threshold.
  static const int desktopGridColumns = 12;
  static const int mobileGridColumns = 1;

  /// Interactive target boundaries ensuring accessibility on touch screens.
  static const double minTouchTargetMobile = 48.0;
  static const double minTouchTargetDesktop = 44.0;

  /// Maximum number of active metrics permitted on compact screens (Progressive Disclosure).
  static const int compactMaxMetrics = 3;
}

/// Layout validation result status for automated verification and CI gates.
enum LayoutValidationStatus {
  pass,
  fail,
}

/// Layout metadata snapshot matching GCP / BigQuery audit schema requirements.
class LayoutTelemetrySnapshot {
  final String layoutType;
  final Size gridDimensions;
  final double spacing;
  final Alignment alignment;
  final LayoutValidationStatus validationStatus;
  final DateTime timestamp;
  final String? userId;

  const LayoutTelemetrySnapshot({
    required this.layoutType,
    required this.gridDimensions,
    required this.spacing,
    required this.alignment,
    required this.validationStatus,
    required this.timestamp,
    this.userId,
  });

  Map<String, dynamic> toJson() => {
        'layoutType': layoutType,
        'gridDimensions': {
          'width': gridDimensions.width,
          'height': gridDimensions.height,
        },
        'spacing': spacing,
        'alignment': alignment.toString(),
        'layoutValidationStatus': validationStatus == LayoutValidationStatus.pass ? 'Pass' : 'Fail',
        'timestamp': timestamp.toIso8601String(),
        'userId': userId ?? 'anonymous',
      };
}

/// Resolves the current window size class from width.
WindowSizeClass resolveWindowSizeClass(double width) {
  if (width < BreakpointTokens.compactMax) {
    return WindowSizeClass.compact;
  } else if (width < BreakpointTokens.mediumMax) {
    return WindowSizeClass.medium;
  } else {
    return WindowSizeClass.expanded;
  }
}

/// Enforces minimum interactive touch target dimensions (48x48dp mobile, 44x44dp desktop).
class InteractiveBoundaryBox extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? minWidth;
  final double? minHeight;
  final String? semanticLabel;

  const InteractiveBoundaryBox({
    super.key,
    required this.child,
    this.onTap,
    this.minWidth,
    this.minHeight,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < BreakpointTokens.compactMax;
    final minTarget = isMobile ? BreakpointTokens.minTouchTargetMobile : BreakpointTokens.minTouchTargetDesktop;

    final effectiveMinWidth = minWidth ?? minTarget;
    final effectiveMinHeight = minHeight ?? minTarget;

    Widget interactive = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: effectiveMinWidth,
        minHeight: effectiveMinHeight,
      ),
      child: Center(child: child),
    );

    if (onTap != null) {
      interactive = InkWell(
        onTap: onTap,
        child: interactive,
      );
    }

    if (semanticLabel != null) {
      interactive = Semantics(
        label: semanticLabel,
        button: onTap != null,
        child: interactive,
      );
    }

    return interactive;
  }
}

/// Primary responsive scaffold implementing mobile-first transitions across 600dp and 840dp.
class ResponsiveBreakpointLayout extends StatelessWidget {
  final Widget title;
  final List<Widget> metrics;
  final Widget? analyticsTable;
  final Widget body;
  final List<NavigationDestination>? navigationItems;
  final int selectedNavIndex;
  final ValueChanged<int>? onNavIndexSelected;
  final VoidCallback? onLayoutValidated;

  const ResponsiveBreakpointLayout({
    super.key,
    required this.title,
    required this.metrics,
    required this.body,
    this.analyticsTable,
    this.navigationItems,
    this.selectedNavIndex = 0,
    this.onNavIndexSelected,
    this.onLayoutValidated,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final windowClass = resolveWindowSizeClass(width);
        final isCompact = windowClass == WindowSizeClass.compact;
        final isMedium = windowClass == WindowSizeClass.medium;

        // Progressive disclosure: restrict active details to 3 core metrics on mobile views (<600dp)
        final visibleMetrics = isCompact
            ? metrics.take(BreakpointTokens.compactMaxMetrics).toList()
            : metrics;

        // UX Decision: Completely hide advanced analytics tables below 600dp
        final shouldShowAnalytics = !isCompact && analyticsTable != null;

        return Scaffold(
          appBar: AppBar(
            title: title,
            centerTitle: isCompact,
            leading: isCompact && navigationItems != null && navigationItems!.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.menu),
                    tooltip: 'Navigation Menu',
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  )
                : null,
          ),
          bottomNavigationBar: isCompact && navigationItems != null && navigationItems!.isNotEmpty
              ? NavigationBar(
                  selectedIndex: selectedNavIndex,
                  onDestinationSelected: onNavIndexSelected,
                  destinations: navigationItems!,
                )
              : null,
          body: Row(
            children: [
              // Collapsible navigation rail for Medium and Expanded viewports
              if (!isCompact && navigationItems != null && navigationItems!.isNotEmpty)
                NavigationRail(
                  extended: !isMedium, // Collapsed on medium (600-840dp), full on expanded (>=840dp)
                  selectedIndex: selectedNavIndex,
                  onDestinationSelected: onNavIndexSelected,
                  labelType: isMedium
                      ? NavigationRailLabelType.selected
                      : NavigationRailLabelType.none,
                  destinations: navigationItems!
                      .map(
                        (dest) => NavigationRailDestination(
                          icon: dest.icon,
                          selectedIcon: dest.selectedIcon,
                          label: Text(dest.label),
                        ),
                      )
                      .toList(),
                ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isCompact ? 16.0 : 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Metrics card section (progressive disclosure)
                      _buildMetricsRow(visibleMetrics, isCompact),
                      const SizedBox(height: 24.0),
                      // Main body section
                      body,
                      // Advanced Analytics section (strictly hidden < 600dp)
                      if (shouldShowAnalytics) ...[
                        const SizedBox(height: 32.0),
                        const Divider(),
                        const SizedBox(height: 16.0),
                        analyticsTable!,
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetricsRow(List<Widget> activeMetrics, bool isCompact) {
    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: activeMetrics
            .map((m) => Padding(padding: const EdgeInsets.only(bottom: 8.0), child: m))
            .toList(),
      );
    }

    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: activeMetrics
          .map(
            (m) => ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 200, maxWidth: 300),
              child: m,
            ),
          )
          .toList(),
    );
  }

  /// Verification helper to test layout transitions at boundary dimensions (600dp and 840dp).
  static LayoutTelemetrySnapshot validateLayoutAtViewport({
    required double width,
    required double height,
    String? userId,
  }) {
    final windowClass = resolveWindowSizeClass(width);
    final isCompact = windowClass == WindowSizeClass.compact;
    final isMedium = windowClass == WindowSizeClass.medium;

    final layoutType = isCompact
        ? 'SingleColumn_MobileStack'
        : isMedium
            ? 'AdaptiveRail_Medium'
            : 'Fluid12Column_Expanded';

    // Verify constraints: compact must not breach 600 boundary without transition
    final isValid = (width < 600.0 && windowClass == WindowSizeClass.compact) ||
        (width >= 600.0 && width < 840.0 && windowClass == WindowSizeClass.medium) ||
        (width >= 840.0 && windowClass == WindowSizeClass.expanded);

    return LayoutTelemetrySnapshot(
      layoutType: layoutType,
      gridDimensions: Size(width, height),
      spacing: isCompact ? 16.0 : 24.0,
      alignment: Alignment.topLeft,
      validationStatus: isValid ? LayoutValidationStatus.pass : LayoutValidationStatus.fail,
      timestamp: DateTime.now().toUtc(),
      userId: userId,
    );
  }
}
