import 'package:flutter/material.dart';
import '../models/department_metric_section.dart';

class InfiniteDashboardList extends StatefulWidget {
  const InfiniteDashboardList({Key? key}) : super(key: key);

  @override
  State<InfiniteDashboardList> createState() => _InfiniteDashboardListState();
}

class _InfiniteDashboardListState extends State<InfiniteDashboardList> {
  final List<DepartmentMetricSection> _sections = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  // English Code (EC): Load-Initial-Dashboard-Data
  void _loadInitialData() {
    for (int i = 1; i <= 15; i++) {
      _sections.add(DepartmentMetricSection(
        departmentName: 'Engineering Dept #$i',
        totalServices: 8 + i,
        healthScore: 95.0 + (i % 5),
      ));
    }
  }

  // English Code (EC): On-Scroll-Threshold-Reached
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            final nextIdx = _sections.length + 1;
            for (int i = nextIdx; i < nextIdx + 10; i++) {
              _sections.add(DepartmentMetricSection(
                departmentName: 'Engineering Dept #$i',
                totalServices: 10 + i,
                healthScore: 98.0,
              ));
            }
            _isLoadingMore = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _sections.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _sections.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final sec = _sections[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(sec.departmentName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Active Services: ${sec.totalServices}'),
            trailing: Text('${sec.healthScore}%', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
