// lib/models/financial_reconciliation_model.dart
class FinancialReconciliationModel {
  final double unreconciledVariance;
  final bool isBalanced;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const FinancialReconciliationModel({
    required this.unreconciledVariance,
    required this.isBalanced,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
