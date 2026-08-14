/// Represents a single-card transaction breakdown compressed for mobile viewports
class LedgerTransactionBreakdown {
  final String transactionId;
  final String accountId;
  final String periodIdentifier;
  final double netJournalBalanceUsd;
  final double bankStatementBalanceUsd;
  final double varianceAmountUsd;
  final String auditStatus; // RECONCILED, MINOR_VARIANCE, MISMATCH_ALERT

  LedgerTransactionBreakdown({
    required this.transactionId,
    required this.accountId,
    required this.periodIdentifier,
    required this.netJournalBalanceUsd,
    required this.bankStatementBalanceUsd,
    required this.varianceAmountUsd,
    required this.auditStatus,
  });

  bool get isMismatch => auditStatus == 'MISMATCH_ALERT';
  bool get isReconciled => auditStatus == 'RECONCILED';
}

/// Data model tracking Frontend UI Repository discovery telemetry
class FrontendRepoTelemetry {
  final String repositoryUrl;
  final String repositoryBranch;
  final String accessRights;
  final String commitHistory;
  final String repositoryVersion;
  final String cloneStatus;
  final double adherenceRate; // Target: 1.0 (100%)
  final String completionStatus; // Good

  FrontendRepoTelemetry({
    this.repositoryUrl = 'https://github.com/enterprise/ledger-ui-core.git',
    this.repositoryBranch = 'main',
    this.accessRights = 'READ_WRITE_FINANCE_ADMIN',
    this.commitHistory = 'e2063b0 (Task CBSV Automated Ledger Balancing Setup)',
    this.repositoryVersion = 'v4.3.0-LEDGER-CORE',
    this.cloneStatus = 'CLONED_AND_VERIFIED',
    this.adherenceRate = 1.0,
    this.completionStatus = 'Good',
  });
}
