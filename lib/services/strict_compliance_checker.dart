class StrictComplianceChecker {
  bool checkSoxCompliance(Map<String, dynamic> auditData) {
    if (auditData.containsKey('isApproved') && auditData.containsKey('hasAuditTrail')) {
      final bool isApproved = auditData['isApproved'] == true;
      final bool hasAuditTrail = auditData['hasAuditTrail'] == true;
      return isApproved && hasAuditTrail;
    }
    return false;
  }

  bool checkEncryptionStatus(bool isTlsActive, bool isAes256AtRest) {
    return isTlsActive && isAes256AtRest;
  }
}
