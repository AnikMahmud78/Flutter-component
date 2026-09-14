// DPNDL-008-A15 — Permanent Desktop Navigation Drawer.
// Enforces a strict 256dp static horizontal layout frame for desktop viewports,
// providing multi-tier section maps with collapsible accordion navigation items and active state indicators.

import 'package:flutter/material.dart';

/// Audit and verification data model tracking navigation mapping telemetry.
class NavigationMappingAudit {
  final String sourceElementId;
  final String targetElementId;
  final String mappingRule;
  final String mappingStatus;
  final bool isMappingValid;
  final DateTime timestamp;

  const NavigationMappingAudit({
    required this.sourceElementId,
    required this.targetElementId,
    required this.mappingRule,
    required this.mappingStatus,
    required this.isMappingValid,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
        'sourceElementId': sourceElementId,
        'targetElementId': targetElementId,
        'mappingRule': mappingRule,
        'mappingStatus': mappingStatus,
        'mappingValidation': isMappingValid,
        'timestamp': timestamp.toIso8601String(),
      };
}

/// Child item representing a concrete navigation endpoint within an accordion section.
class NavigationChildTarget {
  final String id;
  final String label;
  final String route;
  final IconData? icon;
  final String? subtitle;

  const NavigationChildTarget({
    required this.id,
    required this.label,
    required this.route,
    this.icon,
    this.subtitle,
  });
}

/// Tier-1 navigation track with collapsible accordion child targets.
class NavigationSectionMap {
  final String id;
  final String title;
  final IconData leadingIcon;
  final List<NavigationChildTarget> children;
  final bool initiallyExpanded;

  const NavigationSectionMap({
    required this.id,
    required this.title,
    required this.leadingIcon,
    required this.children,
    this.initiallyExpanded = false,
  });
}

/// Production-grade permanent desktop drawer conforming to DPNDL-008-A15.
/// Fixes width strictly to 256dp and prevents accidental dismiss on desktop layouts.
class PermanentDesktopDrawerDpndl008A15 extends StatefulWidget {
  /// Strict horizontal dimension mandated by Google Material Design decision.
  static const double permanentDrawerWidth = 256.0;

  final List<NavigationSectionMap> sections;
  final String? activeTargetId;
  final ValueChanged<NavigationChildTarget>? onTargetSelected;
  final void Function(NavigationMappingAudit audit)? onNavigationAudited;
  final Widget? header;
  final Widget? footer;
  final Color? activeItemBackgroundColor;
  final Color? activeItemTextColor;

  const PermanentDesktopDrawerDpndl008A15({
    super.key,
    required this.sections,
    this.activeTargetId,
    this.onTargetSelected,
    this.onNavigationAudited,
    this.header,
    this.footer,
    this.activeItemBackgroundColor,
    this.activeItemTextColor,
  });

  @override
  State<PermanentDesktopDrawerDpndl008A15> createState() =>
      _PermanentDesktopDrawerDpndl008A15State();
}

class _PermanentDesktopDrawerDpndl008A15State
    extends State<PermanentDesktopDrawerDpndl008A15> {
  late String? _currentSelectedId;
  final Map<String, bool> _accordionExpansionState = {};

  @override
  void initState() {
    super.initState();
    _currentSelectedId = widget.activeTargetId;
    for (final section in widget.sections) {
      _accordionExpansionState[section.id] = section.initiallyExpanded ||
          section.children.any((c) => c.id == widget.activeTargetId);
    }
  }

  @override
  void didUpdateWidget(covariant PermanentDesktopDrawerDpndl008A15 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeTargetId != oldWidget.activeTargetId) {
      setState(() {
        _currentSelectedId = widget.activeTargetId;
        // Auto-expand section containing newly active target
        for (final section in widget.sections) {
          if (section.children.any((c) => c.id == widget.activeTargetId)) {
            _accordionExpansionState[section.id] = true;
          }
        }
      });
    }
  }

  void _handleTargetTap(NavigationSectionMap parentSection, NavigationChildTarget target) {
    setState(() {
      _currentSelectedId = target.id;
    });

    final audit = NavigationMappingAudit(
      sourceElementId: parentSection.id,
      targetElementId: target.id,
      mappingRule: 'DIRECT_ACCORDION_TARGET_ROUTING',
      mappingStatus: 'APPLIED',
      isMappingValid: target.route.isNotEmpty,
      timestamp: DateTime.now(),
    );

    widget.onNavigationAudited?.call(audit);
    widget.onTargetSelected?.call(target);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveActiveBg = widget.activeItemBackgroundColor ??
        colorScheme.secondaryContainer.withOpacity(0.5);
    final effectiveActiveText =
        widget.activeItemTextColor ?? colorScheme.onSecondaryContainer;

    return SizedBox(
      width: PermanentDesktopDrawerDpndl008A15.permanentDrawerWidth,
      child: Material(
        color: theme.drawerTheme.backgroundColor ?? colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        elevation: theme.drawerTheme.elevation ?? 0.0,
        shape: const Border(
          right: BorderSide(color: Color(0x1F000000), width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.header != null)
              widget.header!
            else
              _DefaultDrawerHeader(colorScheme: colorScheme, textTheme: theme.textTheme),
            const Divider(height: 1, thickness: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                itemCount: widget.sections.length,
                itemBuilder: (context, index) {
                  final section = widget.sections[index];
                  return _buildAccordionSection(
                    section: section,
                    theme: theme,
                    activeBgColor: effectiveActiveBg,
                    activeTextColor: effectiveActiveText,
                  );
                },
              ),
            ),
            if (widget.footer != null) ...[
              const Divider(height: 1, thickness: 1),
              widget.footer!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAccordionSection({
    required NavigationSectionMap section,
    required ThemeData theme,
    required Color activeBgColor,
    required Color activeTextColor,
  }) {
    final isExpanded = _accordionExpansionState[section.id] ?? false;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: ExpansionTile(
        key: PageStorageKey<String>(section.id),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _accordionExpansionState[section.id] = expanded;
          });
        },
        leading: Icon(
          section.leadingIcon,
          size: 20,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(
          section.title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        visualDensity: VisualDensity.compact,
        shape: const Border(),
        collapsedShape: const Border(),
        childrenPadding: const EdgeInsets.only(left: 12.0, right: 4.0, bottom: 4.0),
        children: section.children.map((childTarget) {
          final isSelected = childTarget.id == _currentSelectedId;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: ListTile(
              dense: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              tileColor: isSelected ? activeBgColor : Colors.transparent,
              leading: childTarget.icon != null
                  ? Icon(
                      childTarget.icon,
                      size: 18,
                      color: isSelected
                          ? activeTextColor
                          : theme.colorScheme.onSurfaceVariant,
                    )
                  : null,
              title: Text(
                childTarget.label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? activeTextColor
                      : theme.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: childTarget.subtitle != null
                  ? Text(
                      childTarget.subtitle!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isSelected
                            ? activeTextColor.withOpacity(0.8)
                            : theme.colorScheme.outline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : null,
              onTap: () => _handleTargetTap(section, childTarget),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DefaultDrawerHeader extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _DefaultDrawerHeader({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Icon(Icons.dashboard_customize_outlined, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Application Console',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
