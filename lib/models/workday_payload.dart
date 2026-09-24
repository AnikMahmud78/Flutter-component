class WorkdayPayload {
  final String applicantId;
  final String ssnHash;
  final String packageCode;
  final String callbackUrl;

  const WorkdayPayload({
    required this.applicantId,
    required this.ssnHash,
    required this.packageCode,
    required this.callbackUrl,
  });

  Map<String, dynamic> toVendorJson() => {
        'applicant_id': applicantId,
        'ssn_hash': ssnHash,
        'package_code': packageCode,
        'callback_url': callbackUrl,
      };
}
