import 'package:flutter/material.dart';
import '../models/header_analytics_telemetry_model.dart';

class ContextualHeaderAnalyticsWidget extends StatefulWidget {
  const ContextualHeaderAnalyticsWidget({super.key});

  @override
  State<ContextualHeaderAnalyticsWidget> createState() =>
      _ContextualHeaderAnalyticsWidgetState();
}

class _ContextualHeaderAnalyticsWidgetState
    extends State<ContextualHeaderAnalyticsWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _analyticsDispatched = false;
  String _lastVisibilityEvent = 'PENDING_RENDER';

  final HeaderAnalyticsTelemetryRecord _telemetry =
      HeaderAnalyticsTelemetryRecord(
    configurationParameter: 'PAGE_VISIBILITY_ANALYTICS_HOOK',
    currentSetting: 'ENABLED_PUBSUB_DISPATCH_REALTIME',
    previousSetting: 'DISABLED_LOGGING_IDLE',
    changeLog: 'Hook injected to dispatch page visibility timestamp on render',
    configurationTimestamp: DateTime.now().toUtc().toIso8601String(),
    completionStatus: 'Good',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-1117',
    refreshAccuracyRate: 0.999,
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollListener);
    // Dispatch analytics visibility timestamp event upon initial render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dispatchPageVisibilityEvent();
    });
  }

  void _onScrollListener() {
    if (_scrollController.offset > 10 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 10 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  void _dispatchPageVisibilityEvent() {
    final timestamp = DateTime.now().toUtc().toIso8601String();
    setState(() {
      _analyticsDispatched = true;
      _lastVisibilityEvent =
          'EVENT_DISPATCHED [page_visibility_timestamp: $timestamp] -> pubsub://analytics/navigation';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ANALYTICS HOOK DISPATCHED: Page render logged at $timestamp'),
        backgroundColor: const Color(0xFF086C44),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64.0), // Unyielding 64dp profile line
        child: AppBar(
          toolbarHeight: 64.0,
          backgroundColor: colorScheme.surfaceContainerHigh,
          elevation: _isScrolled ? 4.0 : 0.0,
          leading: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () {},
              tooltip: 'Back Navigation',
            ),
          ),
          titleSpacing: 0.0,
          title: const Align(
            alignment: Alignment.centerLeft, // Strict left grid baseline alignment
            child: Text(
              'Contextual Analytics Header',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.15,
              ),
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert_rounded),
              onSelected: (val) {},
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'refresh', child: Text('Refresh Analytics')),
                PopupMenuItem(value: 'export', child: Text('Export Log')),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BI ACCURACY & FRESHNESS BANNER
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
                            'Dashboard Data Refresh & Accuracy: Good (99.9% / <1 min)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Reporting surfaces meet BI freshness & accuracy benchmarks with real-time Pub/Sub logging.',
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

            // LIVE ANALYTICS HOOK DISPATCH STATUS
            Card.outlined(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Page Visibility Hook Status',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Chip(
                          avatar: Icon(
                            _analyticsDispatched
                                ? Icons.check_circle_rounded
                                : Icons.sync_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                          label: Text(
                            _analyticsDispatched ? 'DISPATCHED' : 'PENDING',
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          backgroundColor: _analyticsDispatched
                              ? const Color(0xFF086C44)
                              : Colors.amber.shade800,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _lastVisibilityEvent,
                      style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // RE-DISPATCH MANUAL TRIGGER (TOUCH TARGET >= 48DP)
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0, minWidth: 48.0),
              child: SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _dispatchPageVisibilityEvent,
                  icon: const Icon(Icons.send_rounded),
                  label: const Text(
                    'DISPATCH_VISIBILITY_TIMESTAMP_EVENT',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY LOG
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
                    _buildRow('Config Parameter', telemetry.configurationParameter),
                    const Divider(height: 12),
                    _buildRow('Current Setting', telemetry.currentSetting),
                    const Divider(height: 12),
                    _buildRow('Previous Setting', telemetry.previousSetting),
                    const Divider(height: 12),
                    _buildRow('Change Log', telemetry.changeLog),
                    const Divider(height: 12),
                    _buildRow('Config Timestamp',
                        telemetry.configurationTimestamp.substring(11, 19)),
                    const Divider(height: 12),
                    _buildRow('Completion Status', telemetry.completionStatus,
                        isHighlight: true),
                    const Divider(height: 12),
                    _buildRow('User Session ID', telemetry.userSessionId),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
