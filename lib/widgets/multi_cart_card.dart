// lib/widgets/multi_cart_card.dart
import 'package:flutter/material.dart';

class MultiCartCard extends StatefulWidget {
  const MultiCartCard({super.key});

  @override
  State<MultiCartCard> createState() => _MultiCartCardState();
}

class _MultiCartCardState extends State<MultiCartCard> {
  final List<Map<String, String>> _cartItems = [
    {'name': 'Home Cleaning - Deep', 'price': 'AED 249'},
    {'name': 'Pest Control', 'price': 'AED 149'},
  ];

  void _addItem() {
    if (_cartItems.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum 5 concurrent bookings reached!')),
      );
      return;
    }
    setState(() {
      _cartItems.add({'name': 'AC Servicing', 'price': 'AED 199'});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Multi-Item Cart (Max 5 Bookings)', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ..._cartItems.map((item) => ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(item['name']!),
              trailing: Text(item['price']!, style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
            )),
        Text('${_cartItems.length}/5 bookings', style: theme.textTheme.bodySmall),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _addItem,
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('ADD SERVICE TO CART'),
          ),
        ),
      ],
    );
  }
}
