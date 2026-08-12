import 'package:flutter/material.dart';

class DynamicContextualDrawer extends StatefulWidget {
  final VoidCallback onDismissed;

  const DynamicContextualDrawer({super.key, required this.onDismissed});

  /// Static helper launching the contextual sheet responsively
  static void show(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 600;

    if (isDesktop) {
      // Desktop / Tablet Side Sheet Mode
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Dismiss Side Sheet',
        barrierColor: Colors.black54, // Alpha Scrim Dimming
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (ctx, anim1, anim2) {
          return Align(
            alignment: Alignment.centerRight,
            child: Material(
              elevation: 8.0,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(28.0),
              ),
              child: SizedBox(
                width: 380,
                height: double.infinity,
                child: DynamicContextualDrawer(
                  onDismissed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ),
          );
        },
      );
    } else {
      // Mobile Bottom Sheet Mode
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54, // Background Scrim Alpha Dimming Rule
        builder: (ctx) {
          return DynamicContextualDrawer(
            onDismissed: () => Navigator.of(ctx).pop(),
          );
        },
      );
    }
  }

  @override
  State<DynamicContextualDrawer> createState() =>
      _DynamicContextualDrawerState();
}

class _DynamicContextualDrawerState extends State<DynamicContextualDrawer> {
  String _selectedFilter = 'All Transactions';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDesktop = MediaQuery.of(context).size.width >= 600;

    // REQUIREMENT: Inject conditional back-button intercept hooks (PopScope)
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // Log or clean up gesture thread upon safe dismissal
        }
      },
      child: isDesktop
          ? _buildDrawerContent(theme, colorScheme, isDesktop: true)
          : DraggableScrollableSheet(
              // REQUIREMENT: Declare standard sheet resting anchor heights
              initialChildSize: 0.50, // 50% resting anchor
              minChildSize: 0.25, // 25% collapsed anchor
              maxChildSize: 0.90, // 90% expanded anchor
              snap: true,
              snapSizes: const [0.25, 0.50, 0.90],
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    // REQUIREMENT: Apply 28dp corner-rounding parameters to top sheet frames
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(40),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: _buildDrawerContent(
                      theme,
                      colorScheme,
                      isDesktop: false,
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildDrawerContent(
    ThemeData theme,
    ColorScheme colorScheme, {
    required bool isDesktop,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle for Mobile Mode
          if (!isDesktop) ...[
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Spatial Context Filters',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isDesktop ? 'Side Sheet (Desktop)' : 'Bottom Sheet (Mobile)',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Parent screen state remains local behind dimmed scrim.',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 20),

          // REQUIREMENT: Restrict sheet content to interactive targets that meet minimum 48dp rule
          _buildFilterOptionTile(
            label: 'All Transactions',
            icon: Icons.receipt_long_rounded,
            isSelected: _selectedFilter == 'All Transactions',
            onTap: () => setState(() => _selectedFilter = 'All Transactions'),
          ),
          _buildFilterOptionTile(
            label: 'Pending Approval',
            icon: Icons.hourglass_top_rounded,
            isSelected: _selectedFilter == 'Pending Approval',
            onTap: () => setState(() => _selectedFilter = 'Pending Approval'),
          ),
          _buildFilterOptionTile(
            label: 'High Variance Anomalies',
            icon: Icons.warning_amber_rounded,
            isSelected: _selectedFilter == 'High Variance Anomalies',
            onTap: () =>
                setState(() => _selectedFilter = 'High Variance Anomalies'),
          ),

          const SizedBox(height: 24),

          // Action Confirmation Button (Constrained to >= 48dp height)
          SizedBox(
            width: double.infinity,
            height: 48.0, // Minimum 48dp Touch Target
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                widget.onDismissed();
              },
              child: const Text(
                'Apply Spatial Filter',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildFilterOptionTile({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: isSelected ? Colors.indigo.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            // REQUIREMENT: Minimum 48dp dimension rule enforcement
            constraints: const BoxConstraints(minHeight: 48.0),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected
                      ? Colors.indigo.shade800
                      : Colors.grey.shade700,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 13,
                      color: isSelected
                          ? Colors.indigo.shade900
                          : Colors.black87,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.indigo.shade800,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
