import 'package:flutter/material.dart';

class ConstraintBoundary7123CSIVW002A14 extends StatelessWidget {
  const ConstraintBoundary7123CSIVW002A14({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Profile Constraint Boundaries')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const ListTile(
          title: Text('7123CSIVW-002-A14'),
          subtitle: Text(
            'Minimum, maximum, and beyond-boundary values are visible for testing.',
          ),
        ),
        ...[0, 50, 100, 101].map(
          (value) => ListTile(
            title: Text('Boundary value: $value'),
            trailing: Icon(
              value == 101 ? Icons.error : Icons.check_circle,
              color: value == 101 ? Colors.red : Colors.green,
            ),
          ),
        ),
      ],
    ),
  );
}
