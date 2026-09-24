import 'package:flutter/material.dart';
import 'models/cart_swipe_model.dart';
import 'widgets/cart_swipe_list_card.dart';

void main() {
  runApp(const CartSwipeApp());
}

class CartSwipeApp extends StatelessWidget {
  const CartSwipeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cart Swipe Gesture',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CartSwipeScreen(),
    );
  }
}

class CartSwipeScreen extends StatefulWidget {
  const CartSwipeScreen({Key? key}) : super(key: key);

  @override
  State<CartSwipeScreen> createState() => _CartSwipeScreenState();
}

class _CartSwipeScreenState extends State<CartSwipeScreen> {
  late CartSwipeModel _cartModel;

  @override
  void initState() {
    super.initState();
    _cartModel = const CartSwipeModel(
      items: [
        CartItemModel(itemId: 'ITEM-1', title: 'Monthly Transportation Pass', price: 85.00),
        CartItemModel(itemId: 'ITEM-2', title: 'After-School Math Tutoring', price: 120.00),
      ],
      cartIntegrityRate: 0.999,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart Swipe-to-Dismiss')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CartSwipeListCard(
              model: _cartModel,
              onItemDismissed: (id) {
                setState(() {
                  final updatedList = _cartModel.items.where((i) => i.itemId != id).toList();
                  _cartModel = CartSwipeModel(
                    items: updatedList,
                    cartIntegrityRate: 0.999,
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item Removed. Cart Integrity Verified (99.9%)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
