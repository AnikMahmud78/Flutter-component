// DPNDL-007-A14 — Desktop Navigation Drawer Keyboard Navigation & Focus Management.
// Implements an enterprise desktop navigation drawer with a strict 256dp horizontal width,
// expandable accordion categories, high-contrast semantic active highlights, and comprehensive
// keyboard navigation and focus management adhering to Material Design 3 guidelines.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Persistent horizontal dimension fixed at 256dp per MD3 desktop navigation specs.
const double kDesktopNavigationDrawerWidth = 256.0;

/// Navigation item model representing a terminal or sub-track enterprise destination.
class DesktopNavDestination {
  final String id;
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? badgeText;
  final VoidCallback? onSelect;

  const DesktopNavDestination({
    required this.id,
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.badgeText,
    this.onSelect,
  });
}

/// Enterprise navigation category model containing expandable sub-track destinations.
class DesktopNavCategory {
  final String id;
  final String title;
  final IconData icon;
  final List<DesktopNavDestination> items;
  final bool initiallyExpanded;

  const DesktopNavCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.items,
    this.initiallyExpanded = false,
  });
}

/// Intent for keyboard-based accordion toggling or traversal actions.
class ToggleAccordionIntent extends Intent {
  const ToggleAccordionIntent();
}

/// Desktop Navigation Drawer with keyboard navigation and strict 256dp width.
class DesktopNavigationDrawer extends StatefulWidget {
  final List<DesktopNavCategory> categories;
  final String? selectedItemId;
  final ValueChanged<String>? onItemSelected;
  final Widget? header;
  final Widget? footer;

  const DesktopNavigationDrawer({
    super.key,
    required this.categories,
    this.selectedItemId,
    this.onItemSelected,
    this.header,
    this.footer,
  });

  @override
  State<DesktopNavigationDrawer> createState() => _DesktopNavigationDrawerState();
}

class _DesktopNavigationDrawerState extends State<DesktopNavigationDrawer> {
  late final Map<String, bool> _expandedCategories;
  final FocusScopeNode _drawerFocusScope = FocusScopeNode(
    debugLabel: 'DesktopNavigationDrawerScope',
  );

  @override
  void initState() {
    super.initState();
    _expandedCategories = {
      for (final cat in widget.categories)
        cat.id: cat.initiallyExpanded ||
            cat.items.any((item) => item.id == widget.selectedItemId),
    };
  }

  @override
  void didUpdateWidget(covariant DesktopNavigationDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItemId != oldWidget.selectedItemId &&
        widget.selectedItemId != null) {
      for (final cat in widget.categories) {
        if (cat.items.any((item) => item.id == widget.selectedItemId)) {
          _expandedCategories[cat.id] = true;
        }
      }
    }
  }

  @override
  void dispose() {
    _drawerFocusScope.dispose();
    super.dispose();
  }

  void _toggleCategory(String categoryId) {
    setState(() {
      _expandedCategories[categoryId] = !(_expandedCategories[categoryId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FocusScope(
      node: _drawerFocusScope,
      child: FocusTraversalGroup(
        policy: ReadingOrderTraversalPolicy(),
        child: Semantics(
          label: 'Desktop Navigation Drawer',
          container: true,
          explicitChildNodes: true,
          child: SizedBox(
            width: kDesktopNavigationDrawerWidth,
            height: double.infinity,
            child: Material(
              color: colorScheme.surface,
              surfaceTintColor: colorScheme.surfaceTint,
              elevation: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAlignment.stretch,
                  children: [
                    if (widget.header != null) widget.header!,
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        itemCount: widget.categories.length,
                        itemBuilder: (context, index) {
                          final category = widget.categories[index];
                          final isExpanded =
                              _expandedCategories[category.id] ?? false;
                          return _DesktopAccordionMenu(
                            category: category,
                            isExpanded: isExpanded,
                            selectedItemId: widget.selectedItemId,
                            onToggle: () => _toggleCategory(category.id),
                            onSelectDestination: (dest) {
                              widget.onItemSelected?.call(dest.id);
                              dest.onSelect?.call();
                            },
                          );
                        },
                      ),
                    ),
                    if (widget.footer != null) widget.footer!,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Accordion item containing high-level operational category and sub-tracks.
class _DesktopAccordionMenu extends StatelessWidget {
  final DesktopNavCategory category;
  final bool isExpanded;
  final String? selectedItemId;
  final VoidCallback onToggle;
  final ValueChanged<DesktopNavDestination> onSelectDestination;

  const _DesktopAccordionMenu({
    required this.category,
    required this.isExpanded,
    required this.selectedItemId,
    required this.onToggle,
    required this.onSelectDestination,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.arrowRight): const ToggleAccordionIntent(),
        const SingleActivator(LogicalKeyboardKey.arrowLeft): const ToggleAccordionIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ToggleAccordionIntent: CallbackAction<ToggleAccordionIntent>(
            onInvoke: (_) {
              onToggle();
              return null;
            },
          ),
        },
        child: Column(
          crossAxisAlignment: CrossAlignment.stretch,
          children: [
            FocusableActionDetector(
              mouseCursor: SystemMouseCursors.click,
              actions: <Type, Action<Intent>>{
                ActivateIntent: CallbackAction<ActivateIntent>(
                  onInvoke: (_) {
                    onToggle();
                    return null;
                  },
                ),
              },
              builder: (context, state) {
                final isFocused = state.isFocused;
                final isHovered = state.isHovered;

                return InkWell(
                  onTap: onToggle,
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isFocused
                          ? colorScheme.primaryContainer.withValues(alpha: 0.3)
                          : isHovered
                              ? colorScheme.onSurface.withValues(alpha: 0.08)
                              : Colors.transparent,
                      border: Border.all(
                        color: isFocused
                            ? colorScheme.primary
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          category.icon,
                          size: 20,
                          color: isFocused
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            category.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: isFocused
                                  ? colorScheme.primary
                                  : colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AnimatedRotation(
                          turns: isExpanded ? 0.25 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAlignment.stretch,
                  children: category.items.map((item) {
                    final isSelected = item.id == selectedItemId;
                    return _DesktopNavTile(
                      destination: item,
                      isSelected: isSelected,
                      onTap: () => onSelectDestination(item),
                    );
                  }).toList(),
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

/// Individual actionable navigation track item with semantic active highlight.
class _DesktopNavTile extends StatelessWidget {
  final DesktopNavDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  const _DesktopNavTile({
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              onTap();
              return null;
            },
          ),
        },
        builder: (context, state) {
          final isFocused = state.isFocused;
          final isHovered = state.isHovered;

          final backgroundColor = isSelected
              ? colorScheme.secondaryContainer
              : isHovered
                  ? colorScheme.onSurface.withValues(alpha: 0.06)
                  : Colors.transparent;

          final foregroundColor = isSelected
              ? colorScheme.onSecondaryContainer
              : colorScheme.onSurfaceVariant;

          return InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isFocused ? colorScheme.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected
                        ? (destination.selectedIcon ?? destination.icon)
                        : destination.icon,
                    size: 18,
                    color: foregroundColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      destination.label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: foregroundColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (destination.badgeText != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        destination.badgeText!,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
