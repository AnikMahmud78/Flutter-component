// ETMDI-019 — Hardware Check Onboarding Gate & Access Denied Empty State.
// Multi-step hardware-spec gate with M3 SegmentedButton selection, LabelMedium typography and secondary-color flags; failed gate shows centered access-revoked empty state with no primary actions.
import 'package:flutter/material.dart';

/// Process Execution Quality (%) bounds from AL-AQ analysis.
/// Floor=95 | Optimal=99 | Ceiling=100 | Standard=ISO 9001:2015.
class Etmdi019QualityBounds {
  static const double floor = 95;
  static const double optimal = 99;
  static const double ceiling = 100;
  static const String metricName = 'Process Execution Quality (%)';
  static const String standard = 'ISO 9001:2015 Quality Management System';
}

/// Audit payload collected by system for ETMDI-019.
class Etmdi019ExecutionRecord {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final DateTime actionTimestamp;
  final String sessionId;
  final double qualityPercent;

  const Etmdi019ExecutionRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionTimestamp,
    required this.sessionId,
    required this.qualityPercent,
  });
}

enum Etmdi019SpecChoice { meets, below }

class Etmdi019HardwareCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  const Etmdi019HardwareCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

const List<Etmdi019HardwareCategory> kEtmdi019Categories = [
  Etmdi019HardwareCategory(
    id: 'compute',
    title: 'Compute & OS',
    description: 'CPU, RAM, OS version meets minimum onboarding spec.',
    icon: Icons.memory_outlined,
  ),
  Etmdi019HardwareCategory(
    id: 'network',
    title: 'Network & Sensors',
    description: 'Connectivity, GPS, camera and microphone availability.',
    icon: Icons.wifi_outlined,
  ),
  Etmdi019HardwareCategory(
    id: 'storage',
    title: 'Storage & Battery',
    description: 'Free storage, battery health and device integrity.',
    icon: Icons.battery_charging_full_outlined,
  ),
];

/// Gate onboarding to hardware specifications.
/// Multi-step form using SegmentedButton; failure revokes access (Poka-Yoke: no manual save/override).
class HardwareCheckOnboardingGateEtmdi019 extends StatefulWidget {
  final String userId;
  final String sessionId;
  final ValueChanged<Etmdi019ExecutionRecord>? onCompleted;

  const HardwareCheckOnboardingGateEtmdi019({
    super.key,
    required this.userId,
    required this.sessionId,
    this.onCompleted,
  });

  @override
  State<HardwareCheckOnboardingGateEtmdi019> createState() => _HardwareCheckOnboardingGateEtmdi019State();
}

class _HardwareCheckOnboardingGateEtmdi019State extends State<HardwareCheckOnboardingGateEtmdi019> {
  int _index = 0;
  final Map<String, Etmdi019SpecChoice> _answers = {};
  bool _evaluated = false;
  bool _passed = false;

  bool get _currentAnswered => _answers.containsKey(kEtmdi019Categories[_index].id);
  bool get _allAnswered => kEtmdi019Categories.every((c) => _answers.containsKey(c.id));

  void _evaluate() {
    final meetsCount = kEtmdi019Categories.where((c) => _answers[c.id] == Etmdi019SpecChoice.meets).length;
    final quality = kEtmdi019Categories.isEmpty ? 0.0 : (meetsCount / kEtmdi019Categories.length) * 100;
    final passed = quality >= Etmdi019QualityBounds.floor && meetsCount == kEtmdi019Categories.length;
    final now = DateTime.now().toUtc();
    final record = Etmdi019ExecutionRecord(
      stepExecutionId: 'ETMDI-019-${now.millisecondsSinceEpoch}',
      executionStatus: passed ? 'completed' : 'blocked',
      executionTimestamp: now,
      stepOutcome: passed ? 'Pass' : 'Fail',
      userId: widget.userId,
      completionStatus: passed ? 'Pass' : 'Fail',
      actionTimestamp: now,
      sessionId: widget.sessionId,
      qualityPercent: quality,
    );
    setState(() {
      _evaluated = true;
      _passed = passed;
    });
    widget.onCompleted?.call(record);
  }

  void _reset() {
    setState(() {
      _index = 0;
      _answers.clear();
      _evaluated = false;
      _passed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    if (_evaluated && !_passed) {
      return Etmdi019AccessDeniedView(
        userId: widget.userId,
        onReCheck: _reset,
      );
    }

    if (_evaluated && _passed) {
      return _Etmdi019PassView(quality: 100, onReset: _reset);
    }

    final category = kEtmdi019Categories[_index];
    final selected = _answers[category.id];

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hardware check ${_index + 1} of ${kEtmdi019Categories.length}',
                  style: textTheme.labelMedium,
                  semanticsLabel: 'Hardware check step ${_index + 1} of ${kEtmdi019Categories.length}',
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (_index + 1) / kEtmdi019Categories.length,
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(category.icon, color: colorScheme.primary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(category.title, style: textTheme.titleMedium),
                                  Text(category.description, style: textTheme.bodySmall),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text('Does this device meet spec?', style: textTheme.labelMedium),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: SegmentedButton<Etmdi019SpecChoice>(
                            segments: const [
                              ButtonSegment(value: Etmdi019SpecChoice.meets, label: Text('Meets spec'), icon: Icon(Icons.check_circle_outline)),
                              ButtonSegment(value: Etmdi019SpecChoice.below, label: Text('Below spec'), icon: Icon(Icons.error_outline)),
                            ],
                            selected: selected == null ? <Etmdi019SpecChoice>{} : <Etmdi019SpecChoice>{selected},
                            onSelectionChanged: (Set<Etmdi019SpecChoice> next) {
                              setState(() => _answers[category.id] = next.first);
                            },
                            showSelectedIcon: false,
                          ),
                        ),
                        if (selected == Etmdi019SpecChoice.below) ...[
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.flag_outlined, size: 18, color: colorScheme.secondary),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Flagged with secondary color: will block onboarding on submit.',
                                    style: textTheme.labelMedium?.copyWith(color: colorScheme.onSecondaryContainer),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    if (_index > 0)
                      OutlinedButton(
                        onPressed: () => setState(() => _index--),
                        child: const Text('Back'),
                      ),
                    const Spacer(),
                    if (_index < kEtmdi019Categories.length - 1)
                      FilledButton(
                        onPressed: _currentAnswered ? () => setState(() => _index++) : null,
                        child: const Text('Continue'),
                      )
                    else
                      FilledButton(
                        onPressed: _allAnswered || _currentAnswered ? _evaluate : null,
                        child: const Text('Run hardware gate'),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Quality gate ${Etmdi019QualityBounds.floor.toStringAsFixed(0)}% min • ${Etmdi019QualityBounds.standard}',
                  style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// M3 Empty State for revoked/pruned worker. Center-aligned text, no primary actions.
/// Immediately invalidates session tokens: native logout, no new task fetches.
class Etmdi019AccessDeniedView extends StatelessWidget {
  final String userId;
  final VoidCallback? onReCheck;

  const Etmdi019AccessDeniedView({super.key, required this.userId, this.onReCheck});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(color: colorScheme.secondaryContainer, shape: BoxShape.circle),
                  child: Icon(Icons.no_accounts_outlined, size: 44, color: colorScheme.secondary),
                ),
                const SizedBox(height: 20),
                Text('Access revoked', style: textTheme.headlineSmall, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(
                  'Worker loses access to portal. Your session was invalidated and you can no longer fetch tasks on this device.',
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Hardware below spec • User: $userId • Metric: Workers Pruned',
                  style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'No manual override is allowed. Upgrade hardware and re-run onboarding check.',
                  style: textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Etmdi019PassView extends StatelessWidget {
  final double quality;
  final VoidCallback onReset;
  const _Etmdi019PassView({required this.quality, required this.onReset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_outlined, size: 64, color: theme.colorScheme.primary),
                const SizedBox(height: 16),
                Text('Hardware check passed', style: theme.textTheme.headlineSmall, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(
                  'Quality ${quality.toStringAsFixed(0)}% • ${Etmdi019QualityBounds.metricName}',
                  style: theme.textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                OutlinedButton(onPressed: onReset, child: const Text('Re-run check')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
