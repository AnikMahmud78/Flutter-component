import '../models/workday_payload.dart';

class WorkdayPayloadMapper {
  WorkdayPayload buildPayload({
    required String rawId,
    required String rawSsn,
    required String selectedPackage,
  }) {
    return WorkdayPayload(
      applicantId: rawId.trim(),
      ssnHash: 'HASHED_${rawSsn.hashCode}',
      packageCode: selectedPackage,
      callbackUrl: 'https://api.habot.io/v1/workday/callback',
    );
  }

  bool validateMapping(WorkdayPayload payload) {
    return payload.applicantId.isNotEmpty &&
        payload.ssnHash.isNotEmpty &&
        payload.packageCode.isNotEmpty;
  }
}
