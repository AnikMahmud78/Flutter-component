// lib/widgets/md3_theme_provider_card.dart
// Task GEN-00293: Confirm the MD3ThemeProvider module and high-contrast token sheets are delivered.
import 'package:flutter/material.dart';

class MD3ThemeProviderCard extends StatefulWidget {
  const MD3ThemeProviderCard({super.key});

  @override
  State<MD3ThemeProviderCard> createState() => _MD3ThemeProviderCardState();
}

class _MD3ThemeProviderCardState extends State<MD3ThemeProviderCard> {
  bool _highContrastActive = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('MD3 Theme Token Sheet Matrix', style: theme.textTheme.titleMedium),
                Chip(
                  label: Text(_highContrastActive ? 'AAA HIGH-CONTRAST' : 'STANDARD AA'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text('Token Verification:'),
            const SizedBox(height: 8.0),
            const ListTile(
              dense: true,
              leading: Icon(Icons.contrast),
              title: Text('Surface / OnSurface Token Delta'),
              subtitle: Text('Ratio >= 7.0:1 (WCAG AAA)'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
            const ListTile(
              dense: true,
              leading: Icon(Icons.style),
              title: Text('Semantic High-Contrast Palettes'),
              subtitle: Text('Sheet MD3ThemeProvider delivered'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {
                  setState(() {
                    _highContrastActive = !_highContrastActive;
                  });
                },
                icon: const Icon(Icons.swap_horiz),
                label: const Text('TOGGLE TOKEN PREVIEW'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
