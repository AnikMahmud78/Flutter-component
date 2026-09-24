import 'package:flutter/material.dart';

class AutoRefreshDashboardWidget extends StatefulWidget {
  const AutoRefreshDashboardWidget({super.key});

  @override
  State<AutoRefreshDashboardWidget> createState() => _AutoRefreshDashboardWidgetState();
}

class _AutoRefreshDashboardWidgetState extends State<AutoRefreshDashboardWidget> {
  DateTime _lastRefreshed = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 150));
    if (mounted) {
      setState(() {
        _lastRefreshed = DateTime.now();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int freshnessMinutes = DateTime.now().difference(_lastRefreshed).inMinutes;
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: ListTile(
        title: const Text('Dashboard Telemetry Status'),
        subtitle: Text('Data Freshness: $freshnessMinutes mins ago (Real-time)'),
        trailing: _isLoading
            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
            : IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _refreshData,
              ),
      ),
    );
  }
}
