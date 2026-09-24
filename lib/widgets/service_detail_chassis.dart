import 'package:flutter/material.dart';
import '../models/service_detail_model.dart';

class ServiceDetailChassis extends StatelessWidget {
  final ServiceDetailModel model;
  final VoidCallback onBookNow;

  const ServiceDetailChassis({
    Key? key,
    required this.model,
    required this.onBookNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 840;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Template Container Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Template: @habot/templates/service-detail',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          // Responsive Layout Chassis
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildHeroSection(theme)),
                const SizedBox(width: 24.0),
                Expanded(flex: 1, child: _buildBookingCard(theme)),
              ],
            )
          else
            Column(
              children: [
                _buildHeroSection(theme),
                const SizedBox(height: 16.0),
                _buildBookingCard(theme),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(ThemeData theme) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(Icons.dry_cleaning, size: 80.0, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 16.0),
            Text(model.title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text('Provided by \${model.providerName}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20.0),
                const SizedBox(width: 4.0),
                Text('\${model.rating} / 5.0', style: theme.textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(ThemeData theme) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Booking Options', style: theme.textTheme.titleLarge),
            const SizedBox(height: 12.0),
            Text('\\$\${model.hourlyRate.toStringAsFixed(2)} / hr', style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary)),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onBookNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                child: const Text('Book Service Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
