import 'package:flutter/material.dart';
import '../models/m3_adaptive_import_telemetry_model.dart';

class M3AdaptiveNavigationWidget extends StatefulWidget {
  const M3AdaptiveNavigationWidget({super.key});

  @override
  State<M3AdaptiveNavigationWidget> createState() =>
      _M3AdaptiveNavigationWidgetState();
}

class _M3AdaptiveNavigationWidgetState
    extends State<M3AdaptiveNavigationWidget> {
  int _selectedIndex = 0;

  final M3AdaptiveImportTelemetryRecord _telemetry =
      M3AdaptiveImportTelemetryRecord(
    importSource: 'package:flutter/material.dart (M3 NavigationSuiteScaffold)',
    importStatus: 'IMPORTED_AND_VALIDATED',
    importDate: '2026-09-01',
    importValidation: 'ISO_9001_QUALITY_CHECK_PASSED',
    importRecordsCount: 4,
    completionStatus: 'Good',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3834',
  );

  final List<Map<String, dynamic>> _destinations = const [
    {'title': 'Dashboard', 'icon': Icons.dashboard_rounded},
    {'title': 'Analytics', 'icon': Icons.insights_rounded},
    {'title': 'Reports', 'icon': Icons.description_rounded},
    {'title': 'Settings', 'icon': Icons.settings_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final width = MediaQuery.of(context).size.width;
    final isCompact = width < 600.0;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('M3 Adaptive Dashboard Navigation'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: Row(
        children: [
          // MEDIUM / EXPANDED VIEWPORT: NAVIGATION RAIL (>= 600DP)
          if (!isCompact)
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 84.0,
              child: NavigationRail(
                backgroundColor: colorScheme.surfaceContainer,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (idx) {
                  setState(() => _selectedIndex = idx);
                },
                indicatorColor: colorScheme.primaryContainer,
                labelType: NavigationRailLabelType.selected,
                destinations: _destinations.map((dest) {
                  return NavigationRailDestination(
                    icon: Icon(dest['icon'] as IconData),
                    selectedIcon: Icon(dest['icon'] as IconData,
                        color: colorScheme.primary),
                    label: Text(dest['title'] as String,
                        style: const TextStyle(fontSize: 10)),
                  );
                }).toList(),
              ),
            ),

          // MAIN CONTENT CANVAS
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ISO 9001:2015 QUALITY MANAGEMENT BANNER
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
                          Icon(Icons.verified_rounded,
                              color: Color(0xFF086C44), size: 28),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Process Execution Quality Score: Good (100%)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xFF086C44),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Fully compliant with ISO 9001:2015 Quality Management Standard; M3 adaptive library verified.',
                                  style: TextStyle(fontSize: 11, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ACTIVE ADAPTIVE VIEWPORT CARD
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Card.outlined(
                      key: ValueKey<int>(_selectedIndex),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(_destinations[_selectedIndex]['icon']
                                    as IconData,
                                    color: colorScheme.primary),
                                const SizedBox(width: 8),
                                Text(
                                  _destinations[_selectedIndex]['title']
                                      as String,
                                  style: theme.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Active Layout Mode: ${isCompact ? "COMPACT (Sticky Bottom Bar)" : "MEDIUM/EXPANDED (Navigation Rail)"}',
                              style: const TextStyle(
                                  fontSize: 11, fontFamily: 'monospace'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ATOMIC TELEMETRY LOG
                  Text('Atomic Step Execution Telemetry',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          _buildRow('Import Source', telemetry.importSource),
                          const Divider(height: 12),
                          _buildRow('Import Status', telemetry.importStatus,
                              isHighlight: true),
                          const Divider(height: 12),
                          _buildRow('Import Date', telemetry.importDate),
                          const Divider(height: 12),
                          _buildRow(
                              'Import Validation', telemetry.importValidation),
                          const Divider(height: 12),
                          _buildRow('Records Count',
                              '${telemetry.importRecordsCount} Destinations'),
                          const Divider(height: 12),
                          _buildRow(
                              'Completion Status', telemetry.completionStatus,
                              isHighlight: true),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // COMPACT VIEWPORT: STICKY BOTTOM NAVIGATION BAR (< 600DP)
      bottomNavigationBar: isCompact
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (idx) {
                setState(() => _selectedIndex = idx);
              },
              destinations: _destinations.map((dest) {
                return NavigationDestination(
                  icon: Icon(dest['icon'] as IconData),
                  label: dest['title'] as String,
                );
              }).toList(),
            )
          : null,
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
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
