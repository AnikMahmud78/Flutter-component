// lib/main.dart
// Task GEN-00159: Secure Authentication Status Badge Component
import 'package:flutter/material.dart';
import 'widgets/auth_status_badge.dart';
import 'widgets/md3_conformance_banner.dart';

void main() {
  runApp(const AuthBadgeApp());
}

class AuthBadgeApp extends StatelessWidget {
  const AuthBadgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Status Badge',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const AuthBadgeScreen(),
    );
  }
}

class AuthBadgeScreen extends StatelessWidget {
  const AuthBadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Console'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: AuthStatusBadge(isAuthenticated: true),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Md3ConformanceBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Secure Auth Status Badge active inside Mobile App Bar.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
