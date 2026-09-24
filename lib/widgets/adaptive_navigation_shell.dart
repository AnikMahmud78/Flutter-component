import 'package:flutter/material.dart';
import '../models/adaptive_layout_model.dart';

class AdaptiveNavigationShell extends StatelessWidget {
  final AdaptiveLayoutModel model;
  final Widget child;

  const AdaptiveNavigationShell({
    super.key,
    required this.model,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (model.currentMode == ActiveLayoutMode.compact) {
      return Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard), label: 'Console'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Config'),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Console')),
                NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Config')),
              ],
              selectedIndex: 0,
            ),
            Expanded(child: child),
          ],
        ),
      );
    }
  }
}
