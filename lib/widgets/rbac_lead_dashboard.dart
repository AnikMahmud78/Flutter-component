import 'package:flutter/material.dart';
import '../models/user_role_permissions.dart';

class RbacLeadDashboard extends StatelessWidget {
  final UserRolePermissions permissions;

  const RbacLeadDashboard({Key? key, required this.permissions}) : super(key: key);

  // English Code (EC): Render-Rbac-Restricted-Controls
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.admin_panel_settings, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Engineering Lead View (RBAC Protected)', style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Role Level: ENGINEERING_LEAD (Read & Approve Only)'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle),
                    label: const Text('APPROVE STEP'),
                    onPressed: permissions.canApprove ? () {} : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.lock),
                    label: const Text('MODIFY CONFIG'),
                    onPressed: permissions.canModifyConfig ? () {} : null, // Disabled for Lead
                  ),
                ),
              ],
            ),
            if (!permissions.canModifyConfig)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text('* Configuration modification restricted by OWASP policy.', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ),
          ],
        ),
      ),
    );
  }
}
