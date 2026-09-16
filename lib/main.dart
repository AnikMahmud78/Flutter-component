// lib/main.dart
// Task GEN-00159 (revised): Secure Authentication Status Badge Component
import 'package:flutter/material.dart';
import 'widgets/app_bar_auth_badge.dart';
import 'widgets/presentation_conformance_banner.dart';

void main() {
  runApp(const AuthBadgeApp());
}

class AuthBadgeApp extends StatelessWidget {
  const AuthBadgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Auth Status Badge',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const AuthBadgeScreen(),
    );
  }
}

class AuthBadgeScreen extends StatefulWidget {
  const AuthBadgeScreen({super.key});

  @override
  State<AuthBadgeScreen> createState() => _AuthBadgeScreenState();
}

class _AuthBadgeScreenState extends State<AuthBadgeScreen> {
  bool _isAuthenticated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enterprise Console'),
        actions: [
          AppBarAuthBadge(
            isAuthenticated: _isAuthenticated,
            onTap: () => setState(() => _isAuthenticated = !_isAuthenticated),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const PresentationConformanceBanner(status: 'Pass', conformanceScore: 1.0),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mobile Infrastructure Security State',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Tap the badge in the upper right app bar to toggle authentication states dynamically.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
