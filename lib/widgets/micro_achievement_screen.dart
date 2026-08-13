import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../models/point_ingestion_model.dart';

class MicroAchievementScreen extends StatefulWidget {
  const MicroAchievementScreen({super.key});

  @override
  State<MicroAchievementScreen> createState() => _MicroAchievementScreenState();
}

class _MicroAchievementScreenState extends State<MicroAchievementScreen> {
  final LoyaltyAccountState _accountState = LoyaltyAccountState();
  final List<PointIngestionAuditRecord> _auditLogs = [];

  bool _isIngesting = false;

  @override
  void initState() {
    super.initState();
    _recordAuditLog(
      parameter: 'LOYALTY_ENGINE_INITIALIZED',
      current: 'Active (1100 pts)',
      previous: '0 pts',
      log: 'System initialization baseline established.',
    );
  }

  void _recordAuditLog({
    required String parameter,
    required String current,
    required String previous,
    required String log,
  }) {
    final record = PointIngestionAuditRecord(
      configurationParameter: parameter,
      currentSetting: current,
      previousSetting: previous,
      changeLog: log,
      configurationTimestamp: DateTime.now().toUtc().toIso8601String(),
    );

    setState(() {
      _auditLogs.insert(0, record);
      if (_auditLogs.length > 10) _auditLogs.removeLast();
    });
  }

  /// Triggers Micro-Achievement Point Ingestion and explicitly announces balance updates to screen readers
  Future<void> _ingestMicroAchievement({
    required String title,
    required int pointsAwarded,
  }) async {
    setState(() => _isIngesting = true);

    await Future.delayed(const Duration(milliseconds: 400));

    final int oldBalance = _accountState.balancePoints;
    _accountState.ingestPoints(pointsAwarded);
    final int newBalance = _accountState.balancePoints;

    _recordAuditLog(
      parameter: 'POINT_REWARD_INGESTION',
      current: '$newBalance pts',
      previous: '$oldBalance pts',
      log: 'Ingested +$pointsAwarded pts for achievement: "$title"',
    );

    if (mounted) {
      setState(() => _isIngesting = false);

      // REQUIREMENT: Configure screen reader components to announce loyalty balance modifications explicitly
      final String accessibilityAnnouncement =
          'Loyalty balance updated! Earned $pointsAwarded achievement points for $title. New balance is $newBalance points.';

      SemanticsService.announce(
        accessibilityAnnouncement,
        Directionality.of(context),
      );

      // REQUIREMENT: Floating interaction alert popping up on screen block
      _showFloatingInteractionAlert(
        title: title,
        pointsAwarded: pointsAwarded,
        newBalance: newBalance,
      );
    }
  }

  void _showFloatingInteractionAlert({
    required String title,
    required int pointsAwarded,
    required int newBalance,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating, // Floating interaction alert
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.indigo.shade900,
        content: Row(
          children: [
            const Icon(Icons.stars_rounded, color: Colors.amber, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Micro-Achievement Unlocked!',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '$title (+$pointsAwarded pts) • Total: $newBalance pts',
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Micro-Achievement Ingestion'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // 16dp outer grid margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. LOYALTY BALANCE CARD WITH ACCESSIBILITY LIVE REGION
            // =========================================================
            Semantics(
              liveRegion: true, // Informs screen reader of live dynamic updates
              label:
                  'Current loyalty balance: ${_accountState.balancePoints} points',
              child: Card.filled(
                color: colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: colorScheme.primary,
                        child: Icon(
                          Icons.workspace_premium,
                          color: colorScheme.onPrimary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Loyalty Balance',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.onPrimaryContainer.withAlpha(
                                  200,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${_accountState.balancePoints} PTS',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.accessibility,
                              size: 14,
                              color: Colors.indigo,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'VoiceReady',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 2. TRIGGER ACTIONS (THUMB-FRIENDLY TAP TARGETS >= 48x48 DP)
            // =========================================================
            Text(
              'Simulate Ingestion Rewards',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: _isIngesting
                          ? null
                          : () => _ingestMicroAchievement(
                              title: 'Daily Checkout Streak',
                              pointsAwarded: 150,
                            ),
                      icon: const Icon(Icons.flash_on_rounded, size: 18),
                      label: const Text(
                        'Ingest Streak (+150)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: _isIngesting
                          ? null
                          : () => _ingestMicroAchievement(
                              title: 'Profile Verification',
                              pointsAwarded: 500,
                            ),
                      icon: const Icon(Icons.verified_user_rounded, size: 18),
                      label: const Text(
                        'Ingest Verify (+500)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 3. AUDIT CONFIGURATION CHANGE LOGS
            // =========================================================
            Text(
              'Atomic Audit & Change Logs',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _auditLogs.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final log = _auditLogs[index];
                  return ListTile(
                    dense: true,
                    title: Text(
                      log.configurationParameter,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    subtitle: Text(
                      '${log.changeLog}\nPrev: ${log.previousSetting} → Curr: ${log.currentSetting}',
                      style: const TextStyle(fontSize: 11),
                    ),
                    trailing: Text(
                      log.configurationTimestamp.substring(11, 19),
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: Colors.grey.shade600,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
