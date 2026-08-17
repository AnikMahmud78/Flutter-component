import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// DAMA-DMBOK2 Standardized Flutter Navigation Router
/// ERADICATED ROUTE: /legacy-workflow-waste (HC-SCH-0047)
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/telemetry-dashboard',
    routes: [
      GoRoute(
        path: '/telemetry-dashboard',
        name: 'TelemetryDashboard',
        builder: (context, state) {
          final sessionId =
              state.uri.queryParameters['sessionId'] ?? 'SESS-DEFAULT';
          final interval =
              int.tryParse(
                state.uri.queryParameters['refreshIntervalMs'] ?? '1000',
              ) ??
              1000;
          return TelemetryDashboardScreen(
            sessionId: sessionId,
            refreshIntervalMs: interval,
          );
        },
      ),
      GoRoute(
        path: '/ingestion-stream/:streamId',
        name: 'IngestionStreamViewer',
        builder: (context, state) {
          final streamId = state.pathParameters['streamId'] ?? '';
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
      // HC-SCH-0047: Workflow waste route successfully eradicated from GoRouter tree
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'ROUTE_EXCEPTION: Route ${state.uri} eradicated or undefined.',
        ),
      ),
    ),
  );
}

// Dummy Screen Placeholders
class TelemetryDashboardScreen extends StatelessWidget {
  final String sessionId;
  final int refreshIntervalMs;
  const TelemetryDashboardScreen({
    super.key,
    required this.sessionId,
    required this.refreshIntervalMs,
  });

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: const Text('Telemetry Dashboard')));
}

class IngestionStreamViewerScreen extends StatelessWidget {
  final String streamId;
  final bool isLive;
  const IngestionStreamViewerScreen({
    super.key,
    required this.streamId,
    required this.isLive,
  });

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: const Text('Ingestion Stream')));
}

class SystemSettingsScreen extends StatelessWidget {
  const SystemSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: const Text('System Settings')));
}
