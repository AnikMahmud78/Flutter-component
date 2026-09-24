class PayrollEntry {
  final String employeeId;
  final String iban;
  final double amount;
  final bool isAutoProcessed;

  const PayrollEntry({
    required this.employeeId,
    required this.iban,
    required this.amount,
    required this.isAutoProcessed,
  });
}
