import 'package:flutter/material.dart';

class NavBadgeIcon extends StatelessWidget {
  final IconData icon;
  final int unreadCount;

  const NavBadgeIcon({
    super.key,
    required this.icon,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: unreadCount > 0,
      label: Text(unreadCount > 99 ? '99+' : '$unreadCount'),
      child: Icon(icon),
    );
  }
}
