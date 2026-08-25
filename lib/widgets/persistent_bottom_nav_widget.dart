// Location: lib/widgets/persistent_bottom_nav_widget.dart
import 'package:flutter/material.dart';
import '../models/bottom_nav_telemetry_model.dart';

class PersistentBottomNavWidget extends StatefulWidget {
  const PersistentBottomNavWidget({super.key});

  @override
  State<PersistentBottomNavWidget> createState() =>
      _PersistentBottomNavWidgetState();
}

class _PersistentBottomNavWidgetState
    extends State<PersistentBottomNavWidget> {
  int _selectedNavIndex = 0;
  String _selectedSecondaryChip = 'All Activity';

  final List<String> _secondaryFilterChips = const [
    'All Activity',
    'Pending Approvals',
    'Flagged Exceptions',
    'Archived Logs',
  ];

  final List<Map<String, dynamic>> _navDestinations = const [
    {'label': 'Dashboard', 'icon': Icons.dashboard_rounded},
    {'label': 'Tasks', 'icon': Icons.task_alt_rounded},
    {'label': 'Inspect', 'icon': Icons.fact_check_rounded},
    {'label': 'Profile', 'icon': Icons.person_rounded},
  ];

  final BottomNavTelemetryRecord _telemetry = BottomNavTelemetryRecord(
    definitionName: 'M3_BOTTOM_NAV_4_DESTINATIONS_POLICY',
    definitionParameters: 'DEST_COUNT=4; MIN_TOUCH_BOUND=48dp; SIDE_RAIL_DISABLED_UNDER_600dp',
    definitionType: 'ERGONOMIC_LAYOUT_POLICY',
    validationStatus: 'VALIDATED_PEER_REVIEWED',
    definitionId: 'DEF-ANSA-001-2026',
    completionStatus: 'Complete',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-13811',
    thresholdCoverage: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final viewportWidth = MediaQuery.of(context).size.width;
    final bool isSmallSmartphone = viewportWidth < 600.0;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Persistent Bottom Interface Nav'),
        backgroundColor: colorScheme.surfaceContainerHigh,
        // Disable top menus on small smartphone canvases
        automaticallyImplyLeading: !isSmallSmartphone,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BUSINESS RULE / THRESHOLD COVERAGE BANNER
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(Icons.verified_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Business Rule Coverage: Complete (100%)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '100% of threshold rules defined, peer-reviewed, and versioned in spec.',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // DEEPER SECONDARY VIEW SWITCHES BEHIND LAYOUT CHIPS
            Text(
              'Secondary View Context Filters',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _secondaryFilterChips.map((chipLabel) {
                  final isSelected = _selectedSecondaryChip == chipLabel;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(chipLabel),
                      selected: isSelected,
                      selectedColor: colorScheme.primaryContainer,
                      labelStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedSecondaryChip = chipLabel);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // ACTIVE VIEW CANVAS
            Card.outlined(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(_navDestinations[_selectedNavIndex]['icon'], color: colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          _navDestinations[_selectedNavIndex]['label'],
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Active Filter Sub-Context: "$_selectedSecondaryChip"',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY DISPLAY
            Text(
              'Atomic Step Execution Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Definition Name', telemetry.definitionName),
                    const Divider(height: 12),
                    _buildRow('Definition ID', telemetry.definitionId),
                    const Divider(height: 12),
                    _buildRow('Definition Type', telemetry.definitionType),
                    const Divider(height: 12),
                    _buildRow('Validation Status', telemetry.validationStatus, isHighlight: true),
                    const Divider(height: 12),
                    _buildRow('Completion Status', telemetry.completionStatus, isHighlight: true),
                    const Divider(height: 12),
                    _buildRow('User Session ID', telemetry.userSessionId),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // MOUNT EXACTLY 4 PRE-SET VISUAL ICON DESTINATIONS ALONG PERSISTENT BOTTOM STRIP
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedNavIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedNavIndex = index);
        },
        indicatorColor: colorScheme.primaryContainer,
        destinations: List.generate(_navDestinations.length, (index) {
          final item = _navDestinations[index];
          return NavigationDestination(
            icon: Icon(item['icon']),
            selectedIcon: Icon(item['icon'], color: colorScheme.primary),
            label: item['label'],
          );
        }),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
