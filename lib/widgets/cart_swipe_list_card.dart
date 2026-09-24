import 'package:flutter/material.dart';
import '../models/cart_swipe_model.dart';

class CartSwipeListCard extends StatelessWidget {
  final CartSwipeModel model;
  final ValueChanged<String> onItemDismissed;

  const CartSwipeListCard({
    Key? key,
    required this.model,
    required this.onItemDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: model.items.length,
      itemBuilder: (context, index) {
        final item = model.items[index];
        return Dismissible(
          key: Key(item.itemId),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            color: theme.colorScheme.error,
            child: Icon(Icons.delete, color: theme.colorScheme.onError),
          ),
          onDismissed: (_) => onItemDismissed(item.itemId),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            child: ListTile(
              title: Text(item.title),
              subtitle: Text('\\$\${item.price.toStringAsFixed(2)}'),
              trailing: const Icon(Icons.swipe_left, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
