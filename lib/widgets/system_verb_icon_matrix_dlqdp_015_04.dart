// DLQDP-015-04 — System-Verb Icon Mapping Matrix & Visual Asset Audit Component.
// Enforces strict iconography usage mapping exclusively to system actions with a 24x24dp bounding box,
// phantom touch-target padding bounds (minimum 48x48dp), and deployment audit metadata tracking.

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Enumeration of permissible system-verb operations.
/// Strips all human-centric indicators in favor of deterministic system actions.
enum SystemVerb {
  sync,
  refresh,
  rollback,
  execute,
  terminate,
  commit,
  audit,
  filter,
  navigateNext,
  navigateBack,
}

/// Status of visual asset deployment under ISO 9001:2015 quality standards.
enum DeploymentStatus {
  deployed,
  pendingAudit,
  deprecated,
  failedVerification,
}

/// Environment target for system-verb visual asset mapping.
enum DeploymentEnvironment {
  production,
  staging,
  qa,
  development,
}

/// Audit record capturing atomic deployment fields for visual assets.
class IconAuditRecord {
  final String assetId;
  final SystemVerb verb;
  final String verbDescription;
  final DeploymentStatus status;
  final DeploymentEnvironment environment;
  final DateTime deploymentDate;
  final String deploymentVersion;
  final bool rollbackStatus;
  final double executionQualityScore; // 0.0 to 1.0 (Optimal: >= 0.98, Floor: >= 0.90)

  const IconAuditRecord({
    required this.assetId,
    required this.verb,
    required this.verbDescription,
    required this.status,
    required this.environment,
    required this.deploymentDate,
    required this.deploymentVersion,
    required this.rollbackStatus,
    required this.executionQualityScore,
  });

  String get qualitativeScoreRating {
    if (executionQualityScore >= 0.98) return 'Good (100%)';
    if (executionQualityScore >= 0.90) return 'Average';
    return 'Poor';
  }
}

/// Standard vector icon painter delivering SVG-equivalent deterministic vectors
/// strictly bounded within 24x24dp coordinates.
class SystemVerbVectorPainter extends CustomPainter {
  final SystemVerb verb;
  final Color color;

  const SystemVerbVectorPainter({
    required this.verb,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Normalize to 24x24dp coordinate box regardless of parent constraints
    final double scaleX = size.width / 24.0;
    final double scaleY = size.height / 24.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);

    switch (verb) {
      case SystemVerb.sync:
        final rect = Rect.fromCircle(center: const Offset(12, 12), radius: 8);
        canvas.drawArc(rect, 0.4, 2.3, false, paint);
        canvas.drawArc(rect, 3.5, 2.3, false, paint);
        final arrow1 = Path()
          ..moveTo(18, 5)
          ..lineTo(21, 8)
          ..lineTo(17, 9);
        final arrow2 = Path()
          ..moveTo(6, 19)
          ..lineTo(3, 16)
          ..lineTo(7, 15);
        canvas.drawPath(arrow1, paint);
        canvas.drawPath(arrow2, paint);
        break;

      case SystemVerb.refresh:
        final rect = Rect.fromCircle(center: const Offset(12, 12), radius: 8);
        canvas.drawArc(rect, -math.pi / 2, 1.6 * math.pi, false, paint);
        final arrow = Path()
          ..moveTo(12, 2)
          ..lineTo(14, 4)
          ..lineTo(10, 5);
        canvas.drawPath(arrow, paint);
        break;

      case SystemVerb.rollback:
        final rect = Rect.fromCircle(center: const Offset(12, 12), radius: 8);
        canvas.drawArc(rect, -0.2, -1.5 * math.pi, false, paint);
        final arrow = Path()
          ..moveTo(12, 4)
          ..lineTo(10, 6)
          ..lineTo(14, 7);
        canvas.drawPath(arrow, paint);
        break;

      case SystemVerb.execute:
        final playPath = Path()
          ..moveTo(8, 5)
          ..lineTo(19, 12)
          ..lineTo(8, 19)
          ..close();
        canvas.drawPath(playPath, fillPaint);
        break;

      case SystemVerb.terminate:
        canvas.drawLine(const Offset(6, 6), const Offset(18, 18), paint);
        canvas.drawLine(const Offset(18, 6), const Offset(6, 18), paint);
        break;

      case SystemVerb.commit:
        final circleRect = Rect.fromCircle(center: const Offset(12, 12), radius: 4);
        canvas.drawOval(circleRect, fillPaint);
        canvas.drawLine(const Offset(2, 12), const Offset(8, 12), paint);
        canvas.drawLine(const Offset(16, 12), const Offset(22, 12), paint);
        break;

      case SystemVerb.audit:
        final doc = Rect.fromLTWH(5, 3, 14, 18);
        canvas.drawRRect(RRect.fromRectAndRadius(doc, const Radius.circular(2)), paint);
        canvas.drawLine(const Offset(8, 8), const Offset(16, 8), paint);
        canvas.drawLine(const Offset(8, 12), const Offset(16, 12), paint);
        canvas.drawLine(const Offset(8, 16), const Offset(13, 16), paint);
        break;

      case SystemVerb.filter:
        final funnel = Path()
          ..moveTo(4, 5)
          ..lineTo(20, 5)
          ..lineTo(14, 13)
          ..lineTo(14, 19)
          ..lineTo(10, 17)
          ..lineTo(10, 13)
          ..close();
        canvas.drawPath(funnel, paint);
        break;

      case SystemVerb.navigateNext:
        final path = Path()
          ..moveTo(9, 6)
          ..lineTo(15, 12)
          ..lineTo(9, 18);
        canvas.drawPath(path, paint);
        break;

      case SystemVerb.navigateBack:
        final path = Path()
          ..moveTo(15, 6)
          ..lineTo(9, 12)
          ..lineTo(15, 18);
        canvas.drawPath(path, paint);
        break;
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SystemVerbVectorPainter oldDelegate) {
    return oldDelegate.verb != verb || oldDelegate.color != color;
  }
}

/// Enforces a strict 24x24dp visual bounding box embedded in a minimum 48x48dp
/// phantom padding touch target for accessibility and compact mobile UX compliance.
class SystemVerbIconButton extends StatelessWidget {
  final SystemVerb verb;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final Color? color;
  final bool showHitAreaBounds;

  const SystemVerbIconButton({
    super.key,
    required this.verb,
    this.onPressed,
    this.semanticLabel,
    this.color,
    this.showHitAreaBounds = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.onSurface;

    return Semantics(
      label: semanticLabel ?? 'System Action: ${verb.name}',
      button: true,
      enabled: onPressed != null,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            // Minimum 48x48dp phantom touch target padding area
            constraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            alignment: Alignment.center,
            decoration: showHitAreaBounds
                ? BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.35),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  )
                : null,
            child: SizedBox(
              // Strict 24x24dp dimension bounding box for structural vector icon
              width: 24,
              height: 24,
              child: CustomPaint(
                size: const Size(24, 24),
                painter: SystemVerbVectorPainter(
                  verb: verb,
                  color: effectiveColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// System-Verb Icon Mapping Matrix and Audit Inspector Widget.
class SystemVerbIconMatrixWidget extends StatefulWidget {
  final List<IconAuditRecord>? auditRecords;
  final ValueChanged<SystemVerb>? onVerbSelected;
  final String deploymentVersion;
  final String deploymentEnvironment;

  const SystemVerbIconMatrixWidget({
    super.key,
    this.auditRecords,
    this.onVerbSelected,
    this.deploymentVersion = 'v1.4.2',
    this.deploymentEnvironment = 'Production',
  });

  @override
  State<SystemVerbIconMatrixWidget> createState() =>
      _SystemVerbIconMatrixWidgetState();
}

class _SystemVerbIconMatrixWidgetState
    extends State<SystemVerbIconMatrixWidget> {
  late List<IconAuditRecord> _records;
  SystemVerb? _selectedVerb;
  bool _visualizeHitAreas = false;

  @override
  void initState() {
    super.initState();
    _records = widget.auditRecords ?? _getDefaultAuditCatalog();
    if (_records.isNotEmpty) {
      _selectedVerb = _records.first.verb;
    }
  }

  List<IconAuditRecord> _getDefaultAuditCatalog() {
    final now = DateTime.now();
    return [
      IconAuditRecord(
        assetId: 'SVG-SYS-001',
        verb: SystemVerb.sync,
        verbDescription: 'Synchronize remote delta cache',
        status: DeploymentStatus.deployed,
        environment: DeploymentEnvironment.production,
        deploymentDate: now.subtract(const Duration(days: 4)),
        deploymentVersion: '1.4.2',
        rollbackStatus: false,
        executionQualityScore: 0.99,
      ),
      IconAuditRecord(
        assetId: 'SVG-SYS-002',
        verb: SystemVerb.refresh,
        verbDescription: 'Invalidate and reload view state',
        status: DeploymentStatus.deployed,
        environment: DeploymentEnvironment.production,
        deploymentDate: now.subtract(const Duration(days: 4)),
        deploymentVersion: '1.4.2',
        rollbackStatus: false,
        executionQualityScore: 0.98,
      ),
      IconAuditRecord(
        assetId: 'SVG-SYS-003',
        verb: SystemVerb.rollback,
        verbDescription: 'Revert deployment bundle to previous snapshot',
        status: DeploymentStatus.deployed,
        environment: DeploymentEnvironment.production,
        deploymentDate: now.subtract(const Duration(days: 3)),
        deploymentVersion: '1.4.2',
        rollbackStatus: true,
        executionQualityScore: 0.95,
      ),
      IconAuditRecord(
        assetId: 'SVG-SYS-004',
        verb: SystemVerb.execute,
        verbDescription: 'Dispatch asynchronous batch pipeline',
        status: DeploymentStatus.deployed,
        environment: DeploymentEnvironment.production,
        deploymentDate: now.subtract(const Duration(days: 2)),
        deploymentVersion: '1.4.2',
        rollbackStatus: false,
        executionQualityScore: 1.0,
      ),
      IconAuditRecord(
        assetId: 'SVG-SYS-005',
        verb: SystemVerb.terminate,
        verbDescription: 'Abort background processing worker',
        status: DeploymentStatus.deployed,
        environment: DeploymentEnvironment.production,
        deploymentDate: now.subtract(const Duration(days: 2)),
        deploymentVersion: '1.4.2',
        rollbackStatus: false,
        executionQualityScore: 0.97,
      ),
      IconAuditRecord(
        assetId: 'SVG-SYS-006',
        verb: SystemVerb.commit,
        verbDescription: 'Persist staged atomic transaction',
        status: DeploymentStatus.deployed,
        environment: DeploymentEnvironment.production,
        deploymentDate: now.subtract(const Duration(days: 1)),
        deploymentVersion: '1.4.2',
        rollbackStatus: false,
        executionQualityScore: 0.99,
      ),
      IconAuditRecord(
        assetId: 'SVG-SYS-007',
        verb: SystemVerb.audit,
        verbDescription: 'Verify ISO 9001:2015 asset logs',
        status: DeploymentStatus.deployed,
        environment: DeploymentEnvironment.production,
        deploymentDate: now,
        deploymentVersion: '1.4.2',
        rollbackStatus: false,
        executionQualityScore: 0.98,
      ),
      IconAuditRecord(
        assetId: 'SVG-SYS-008',
        verb: SystemVerb.filter,
        verbDescription: 'Restrict active dataset predicates',
        status: DeploymentStatus.deployed,
        environment: DeploymentEnvironment.production,
        deploymentDate: now,
        deploymentVersion: '1.4.2',
        rollbackStatus: false,
        executionQualityScore: 0.96,
      ),
    ];
  }

  double get _aggregateQualityScore {
    if (_records.isEmpty) return 1.0;
    final total = _records.fold<double>(
        0.0, (sum, record) => sum + record.executionQualityScore);
    return total / _records.length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avgScore = _aggregateQualityScore;
    final isOptimal = avgScore >= 0.98;
    final isAboveFloor = avgScore >= 0.90;

    final currentRecord = _records.firstWhere(
      (r) => r.verb == _selectedVerb,
      orElse: () => _records.first,
    );

    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header & Compliance Banner
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System-Verb Icon Matrix',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Strict 24x24dp Bounds | 48x48dp Phantom Touch Targets',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isOptimal
                        ? Colors.green.withOpacity(0.12)
                        : isAboveFloor
                            ? Colors.orange.withOpacity(0.12)
                            : Colors.red.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isOptimal
                          ? Colors.green
                          : isAboveFloor
                              ? Colors.orange
                              : Colors.red,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Score: ${(avgScore * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isOptimal
                          ? Colors.green.shade800
                          : isAboveFloor
                              ? Colors.orange.shade800
                              : Colors.red.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Control bar for Hit Target Bounds
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Display Hit Targets (Phantom Padding):',
                  style: theme.textTheme.labelMedium,
                ),
                Switch.adaptive(
                  value: _visualizeHitAreas,
                  onChanged: (val) => setState(() => _visualizeHitAreas = val),
                ),
              ],
            ),
            const Divider(height: 20),
            // Matrix Grid of System-Verb Icons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _records.map((record) {
                final isSelected = record.verb == _selectedVerb;
                return Tooltip(
                  message: 'Verb: ${record.verb.name}\nBox: 24x24dp\nHit Area: ≥48x48dp',
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primaryContainer
                          : theme.colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: SystemVerbIconButton(
                      verb: record.verb,
                      showHitAreaBounds: _visualizeHitAreas,
                      color: isSelected
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSurface,
                      onPressed: () {
                        setState(() => _selectedVerb = record.verb);
                        widget.onVerbSelected?.call(record.verb);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Audit and Deployment Details Inspection Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: theme.colorScheme.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Asset ID: ${currentRecord.assetId}',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rating: ${currentRecord.qualitativeScoreRating}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: currentRecord.executionQualityScore >= 0.98
                              ? Colors.green.shade700
                              : Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Verb: ${currentRecord.verb.name.toUpperCase()} — ${currentRecord.verbDescription}',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      _buildMetaTag('Env', currentRecord.environment.name),
                      _buildMetaTag('Version', currentRecord.deploymentVersion),
                      _buildMetaTag('Status', currentRecord.status.name),
                      _buildMetaTag(
                        'Rollback',
                        currentRecord.rollbackStatus ? 'Enabled' : 'None',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaTag(String label, String value) {
    return Text(
      '$label: $value',
      style: const TextStyle(
        fontSize: 10,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
