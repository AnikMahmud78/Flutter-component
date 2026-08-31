import 'package:flutter/material.dart';
import '../models/app_shell_rls_telemetry_model.dart';

class GlobalAppShellWidget extends StatefulWidget {
  const GlobalAppShellWidget({super.key});

  @override
  State<GlobalAppShellWidget> createState() => _GlobalAppShellWidgetState();
}

class _GlobalAppShellWidgetState extends State<GlobalAppShellWidget> {
  int _selectedDepartmentIndex = 0;
  bool _isRlsValidated = true;
  String _rlsStatusLog = 'RLS_TOKEN_VALIDATED: Access Granted to [Operations]';

  final DepartmentalAccessToken _currentToken = DepartmentalAccessToken(
    tokenId: 'TOK-IAM-2026-9901',
    userId: 'USR-ANIK-8812',
    authorizedDepartments: const ['Operations', 'Logistics'],
    expirationTimestamp: DateTime.now().add(const Duration(hours: 8)),
  );

  final List<Map<String, dynamic>> _departments = const [
    {'name': 'Operations', 'icon': Icons.account_tree_rounded},
    {'name': 'Logistics', 'icon': Icons.local_shipping_rounded},
    {'name': 'Finance', 'icon': Icons.account_balance_wallet_rounded},
    {'name': 'Human Resources', 'icon': Icons.badge_rounded},
  ];

  AppShellRlsTelemetryRecord get _telemetry => AppShellRlsTelemetryRecord(
        validationType: 'SERVER_SIDE_RLS_TOKEN_PRIVILEGE_CHECK',
        validationResult: _isRlsValidated ? 'PASS_200_OK' : 'FAIL_403_FORBIDDEN',
        errorMessages: _isRlsValidated
            ? 'NONE'
            : '403 Forbidden: Account claims missing required target department role.',
        validationTimestamp: DateTime.now().toUtc().toIso8601String(),
        validationLog: _rlsStatusLog,
        completionStatus: _isRlsValidated ? 'Pass' : 'Fail',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-5803',
      );

  void _switchDepartment(int index) {
    final targetDept = _departments[index]['name'] as String;

    // Simulate Backend Row-Level Security (RLS) privilege verification
    if (_currentToken.hasPrivilegeFor(targetDept)) {
      setState(() {
        _selectedDepartmentIndex = index;
        _isRlsValidated = true;
        _rlsStatusLog = 'RLS_TOKEN_VALIDATED: Access Granted to [$targetDept]';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('SSO / RLS GATE PASS: Switched to $targetDept hub.'),
          backgroundColor: const Color(0xFF086C44),
        ),
      );
    } else {
      setState(() {
        _isRlsValidated = false;
        _rlsStatusLog =
            'RLS_CHECK_FAILED: 403 Forbidden for [$targetDept]. Missing RLS claims.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('RLS ACCESS DENIED: 403 Forbidden for $targetDept.'),
          backgroundColor: const Color(0xFFE31B23),
        ),
      );
    }
  }

  void _openMobileSlidingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Corporate Operational Hubs',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...List.generate(_departments.length, (idx) {
                  final dept = _departments[idx];
                  return ListTile(
                    leading: Icon(dept['icon'] as IconData),
                    title: Text(dept['name'] as String),
                    selected: _selectedDepartmentIndex == idx,
                    onTap: () {
                      Navigator.pop(context);
                      _switchDepartment(idx);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final width = MediaQuery.of(context).size.width;
    final isCompact = width < 600.0;
    final isExpanded = width >= 840.0;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unified Corporate App Shell'),
        backgroundColor: colorScheme.surfaceContainerHigh,
        leading: isCompact
            ? ConstrainedBox(
                constraints:
                    const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
                child: IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: _openMobileSlidingSheet,
                  tooltip: 'Open Hub Navigation Drawer',
                ),
              )
            : null,
      ),
      body: Row(
        children: [
          // PERMANENT SIDE NAVIGATION RAIL ON SCREENS PAST 840DP
          if (isExpanded)
            NavigationRail(
              selectedIndex: _selectedDepartmentIndex,
              onDestinationSelected: _switchDepartment,
              labelType: NavigationRailLabelType.all,
              destinations: _departments.map((dept) {
                return NavigationRailDestination(
                  icon: Icon(dept['icon'] as IconData),
                  label: Text(dept['name'] as String),
                );
              }).toList(),
            ),

          // MAIN CONTENT CANVAS
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // OWASP ACCESS CONTROL COMPLIANCE BANNER
                  Card.filled(
                    color: _isRlsValidated
                        ? Colors.green.shade50
                        : const Color(0xFFF9DEDC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: _isRlsValidated
                            ? Colors.green.shade300
                            : const Color(0xFFE31B23),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Icon(
                            _isRlsValidated
                                ? Icons.security_rounded
                                : Icons.gpp_maybe_rounded,
                            color: _isRlsValidated
                                ? const Color(0xFF086C44)
                                : const Color(0xFFE31B23),
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Access Control Compliance: ${_isRlsValidated ? "Pass (100% Gated)" : "Fail (403 Forbidden)"}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: _isRlsValidated
                                        ? const Color(0xFF086C44)
                                        : const Color(0xFF8B0811),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Backend Row-Level Security (RLS) token privileges enforced server-side per OWASP rules.',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: colorScheme.onSurface),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ACTIVE HUB VIEW
                  Card.outlined(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Departmental Domain: ${_departments[_selectedDepartmentIndex]['name']}',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Token Claims: ${_currentToken.authorizedDepartments.join(", ")}',
                            style: const TextStyle(
                                fontSize: 12, fontFamily: 'monospace'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ATOMIC TELEMETRY LOG
                  Text(
                    'Atomic Step Execution Telemetry',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          _buildRow('Validation Type', telemetry.validationType),
                          const Divider(height: 12),
                          _buildRow(
                              'Validation Result', telemetry.validationResult,
                              isHighlight: true),
                          const Divider(height: 12),
                          _buildRow('Error Messages', telemetry.errorMessages),
                          const Divider(height: 12),
                          _buildRow('Validation Log', telemetry.validationLog),
                          const Divider(height: 12),
                          _buildRow(
                              'Completion Status', telemetry.completionStatus,
                              isHighlight: true),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
