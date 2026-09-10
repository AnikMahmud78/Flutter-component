import 'package:flutter/material.dart';

class BottomNavRouting6628BPTR0191A13Widget extends StatefulWidget {
  const BottomNavRouting6628BPTR0191A13Widget({super.key});

  @override
  State<BottomNavRouting6628BPTR0191A13Widget> createState() =>
      _BottomNavRouting6628BPTR0191A13WidgetState();
}

class _BottomNavRouting6628BPTR0191A13WidgetState
    extends State<BottomNavRouting6628BPTR0191A13Widget> {
  int _selectedIndex = 0;
  static const routes = ['/dashboard', '/tasks', '/analytics', '/settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Navigation Shell')),
      body: Center(child: Text('Active route: ${routes[_selectedIndex]}')),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            label: 'Analytics',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
