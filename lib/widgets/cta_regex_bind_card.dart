// lib/widgets/cta_regex_bind_card.dart
import 'package:flutter/material.dart';

class CtaRegexBindCard extends StatefulWidget {
  const CtaRegexBindCard({super.key});

  @override
  State<CtaRegexBindCard> createState() => _CtaRegexBindCardState();
}

class _CtaRegexBindCardState extends State<CtaRegexBindCard> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;

  void _validate(String val) {
    final reg = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    setState(() {
      _isValid = reg.hasMatch(val.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Byt Field Regex Interlock', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        TextField(
          controller: _controller,
          onChanged: _validate,
          decoration: const InputDecoration(
            labelText: 'Enter Valid Work Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _isValid
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Next Step Activated!')),
                    );
                  }
                : null,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('NEXT'),
          ),
        ),
      ],
    );
  }
}
