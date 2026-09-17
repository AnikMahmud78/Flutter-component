// lib/widgets/dwell_time_card.dart
import 'package:flutter/material.dart';

class DwellTimeCard extends StatefulWidget {
  const DwellTimeCard({super.key});

  @override
  State<DwellTimeCard> createState() => _DwellTimeCardState();
}

class _DwellTimeCardState extends State<DwellTimeCard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, int> _dwellTimes = {'Overview': 0, 'Reviews': 0, 'Gallery': 0};
  DateTime? _tabStartTime;
  String _activeTab = 'Overview';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabStartTime = DateTime.now();
    _tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    final elapsed = DateTime.now().difference(_tabStartTime!).inSeconds;
    setState(() {
      _dwellTimes[_activeTab] = (_dwellTimes[_activeTab] ?? 0) + elapsed;
      _activeTab = ['Overview', 'Reviews', 'Gallery'][_tabController.index];
      _tabStartTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dwell-Time Tracking Hooks', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Overview'), Tab(text: 'Reviews'), Tab(text: 'Gallery')],
        ),
        const SizedBox(height: 8.0),
        ..._dwellTimes.entries.map((e) => ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(e.key, style: theme.textTheme.bodyMedium),
              trailing: Text('${e.value}s dwell', style: theme.textTheme.bodySmall),
            )),
      ],
    );
  }
}
