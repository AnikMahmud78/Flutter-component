import 'package:flutter/foundation.dart';

@immutable
class AddOnSelectorModel {
  final String addOnId;
  final String addOnTitle;
  final double price;
  final bool isSelected;
  final double attachRate;

  const AddOnSelectorModel({
    required this.addOnId,
    required this.addOnTitle,
    required this.price,
    required this.isSelected,
    required this.attachRate,
  });

  String get completionStatus {
    if (attachRate >= 0.25) return 'Good';
    if (attachRate >= 0.10) return 'Average';
    return 'Poor';
  }
}
