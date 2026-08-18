/// Represents a corporate transaction footprint item mapped against license clauses
class CorporateTransactionFootprint {
  final String transactionId;
  final String expenseCategory;
  final String requestedLicenseClause;
  final double transactionAmountUsd;

  CorporateTransactionFootprint({
    required this.transactionId,
    required this.expenseCategory,
    required this.requestedLicenseClause,
    required this.transactionAmountUsd,
  });
}

/// Binary verification engine evaluating expense categories against corporate license rules
class FootprintBinaryRuleEngine {
  static const Map<String, String> approvedClauseRegistry = {
    'EXP_CAPEX_EQUIPMENT': 'CLAUSE_9B_CAPEX_PROCUREMENT',
    'EXP_OPEX_COMMUNICATIONS': 'CLAUSE_4A_TELECOM_SERVICES',
    'EXP_R_AND_D_SOFTWARE': 'CLAUSE_12C_IP_LICENSING',
    'EXP_LOGISTICS_FREIGHT': 'CLAUSE_7D_SUPPLY_CHAIN',
  };

  /// Evaluates binary validation check: 1 = PASS, 0 = FAIL
  static bool evaluateBinaryRule(String expenseCategory, String licenseClause) {
    if (!approvedClauseRegistry.containsKey(expenseCategory)) return false;
    return approvedClauseRegistry[expenseCategory] == licenseClause;
  }
}

/// Data model tracking atomic telemetry for IIBA BABOK v3 compliance audits
class FootprintAuditTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;

  FootprintAuditTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
  });
}
