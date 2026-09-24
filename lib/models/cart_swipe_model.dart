import 'package:flutter/foundation.dart';

@immutable
class CartItemModel {
  final String itemId;
  final String title;
  final double price;

  const CartItemModel({
    required this.itemId,
    required this.title,
    required this.price,
  });
}

@immutable
class CartSwipeModel {
  final List<CartItemModel> items;
  final double cartIntegrityRate;

  const CartSwipeModel({
    required this.items,
    required this.cartIntegrityRate,
  });

  String get completionStatus => cartIntegrityRate >= 0.97 ? 'Pass' : 'Fail';
}
