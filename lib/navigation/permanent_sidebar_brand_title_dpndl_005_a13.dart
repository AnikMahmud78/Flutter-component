// DPNDL-005-A13 — Permanent Sidebar Brand Title with Semantic Accessibility.
// Provides a fixed-footprint desktop sidebar header branding module with crisp vector/fallback
// rendering, layout buffer padding, accessibility semantics, and responsive viewport visibility.

import 'package:flutter/material.dart';

/// Audit metadata structure captured during integration and layout validation.
@immutable
class SidebarBrandAuditMetadata {
  final String? accessType;
  final String? userRole;
  final String? permissionLevel;
  final String? accessLog;
  final DateTime? accessTimestamp;

  const SidebarBrandAuditMetadata({
    this.accessType,
    this.userRole,
    this.permissionLevel,
    this.accessLog,
    this.accessTimestamp,
  });
}

/// Permanent sidebar brand title widget tailored for wide desktop navigation drawers.
/// Automatically manages responsive visibility, layout shift prevention (poka-yoke),
/// semantic accessibility headers, and graceful text fallbacks.
class PermanentSidebarBrandTitle extends StatelessWidget {
  /// Primary title or corporate name displayed in the identity block.
  final String title;

  /// Optional subtitle or organization department tag.
  final String? subtitle;

  /// Optional brand icon or crisp vector graphic widget.
  final Widget? logoWidget;

  /// Fallback graphic icon when no custom widget is provided.
  final IconData fallbackIcon;

  /// Screen width threshold (in pixels) below which the header is hidden on mobile.
  final double mobileBreakpoint;

  /// Fixed height allocated for the identity track to eliminate cumulative layout shifts.
  final double fixedHeight;

  /// Buffer padding separating the brand graphic/title from navigation items below.
  final EdgeInsetsGeometry padding;

  /// Accessible semantic label for assistive screen reader technology.
  final String? semanticAriaLabel;

  /// Callback triggered when the branding header anchor is tapped.
  final VoidCallback? onTap;

  /// Telemetry and audit compliance metadata.
  final SidebarBrandAuditMetadata? auditMetadata;

  const PermanentSidebarBrandTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.logoWidget,
    this.fallbackIcon = Icons.dashboard_customize_rounded,
    this.mobileBreakpoint = 1024.0,
    this.fixedHeight = 72.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.semanticAriaLabel,
    this.onTap,
    this.auditMetadata,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive viewport rule: completely hide on mobile/compact viewports to maximize screen room.
    if (screenWidth < mobileBreakpoint) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final String effectiveSemanticLabel = semanticAriaLabel ??
        (subtitle != null ? '$title - $subtitle' : title);

    return Semantics(
      header: true,
      container: true,
      label: effectiveSemanticLabel,
      hint: 'Permanent sidebar brand header',
      child: Container(
        height: fixedHeight,
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outlineVariant.withOpacity(0.4),
              width: 1.0,
            ),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Graphic Container with fixed bounding frame to prevent CLS
                SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: Center(
                    child: logoWidget ??
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            fallbackIcon,
                            size: 22.0,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                  ),
                ),
                const SizedBox(width: 12.0),
                // Textual Brand Identity
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 2.0),
                        Text(
                          subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
