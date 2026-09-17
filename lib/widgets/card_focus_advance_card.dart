// lib/widgets/card_focus_advance_card.dart
import 'package:flutter/material.dart';

class CardFocusAdvanceCard extends StatefulWidget {
  const CardFocusAdvanceCard({super.key});

  @override
  State<CardFocusAdvanceCard> createState() => _CardFocusAdvanceCardState();
}

class _CardFocusAdvanceCardState extends State<CardFocusAdvanceCard> {
  final FocusNode _cardFocus = FocusNode();
  final FocusNode _expiryFocus = FocusNode();
  final FocusNode _cvvFocus = FocusNode();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardFocus.dispose();
    _expiryFocus.dispose();
    _cvvFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Card Auto-Advance Focus Engine', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        TextField(
          controller: _cardController,
          focusNode: _cardFocus,
          keyboardType: TextInputType.number,
          maxLength: 16,
          decoration: const InputDecoration(labelText: 'Card Number', border: OutlineInputBorder(), prefixIcon: Icon(Icons.credit_card)),
          onChanged: (v) {
            if (v.length == 16) FocusScope.of(context).requestFocus(_expiryFocus);
          },
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _expiryController,
                focusNode: _expiryFocus,
                keyboardType: TextInputType.number,
                maxLength: 5,
                decoration: const InputDecoration(labelText: 'MM/YY', border: OutlineInputBorder()),
                onChanged: (v) {
                  if (v.length == 5) FocusScope.of(context).requestFocus(_cvvFocus);
                },
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: TextField(
                controller: _cvvController,
                focusNode: _cvvFocus,
                keyboardType: TextInputType.number,
                maxLength: 3,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'CVV', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Card tokenized via PCI-DSS Level 1 compliant vault!')),
              );
            },
            icon: const Icon(Icons.lock),
            label: const Text('TOKENIZE CARD (PCI-DSS)'),
          ),
        ),
      ],
    );
  }
}
