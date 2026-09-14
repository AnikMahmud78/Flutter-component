// DPNDL-007-A12 — Desktop Navigation Drawer & Enterprise Routing System.
// Implements Material 3 persistent navigation drawer anchored at exactly 256dp width,
// featuring multi-tier accordion categories, semantic active highlights, and test verification.

import 'package:flutter/material.dart';

/// Represents a terminal navigation route within an enterprise category.
class EnterpriseNavigationItem {
  const EnterpriseNavigationItem({
    required this.id,
    required this.title,
    required this.routePath,
    required this.icon,
    this.selectedIcon,
    this.badge,
  });

  final String id;
  final String title;
  final String routePath;
  final IconData icon;
  final IconData? selectedIcon;
  final String? badge;
}

/// Represents a top-level category grouping deeper sub-tracks in an accordion container.
class EnterpriseNavigationCategory {
  const EnterpriseNavigationCategory({
    required this.id,
    required this.categoryName,
    required this.categoryIcon,
    required this.items,
    this.isInitiallyExpanded = false,
  });

  final String id;
  final String categoryName;
  final IconData categoryIcon;
  final List<EnterpriseNavigationItem> items;
  final bool isInitiallyExpanded;
}

/// Data capture schema for drawer navigation test verification.
class DrawerNavigationTestRecord {
  const DrawerNavigationTestRecord({
    required this.testType,
    required this.testResult,
    required this.testCoverage,
    required this.testTimestamp,
    required this.testLogPath,
    required this.completionStatus,
    required this.actionTimestamp,
    required this.sessionId,
  });

  final String testType;
  final String testResult;
  final double testCoverage;
  final DateTime testTimestamp;
  final String testLogPath;
  final String completionStatus;
  final DateTime actionTimestamp;
  final String sessionId;

  Map<String, dynamic> toJson() => {
        'testType': testType,
        'testResult': testResult,
        'testCoverage': testCoverage,
        'testTimestamp': testTimestamp.toIso8601String(),
        'testLogPath': testLogPath,
        'completionStatus': completionStatus,
        'actionTimestamp': actionTimestamp.toIso8601String(),
        'sessionId': sessionId,
      };
}

/// MD3 Desktop Navigation Drawer enforcing an un-alterable 256dp width constraint.
class DesktopNavigationDrawerDpndl007A12 extends StatelessWidget {
  const DesktopNavigationDrawerDpndl007A12({
    super.key,
    required this.categories,
    required this.currentRoutePath,
    required this.onDestinationSelected,
    this.header,
    this.footer,
  });

  /// Strict, un-alterable 256dp component horizontal dimension constraint (MD3 standard).
  static const double componentWidth = 256.0;

  final List<EnterpriseNavigationCategory> categories;
  final String currentRoutePath;
  final ValueChanged<String> onDestinationSelected;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: componentWidth,
      height: double.infinity,
      child: Material(
        color: colorScheme.surface,
        elevation: 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (header != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: header!,
              ),
            const Divider(height: 1.0, thickness: 1.0),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _buildCategoryAccordion(context, category);
                },
              ),
            ),
            if (footer != null) ...[
              const Divider(height: 1.0, thickness: 1.0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: footer!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryAccordion(
    BuildContext context,
    EnterpriseNavigationCategory category,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasActiveChild = category.items.any((item) => item.routePath == currentRoutePath);

    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: category.isInitiallyExpanded || hasActiveChild,
        leading: Icon(
          category.categoryIcon,
          size: 20.0,
          color: hasActiveChild ? colorScheme.primary : colorScheme.onSurfaceVariant,
        ),
        title: Text(
          category.categoryName,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: hasActiveChild ? FontWeight.w600 : FontWeight.w500,
            color: hasActiveChild ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: category.items.map((item) => _buildNavigationTile(context, item)).toList(),
      ),
    );
  }

  Widget _buildNavigationTile(
    BuildContext context,
    EnterpriseNavigationItem item,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = item.routePath == currentRoutePath;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(28.0),
        onTap: () => onDestinationSelected(item.routePath),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 48.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.secondaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(28.0),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? (item.selectedIcon ?? item.icon) : item.icon,
                size: 20.0,
                color: isSelected
                    ? colorScheme.onSecondaryContainer
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  item.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? colorScheme.onSecondaryContainer
                        : colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (item.badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    item.badge!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Test helper & diagnostic runner to verify routing navigation across drawer paths.
class DesktopDrawerNavigationVerifier {
  DesktopDrawerNavigationVerifier({
    required this.categories,
    required this.sessionId,
  });

  final List<EnterpriseNavigationCategory> categories;
  final String sessionId;

  List<EnterpriseNavigationItem> get allItems =>
      categories.expand((c) => c.items).toList();

  /// Executes programmatic navigation loop verification across all defined routes.
  DrawerNavigationTestRecord runNavigationAudit({
    required void Function(String routePath) navigateTo,
  }) {
    final startTime = DateTime.now();
    int routesPassed = 0;
    final totalRoutes = allItems.length;

    for (final item in allItems) {
      try {
        navigateTo(item.routePath);
        routesPassed++;
      } catch (_) {
        // Handled to determine partial vs full pass
      }
    }

    final coverage = totalRoutes == 0 ? 100.0 : (routesPassed / totalRoutes) * 100.0;
    final isOptimal = coverage == 100.0;

    return DrawerNavigationTestRecord(
      testType: 'Functional Desktop Drawer Route Navigation',
      testResult: isOptimal ? 'Pass' : 'Partial',
      testCoverage: coverage,
      testTimestamp: startTime,
      testLogPath: '/logs/navigation/dpndl_007_a12_${startTime.millisecondsSinceEpoch}.log',
      completionStatus: isOptimal ? 'Pass' : 'Failed',
      actionTimestamp: DateTime.now(),
      sessionId: sessionId,
    );
  }
}
