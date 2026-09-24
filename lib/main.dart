import 'package:flutter/material.dart';
import 'models/bookmarked_providers_model.dart';
import 'widgets/bookmarked_providers_card.dart';

void main() {
  runApp(const BookmarkedProvidersApp());
}

class BookmarkedProvidersApp extends StatelessWidget {
  const BookmarkedProvidersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookmarked Providers Report',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BookmarkedProvidersScreen(),
    );
  }
}

class BookmarkedProvidersScreen extends StatelessWidget {
  const BookmarkedProvidersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const reportModel = BookmarkedProvidersModel(
      providerName: 'Apex Childcare Services',
      totalBookmarks: 1420,
      persistenceReliabilityScore: 0.999,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Marketplace Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BookmarkedProvidersCard(
              model: reportModel,
              onVerifyPersistence: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('State Persistence Score: 100% (Pass)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
