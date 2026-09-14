// CSIVW-012-A02 — Bulk Action Guardrail Modal with Text Verification and Progress Tracking.
// Provides high-risk mass deletion and adjustment safeguards requiring explicit confirmation words (e.g. "CONFIRM"),
// responsive desktop centered modal or mobile full-width sheet layouts, high-priority row summaries, and processing progress.

import 'package:flutter/material.dart';

/// Configuration record capturing atomic audit fields.
class BulkActionConfig {
  final String configKey;
  final String configValue;
  final String configType;
  final String validationStatus;
  final DateTime configTimestamp;
  final String? userSessionId;

  const BulkActionConfig({
    required this.configKey,
    required this.configValue,
    this.configType = 'HighRiskSafetyGate',
    this.validationStatus = 'Pending',
    required this.configTimestamp,
    this.userSessionId,
  });

  BulkActionConfig copyWith({
    String? validationStatus,
    DateTime? configTimestamp,
  }) {
    return BulkActionConfig(
      configKey: configKey,
      configValue: configValue,
      configType: configType,
      validationStatus: validationStatus ?? this.validationStatus,
      configTimestamp: configTimestamp ?? this.configTimestamp,
      userSessionId: userSessionId,
    );
  }
}

/// High-priority record summary item.
class HighPriorityItemSummary {
  final String id;
  final String title;
  final String? subtitle;

  const HighPriorityItemSummary({
    required this.id,
    required this.title,
    this.subtitle,
  });
}

/// Responsive guardrail modal preventing accidental bulk actions.
class BulkActionGuardrailModal extends StatefulWidget {
  final String actionTitle;
  final String verificationWord;
  final int targetCount;
  final int safeBenchmarkCount;
  final List<HighPriorityItemSummary> affectedItems;
  final Future<void> Function() onConfirmAction;
  final VoidCallback? onCancelled;
  final String? userSessionId;

  const BulkActionGuardrailModal({
    super.key,
    this.actionTitle = 'Mass Deletion Trigger',
    this.verificationWord = 'CONFIRM',
    required this.targetCount,
    this.safeBenchmarkCount = 50,
    this.affectedItems = const [],
    required this.onConfirmAction,
    this.onCancelled,
    this.userSessionId,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String actionTitle,
    required int targetCount,
    String verificationWord = 'CONFIRM',
    int safeBenchmarkCount = 50,
    List<HighPriorityItemSummary> affectedItems = const [],
    required Future<void> Function() onConfirmAction,
    String? userSessionId,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: BulkActionGuardrailModal(
            actionTitle: actionTitle,
            targetCount: targetCount,
            verificationWord: verificationWord,
            safeBenchmarkCount: safeBenchmarkCount,
            affectedItems: affectedItems,
            onConfirmAction: onConfirmAction,
            userSessionId: userSessionId,
          ),
        ),
      );
    }

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: BulkActionGuardrailModal(
            actionTitle: actionTitle,
            targetCount: targetCount,
            verificationWord: verificationWord,
            safeBenchmarkCount: safeBenchmarkCount,
            affectedItems: affectedItems,
            onConfirmAction: onConfirmAction,
            userSessionId: userSessionId,
          ),
        ),
      ),
    );
  }

  @override
  State<BulkActionGuardrailModal> createState() =>
      _BulkActionGuardrailModalState();
}

class _BulkActionGuardrailModalState extends State<BulkActionGuardrailModal> {
  late final TextEditingController _inputController;
  late BulkActionConfig _auditConfig;
  bool _isProcessing = false;
  double? _processingProgress;
  String? _errorMessage;

  bool get _isVerificationMatched =>
      _inputController.text.trim() == widget.verificationWord;

  @override
  void initState({
    super.initState();
    _inputController = TextEditingController();
    _auditConfig = BulkActionConfig(
      configKey: 'BULK_GUARD_${widget.actionTitle.toUpperCase().replaceAll(' ', '_')}',
      configValue: 'TargetCount: ${widget.targetCount}',
      configTimestamp: DateTime.now().toUtc(),
      userSessionId: widget.userSessionId,
    );
    _inputController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _inputController.removeListener(_onTextChanged);
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _handleConfirm() async {
    if (!_isVerificationMatched || _isProcessing) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
      _processingProgress = 0.1;
      _auditConfig = _auditConfig.copyWith(
        validationStatus: 'Processing',
        configTimestamp: DateTime.now().toUtc(),
      );
    });

    try {
      setState(() => _processingProgress = 0.5);
      await widget.onConfirmAction();
      setState(() {
        _processingProgress = 1.0;
        _auditConfig = _auditConfig.copyWith(
          validationStatus: 'Pass',
          configTimestamp: DateTime.now().toUtc(),
        );
      });

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (err) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _processingProgress = null;
          _errorMessage = err.toString();
          _auditConfig = _auditConfig.copyWith(
            validationStatus: 'Fail',
            configTimestamp: DateTime.now().toUtc(),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isAboveBenchmark = widget.targetCount >= widget.safeBenchmarkCount;

    const warningColor = Color(0xFFD97706); // Amber-700
    const warningBgColor = Color(0xFFFEF3C7); // Amber-50
    const dangerColor = Color(0xFFDC2626); // Red-600

    final containerColor = isAboveBenchmark
        ? (theme.brightness == Brightness.dark
            ? const Color(0xFF451A03)
            : warningBgColor)
        : theme.colorScheme.surfaceVariant.withOpacity(0.3);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: isMobile
            ? const BorderRadius.vertical(top: Radius.circular(20))
            : BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Icon & Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isAboveBenchmark
                        ? dangerColor.withOpacity(0.12)
                        : warningColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: isAboveBenchmark ? dangerColor : warningColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.actionTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Step CSIVW-012-A02 Security Guardrail',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!_isProcessing)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      widget.onCancelled?.call();
                      Navigator.of(context).pop(false);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Callout Banner with Bold Item Count
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isAboveBenchmark
                      ? warningColor.withOpacity(0.6)
                      : theme.colorScheme.outlineVariant,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${widget.targetCount}',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: isAboveBenchmark
                              ? (theme.brightness == Brightness.dark
                                  ? Colors.amberAccent
                                  : warningColor)
                              : theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'total active records queued for adjustment.',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isAboveBenchmark
                        ? 'Target count exceeds operational benchmark (${widget.safeBenchmarkCount}). This operation will permanently impact large project specifications.'
                        : 'Proceed with caution. Modifying these active lines will trigger mass cloud synchronization.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            // Desktop summaries or priority row preview
            if (widget.affectedItems.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'High-Priority Rows Impacted:',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                constraints: const BoxConstraints(maxHeight: 140),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.affectedItems.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: theme.colorScheme.outlineVariant,
                  ),
                  itemBuilder: (context, idx) {
                    final item = widget.affectedItems[idx];
                    return ListTile(
                      dense: true,
                      title: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: item.subtitle != null
                          ? Text(
                              item.subtitle!,
                              style: theme.textTheme.bodySmall,
                            )
                          : null,
                      leading: const Icon(Icons.shield_outlined, size: 18),
                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Confirmation Verification Input
            Text(
              'Type "${widget.verificationWord}" below to unlock action confirmation:',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              enabled: !_isProcessing,
              autofocus: true,
              textCapitalization: TextCapitalization.characters,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Enter "${widget.verificationWord}"',
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.lock_clock_outlined),
                suffixIcon: _isVerificationMatched
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : null,
              ),
            ),

            // Error text if failure occurs
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: dangerColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: dangerColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: dangerColor, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Background Processing Progress Indicator
            if (_isProcessing) ...[
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: _processingProgress,
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isAboveBenchmark ? dangerColor : warningColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Processing bulk updates in background queue... Active tables remain locked.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isProcessing
                      ? null
                      : () {
                          widget.onCancelled?.call();
                          Navigator.of(context).pop(false);
                        },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: isAboveBenchmark ? dangerColor : warningColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        theme.colorScheme.onSurface.withOpacity(0.12),
                  ),
                  onPressed:
                      (!_isVerificationMatched || _isProcessing)
                          ? null
                          : _handleConfirm,
                  child: _isProcessing
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Confirm & Execute'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
