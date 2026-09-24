class RecruiterResponse {
  final String candidateId;
  final String recruiterId;
  final String decision; // Approved, Rejected, OnHold
  final String notes;
  final DateTime timestamp;

  const RecruiterResponse({
    required this.candidateId,
    required this.recruiterId,
    required this.decision,
    required this.notes,
    required this.timestamp,
  });

  Map<String, dynamic> toBigQueryEvent() => {
        'candidate_id': candidateId,
        'recruiter_id': recruiterId,
        'decision': decision,
        'notes': notes,
        'event_timestamp': timestamp.toIso8601String(),
      };
}
