import 'package:flutter/material.dart';
import '../models/bookmarked_providers_model.dart';

class BookmarkedProvidersCard extends StatelessWidget {
  final BookmarkedProvidersModel model;
  final VoidCallback onVerifyPersistence;

  const BookmarkedProvidersCard({
    Key? key,
    required this.model,
    required this.onVerifyPersistence,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Most-Bookmarked Provider Report',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(Icons.bookmark, color: theme.colorScheme.primary),
              ),
              title: Text(model.providerName),
              subtitle: Text('\${model.totalBookmarks} total bookmarks saved'),
              trailing: Chip(
                label: Text(model.completionStatus),
                backgroundColor: model.completionStatus == 'Pass' ? Colors.green.shade50 : Colors.red.shade50,
              ),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: OutlinedButton.icon(
                onPressed: onVerifyPersistence,
                icon: const Icon(Icons.storage),
                label: const Text('Verify State Persistence (ISO 25010)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
