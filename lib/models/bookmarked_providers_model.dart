import 'package:flutter/foundation.dart';

@immutable
class BookmarkedProvidersModel {
  final String providerName;
  final int totalBookmarks;
  final double persistenceReliabilityScore;

  const BookmarkedProvidersModel({
    required this.providerName,
    required this.totalBookmarks,
    required this.persistenceReliabilityScore,
  });

  String get completionStatus => persistenceReliabilityScore >= 0.98 ? 'Pass' : 'Fail';
}
