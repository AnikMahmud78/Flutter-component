import 'package:flutter/material.dart';
import 'models/user_profile.dart';
import 'widgets/read_only_profile_card.dart';

void main() => runApp(const ProfileApp());

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)),
      home: Scaffold(
        appBar: AppBar(title: const Text('Read-Only Profile View')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: ReadOnlyProfileCard(
            profile: UserProfile(
              name: 'Anik Rahman',
              role: 'Lead Systems Architect',
              department: 'Mobile Infrastructure',
              email: 'anik@habot.io',
            ),
          ),
        ),
      ),
    );
  }
}
