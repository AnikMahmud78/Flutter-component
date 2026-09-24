import 'package:flutter/material.dart';
import 'widgets/rbac_lead_dashboard.dart';
import 'models/user_role_permissions.dart';

void main() {
  runApp(const RbacApp());
}

class RbacApp extends StatelessWidget {
  const RbacApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leadPermissions = UserRolePermissions.forRole(UserRole.engineeringLead);

    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: Scaffold(
        appBar: AppBar(title: const Text('Engineering Governance Console')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RbacLeadDashboard(permissions: leadPermissions),
        ),
      ),
    );
  }
}
