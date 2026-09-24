import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class ReadOnlyProfileCard extends StatelessWidget {
  final UserProfile profile;

  const ReadOnlyProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    profile.name.substring(0, 1),
                    style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.name, style: Theme.of(context).textTheme.titleLarge),
                    Text(profile.role, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
            const Divider(height: 32),
            Text('Department: \${profile.department}', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text('Email: \${profile.email}', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
