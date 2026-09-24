import 'package:flutter/material.dart';

class KeyboardAnchoredMenu extends StatelessWidget {
  final bool isOpen;
  final ValueChanged<String> onCommandSelected;

  const KeyboardAnchoredMenu({
    Key? key,
    required this.isOpen,
    required this.onCommandSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final theme = Theme.of(context);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
      bottom: isOpen ? bottomInset + 16.0 : -300.0,
      left: 16.0,
      right: 16.0,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surface,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text('/code - Insert Code Block'),
                onTap: () => onCommandSelected('/code'),
              ),
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text('/audit - Trigger Security Audit'),
                onTap: () => onCommandSelected('/audit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
