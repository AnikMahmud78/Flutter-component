import 'package:flutter/foundation.dart';

@immutable
class CategoryGridModel {
  final List<String> categories;
  final int timeToFindSeconds;

  const CategoryGridModel({
    required this.categories,
    required this.timeToFindSeconds,
  });

  String get completionStatus {
    if (timeToFindSeconds <= 3) return 'Good';
    if (timeToFindSeconds <= 10) return 'Average';
    return 'Poor';
  }
}
