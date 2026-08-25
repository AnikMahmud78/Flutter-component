import 'package:flutter/foundation.dart';

/// Represents a multi-agent rating verification packet
@immutable
class AiRatingPacket {
  final String packetId;
  final String primaryAiRating;
  final String reviewerAgentRating;
  final String fusedDataSummary;
  final double confidenceScore;
  final bool isConsensusAchieved;

  const AiRatingPacket({
    required this.packetId,
    required this.primaryAiRating,
    required this.reviewerAgentRating,
    required this.fusedDataSummary,
    required this.confidenceScore,
    required this.isConsensusAchieved,
  });

  AiRatingPacket copyWith({
    String? primaryAiRating,
    String? reviewerAgentRating,
    bool? isConsensusAchieved,
  }) {
    return AiRatingPacket(
      packetId: packetId,
      primaryAiRating: primaryAiRating ?? this.primaryAiRating,
      reviewerAgentRating: reviewerAgentRating ?? this.reviewerAgentRating,
      fusedDataSummary: fusedDataSummary,
      confidenceScore: confidenceScore,
      isConsensusAchieved: isConsensusAchieved ?? this.isConsensusAchieved,
    );
  }
}

/// Atomic Telemetry Record for Task 7739ACRAE-005 Audits
class AiReviewerTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  AiReviewerTelemetryRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
