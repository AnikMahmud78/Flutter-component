import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const WorkflowWasteEradicationApp());
}

/// Root Application Widget using MaterialApp.router
class WorkflowWasteEradicationApp extends StatelessWidget {
  const WorkflowWasteEradicationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Eradicate Workflow Waste Navigation',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      routerConfig: AppRouter.router,
    );
  }
}

/// Centralized GoRouter Configuration
/// ERADICATED ROUTE: /legacy-workflow-waste (HC-SCH-0047)
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/telemetry-dashboard',
    routes: [
      GoRoute(
        path: '/telemetry-dashboard',
        name: 'TelemetryDashboard',
        builder: (context, state) => const TelemetryDashboardScreen(),
      ),
      GoRoute(
        path: '/ingestion-stream/:streamId',
        name: 'IngestionStreamViewer',
        builder: (context, state) {
          final streamId = state.pathParameters['streamId'] ?? 'STREAM-001';
          final isLive = state.uri.queryParameters['isLive'] == 'true';
          return IngestionStreamViewerScreen(
            streamId: streamId,
            isLive: isLive,
          );
        },
      ),
      GoRoute(
        path: '/system-settings',
        name: 'SystemSettings',
        builder: (context, state) => const SystemSettingsScreen(),
      ),
    ],
    // Catch-all for eradicated or undefined legacy routes (Fail-Safe Navigation)
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Route Eradicated'),
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.block_rounded, color: Colors.red, size: 56),
              const SizedBox(height: 16),
              Text(
                'ROUTE_ERADICATED (HC-SCH-0047)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red.shade900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'The legacy screen route "${state.uri}" has been purged to eliminate workflow waste.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => context.go('/telemetry-dashboard'),
                  icon: const Icon(Icons.dashboard_rounded),
                  label: const Text('Return to Safe Dashboard'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SCREEN 1: TELEMETRY DASHBOARD (MAIN VIEW)
// =============================================================================
class TelemetryDashboardScreen extends StatelessWidget {
  const TelemetryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Telemetry Dashboard'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DAMA-DMBOK2 AUDIT BANNER
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      color: Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Schema/Field Naming Standardization: 100% (Good)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Compliant with DAMA-DMBOK2 Data Standards & Naming Conventions.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Active Navigation Triggers',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // ROUTE TRIGGER 1: INGESTION STREAM
            _buildNavigationTile(
              context: context,
              title: 'OPEN_INGESTION_STREAM',
              subtitle: 'Navigates to /ingestion-stream/STRM-99812?isLive=true',
              icon: Icons.stream_rounded,
              color: colorScheme.primary,
              onTap: () =>
                  context.go('/ingestion-stream/STRM-99812?isLive=true'),
            ),

            const SizedBox(height: 10),

            // ROUTE TRIGGER 2: SYSTEM SETTINGS
            _buildNavigationTile(
              context: context,
              title: 'OPEN_SYSTEM_SETTINGS',
              subtitle: 'Navigates to /system-settings',
              icon: Icons.settings_rounded,
              color: Colors.teal.shade800,
              onTap: () => context.go('/system-settings'),
            ),

            const SizedBox(height: 10),

            // ROUTE TRIGGER 3: TEST ERADICATED ROUTE (HC-SCH-0047)
            _buildNavigationTile(
              context: context,
              title: 'TEST_ERADICATED_ROUTE (HC-SCH-0047)',
              subtitle: 'Simulates call to purged /legacy-workflow-waste route',
              icon: Icons.bug_report_rounded,
              color: colorScheme.error,
              onTap: () => context.go('/legacy-workflow-waste'),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY RECORD
            Text(
              'Atomic Telemetry Metadata Record',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildTelemetryRow(
                      'Platform Engine',
                      'Flutter 3.24 / GoRouter v14',
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Legacy Conversion',
                      'React Native 0.74.2 Refactored',
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Build Target',
                      'PRODUCTION_RELEASE_AAB_IPA',
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Standard Reference',
                      'DAMA-DMBOK2 Guideline',
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('Assigned Lead', 'Anik'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48.0),
      child: Card.outlined(
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: color),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 11)),
          trailing: const Icon(Icons.chevron_right_rounded),
        ),
      ),
    );
  }

  Widget _buildTelemetryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SCREEN 2: INGESTION STREAM VIEWER
// =============================================================================
class IngestionStreamViewerScreen extends StatelessWidget {
  final String streamId;
  final bool isLive;

  const IngestionStreamViewerScreen({
    super.key,
    required this.streamId,
    required this.isLive,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ingestion Stream: $streamId')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sensors_rounded,
              size: 64,
              color: isLive ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Stream ID: $streamId',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Status: ${isLive ? "LIVE STREAM ACTIVE" : "OFFLINE RECORDING"}',
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/telemetry-dashboard'),
              child: const Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SCREEN 3: SYSTEM SETTINGS
// =============================================================================
class SystemSettingsScreen extends StatelessWidget {
  const SystemSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('System Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.settings_suggest_rounded,
              size: 64,
              color: Colors.indigo,
            ),
            const SizedBox(height: 16),
            const Text('System Configuration & Telemetry Node Settings'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/telemetry-dashboard'),
              child: const Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
