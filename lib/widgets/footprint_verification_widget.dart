import 'package:flutter/material.dart';
import '../models/corporate_footprint_model.dart';

class FootprintVerificationWidget extends StatefulWidget {
  const FootprintVerificationWidget({super.key});

  @override
  State<FootprintVerificationWidget> createState() =>
      _FootprintVerificationWidgetState();
}

class _FootprintVerificationWidgetState
    extends State<FootprintVerificationWidget> {
  final List<CorporateTransactionFootprint> _sampleTransactions = [
    CorporateTransactionFootprint(
      transactionId: 'TXN-FOOTPRINT-8891',
      expenseCategory: 'EXP_CAPEX_EQUIPMENT',
      requestedLicenseClause: 'CLAUSE_9B_CAPEX_PROCUREMENT',
      transactionAmountUsd: 145000.00,
    ),
    CorporateTransactionFootprint(
      transactionId: 'TXN-FOOTPRINT-8892',
      expenseCategory: 'EXP_OPEX_COMMUNICATIONS',
      requestedLicenseClause: 'CLAUSE_4A_TELECOM_SERVICES',
      transactionAmountUsd: 12400.00,
    ),
    CorporateTransactionFootprint(
      transactionId: 'TXN-FOOTPRINT-8893',
      expenseCategory: 'EXP_UNLICENSED_CRYPTO_FX',
      requestedLicenseClause: 'CLAUSE_NONE_REJECTED',
      transactionAmountUsd: 89000.00,
    ),
  ];

  int _selectedTxnIndex = 0;
  bool _isEvaluating = false;

  CorporateTransactionFootprint get _activeTxn =>
      _sampleTransactions[_selectedTxnIndex];

  bool get _isBinaryRulePassed => FootprintBinaryRuleEngine.evaluateBinaryRule(
    _activeTxn.expenseCategory,
    _activeTxn.requestedLicenseClause,
  );

  FootprintAuditTelemetry get _telemetry => FootprintAuditTelemetry(
    stepExecutionId: 'EXEC-3042GCCC-2026',
    executionStatus: _isBinaryRulePassed ? 'PASS' : 'BINARY_RULE_VIOLATION',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome: _isBinaryRulePassed
        ? 'Binary Rule Passed (1). Transaction category matches approved corporate clause.'
        : 'Binary Rule Failed (0). Unlicensed expense category rejected by governance rules.',
    userId: 'ANIK-GOVERNANCE-ARCHITECT',
  );

  void _runAutomatedVerification() {
    setState(() => _isEvaluating = true);

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() => _isEvaluating = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isBinaryRulePassed
                  ? 'BINARY VALIDATION PASS: Transaction footprint verified against corporate license.'
                  : 'BINARY VALIDATION FAIL: Rejection logged for unlicensed footprint.',
            ),
            backgroundColor: _isBinaryRulePassed
                ? Colors.teal.shade800
                : Theme.of(context).colorScheme.error,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final activeTxn = _activeTxn;
    final bool isPassed = _isBinaryRulePassed;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Corporate Footprint Rule Engine'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp spatial margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. IIBA BABOK V3 COMPLETENESS BENCHMARK BANNER
            // =========================================================
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.gavel_rounded,
                      color: Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Requirements Completeness: Complete (1.0)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'IIBA BABOK v3 Benchmark • Approved by GACL Lead Counsel.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 2. TRANSACTION SELECTOR USING OVERSIZED TOUCH CHIPS (>=48DP)
            // =========================================================
            Text(
              'Select Corporate Transaction Footprint',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(_sampleTransactions.length, (index) {
                final isSelected = _selectedTxnIndex == index;
                final txn = _sampleTransactions[index];
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 48.0, // Minimum 48dp Touch Target Constraint
                  ),
                  child: ChoiceChip(
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        txn.transactionId,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: colorScheme.primaryContainer,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedTxnIndex = index);
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 3. MATERIAL 3 CHIPS & STATE-COLOR BINDING DISPLAY
            // =========================================================
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          activeTxn.transactionId,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '\$${activeTxn.transactionAmountUsd.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'Footprint Parameters & Material 3 Chips',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // M3 CHIPS ARRAY WITH CLEAN TYPOGRAPHY FORMATTING
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        Chip(
                          avatar: const Icon(Icons.category_rounded, size: 16),
                          label: Text(
                            activeTxn.expenseCategory,
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: colorScheme.surfaceContainerHighest,
                        ),
                        Chip(
                          avatar: const Icon(
                            Icons.assignment_turned_in_rounded,
                            size: 16,
                          ),
                          label: Text(
                            activeTxn.requestedLicenseClause,
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: colorScheme.surfaceContainerHighest,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 16),

                    // BINARY VALIDATION OUTPUT CHIP DIRECTLY CONNECTED TO STATE COLOR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Binary Verification Check:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        // STATE COLOR BINDING CHIP
                        RawChip(
                          avatar: Icon(
                            isPassed
                                ? Icons.check_circle_rounded
                                : Icons.cancel_rounded,
                            size: 18,
                            color: isPassed ? Colors.white : Colors.white,
                          ),
                          label: Text(
                            isPassed
                                ? 'BINARY_PASS (V=1)'
                                : 'BINARY_FAIL (V=0)',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          backgroundColor: isPassed
                              ? const Color(0xFF0F382C) // Dark Emerald Pass
                              : const Color(0xFF4A0E17), // Crimson Red Fail
                          side: BorderSide(
                            color: isPassed ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 4. OVERSIZED TOUCH BUTTON FOR AUTOMATED VERIFICATION (>=48DP)
            // =========================================================
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 48.0,
                minHeight: 48.0, // Minimum 48dp Touch Area Spec
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPassed
                        ? colorScheme.primary
                        : colorScheme.errorContainer,
                    foregroundColor: isPassed
                        ? colorScheme.onPrimary
                        : colorScheme.onErrorContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _isEvaluating ? null : _runAutomatedVerification,
                  icon: _isEvaluating
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          isPassed
                              ? Icons.verified_user_rounded
                              : Icons.block_rounded,
                        ),
                  label: Text(
                    isPassed
                        ? 'EXECUTE_FOOTPRINT_VERIFICATION'
                        : 'REJECT_UNLICENSED_FOOTPRINT',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 5. ATOMIC TELEMETRY METADATA LOG DISPLAY
            // =========================================================
            Text(
              'Atomic Step Execution Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildTelemetryRow(
                      'Step Execution ID',
                      telemetry.stepExecutionId,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Execution Status',
                      telemetry.executionStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Execution Timestamp',
                      telemetry.executionTimestamp.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('Step Outcome', telemetry.stepOutcome),
                    const Divider(height: 12),
                    _buildTelemetryRow('User ID', telemetry.userId),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight
                  ? (_isBinaryRulePassed
                        ? Colors.teal.shade800
                        : Colors.red.shade800)
                  : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
