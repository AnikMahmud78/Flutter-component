import 'package:flutter/material.dart';
import 'models/category_grid_model.dart';
import 'widgets/category_grid_card.dart';

void main() {
  runApp(const CategoryGridApp());
}

class CategoryGridApp extends StatelessWidget {
  const CategoryGridApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Category Grid',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      home: const CategoryGridScreen(),
    );
  }
}

class CategoryGridScreen extends StatelessWidget {
  const CategoryGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const gridModel = CategoryGridModel(
      categories: ['Childcare', 'Tutoring', 'Transportation', 'Healthcare'],
      timeToFindSeconds: 2,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Marketplace Categories')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CategoryGridCard(
          model: gridModel,
          onCategoryTap: (cat) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Selected category: \$cat')),
            );
          },
        ),
      ),
    );
  }
}
