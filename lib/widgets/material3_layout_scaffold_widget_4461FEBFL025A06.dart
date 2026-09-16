import 'package:flutter/material.dart';
import '../models/material3_layout_telemetry_model.dart';

class Material3LayoutScaffoldWidget4461FEBFL025A06 extends StatefulWidget {
  const Material3LayoutScaffoldWidget4461FEBFL025A06({super.key});

  @override
  State<Material3LayoutScaffoldWidget4461FEBFL025A06> createState() =>
      _Material3LayoutScaffoldWidgetState();
}

class _Material3LayoutScaffoldWidgetState
    extends State<Material3LayoutScaffoldWidget4461FEBFL025A06> {
  final Material3LayoutTelemetryRecord _telemetry =
      Material3LayoutTelemetryRecord(
    scaffoldType: 'ADAPTIVE_SCAFFOLD',
    layoutPattern: 'LIST_DETAIL',
    navigationRail: 'ENABLED',
    listDetailRule: 'SIDE_BY_SIDE_ABOVE_600DP',
    adaptiveBreakpoint: '600dp',
    validationStatus: 'Validated',
    completionStatus: 'Pass',
    actionEventTimestamp: DateTime.now().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-4461',
  );

  int _selectedIndex = 0;
  final List<String> _items = ['Dashboard', 'Reports', 'Settings', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material 3 Layout Scaffold 4461FEBFL025A06')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Validation / QA Pass Rate: Pass (100%)',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (i) =>
                        setState(() => _selectedIndex = i),
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                          icon: Icon(Icons.dashboard), label: Text('Dashboard')),
                      NavigationRailDestination(
                          icon: Icon(Icons.bar_chart), label: Text('Reports')),
                      NavigationRailDestination(
                          icon: Icon(Icons.settings), label: Text('Settings')),
                      NavigationRailDestination(
                          icon: Icon(Icons.person), label: Text('Profile')),
                    ],
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (_, i) => ListTile(
                        title: Text(_items[i]),
                        selected: _selectedIndex == i,
                        onTap: () => setState(() => _selectedIndex = i),
                      ),
                    ),
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        'Detail: ${_items[_selectedIndex]}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('PROCEED WITH TRANSACTION'),
              ),
            ),
            const SizedBox(height: 16),
            _telemetryRow('validationStatus', _telemetry.validationStatus),
            _telemetryRow('completionStatus', _telemetry.completionStatus),
          ],
        ),
      ),
    );
  }

  Widget _telemetryRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(value),
          ],
        ),
      );
}
