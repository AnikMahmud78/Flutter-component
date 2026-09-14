// DSDD-021-11 — Binary DCYN Compliance Gate Widget.
// Enforces privacy-by-design (GDPR Art. 25) by eliminating free-text entry from audit workflows in favor of deterministic binary verification gates.

import 'package:flutter/material.dart';

/// Audit metadata model capturing event lineage without unstructured text.
class ComplianceAuditRecord {
  final String auditType;
  final DateTime auditDate;
  final bool auditResult;
  final String auditorId;
  final String sessionId;
  final String standardReference;
  final DateTime timestamp;

  const ComplianceAuditRecord({
    required this.auditType,
    required this.auditDate,
    required this.auditResult,
    required this.auditorId,
    required this.sessionId,
    this.standardReference = 'GDPR Article 25 (Privacy-by-Design)',
    required this.timestamp,
  });

  Map<String, dynamic> toBigQueryMap() {
    return {
      'audit_type': auditType,
      'audit_date': auditDate.toIso8601String(),
      'audit_result': auditResult ? 'Yes' : 'No',
      'auditor_id': auditorId,
      'session_id': sessionId,
      'standard_reference': standardReference,
      'action_timestamp': timestamp.toIso8601String(),
      'completion_status': auditResult ? 'COMPLIANT' : 'NON_COMPLIANT',
    };
  }
}

/// Binary DCYN Gate item definition for micro-task workflows.
class BinaryGateTask {
  final String id;
  final String title;
  final String description;
  final String auditCategory;
  final bool isChecked;

  const BinaryGateTask({
    required this.id,
    required this.title,
    required this.description,
    required this.auditCategory,
    this.isChecked = false,
  });

  BinaryGateTask copyWith({bool? isChecked}) {
    return BinaryGateTask(
      id: id,
      title: title,
      description: description,
      auditCategory: auditCategory,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

/// Minimalist micro-task audit widget adhering to DSDD-021-11 requirements.
class BinaryComplianceGateWidget extends StatefulWidget {
  final String auditType;
  final String auditorId;
  final String sessionId;
  final List<BinaryGateTask> initialTasks;
  final ValueChanged<List<ComplianceAuditRecord>>? onAuditCompleted;

  const BinaryComplianceGateWidget({
    super.key,
    this.auditType = 'Regulatory Disclosure Completeness',
    required this.auditorId,
    required this.sessionId,
    required this.initialTasks,
    this.onAuditCompleted,
  });

  @override
  State<BinaryComplianceGateWidget> createState() =>
      _BinaryComplianceGateWidgetState();
}

class _BinaryComplianceGateWidgetState
    extends State<BinaryComplianceGateWidget> {
  late List<BinaryGateTask> _tasks;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _tasks = List.of(widget.initialTasks);
  }

  void _toggleGate(int index, bool value) {
    setState(() {
      _tasks[index] = _tasks[index].copyWith(isChecked: value);
    });
  }

  void _finalizeAudit() {
    setState(() => _isSubmitting = true);
    final now = DateTime.now();

    final records = _tasks.map((task) {
      return ComplianceAuditRecord(
        auditType: '${widget.auditType} - ${task.auditCategory}',
        auditDate: now,
        auditResult: task.isChecked,
        auditorId: widget.auditorId,
        sessionId: widget.sessionId,
        timestamp: now,
      );
    }).toList();

    widget.onAuditCompleted?.call(records);
    setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allEvaluated = _tasks.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compliance Verification Gate'),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children:
              // Active Compliance Information Header
              [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.auditType,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Session: ${widget.sessionId} | Auditor: ${widget.auditorId}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Free-text entry disabled per GDPR Art. 25 Data Safety rules.',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            // Binary Verification Checklist
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                itemCount: _tasks.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return _BinaryGateListItem(
                    task: task,
                    onChanged: (val) => _toggleGate(index, val),
                  );
                },
              ),
            ),
            // Submission Control
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed:
                      (!allEvaluated || _isSubmitting) ? null : _finalizeAudit,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Record Binary Audit Results',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual binary DCYN gate row with explicit 48dp touch target
class _BinaryGateListItem extends StatelessWidget {
  final BinaryGateTask task;
  final ValueChanged<bool> onChanged;

  const _BinaryGateListItem({
    required this.task,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onChanged(!task.isChecked),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Material switch enforcing clear binary gate
            Semantics(
              label: 'Verification switch for ${task.title}',
              value: task.isChecked ? 'Yes' : 'No',
              child: Switch.adaptive(
                value: task.isChecked,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
