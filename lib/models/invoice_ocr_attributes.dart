/// Data model holding extracted text-mining fields
class InvoiceOcrAttributes {
  String? vendorName;
  String? billDate;
  double? baseAmount;
  String? taxId;

  InvoiceOcrAttributes({
    this.vendorName,
    this.billDate,
    this.baseAmount,
    this.taxId,
  });

  bool get isVendorMissing => vendorName == null || vendorName!.trim().isEmpty;
  bool get isDateMissing => billDate == null || billDate!.trim().isEmpty;
  bool get isAmountMissing => baseAmount == null || baseAmount! <= 0;
  bool get isTaxIdMissing => taxId == null || taxId!.trim().isEmpty;

  bool get isComplete =>
      !isVendorMissing && !isDateMissing && !isAmountMissing && !isTaxIdMissing;
}
