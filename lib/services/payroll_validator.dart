import '../models/payroll_entry.dart';

class PayrollValidator {
  bool validateIbanIso20022(String iban) {
    final clean = iban.replaceAll(' ', '').toUpperCase();
    if (clean.length < 15 || clean.length > 34) return false;
    return RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z0-9]+$').hasMatch(clean);
  }

  PayrollEntry processEntry(String employeeId, String rawIban, double amount) {
    final isValid = validateIbanIso20022(rawIban);
    return PayrollEntry(
      employeeId: employeeId,
      iban: rawIban,
      amount: amount,
      isAutoProcessed: isValid,
    );
  }
}
