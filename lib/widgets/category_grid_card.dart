import 'package:flutter/material.dart';
import '../models/category_grid_model.dart';

class CategoryGridCard extends StatelessWidget {
  final CategoryGridModel model;
  final ValueChanged<String> onCategoryTap;

  const CategoryGridCard({
    Key? key,
    required this.model,
    required this.onCategoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.5,
      ),
      itemCount: model.categories.length,
      itemBuilder: (context, index) {
        final cat = model.categories[index];
        return Card(
          elevation: 2.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            onTap: () => onCategoryTap(cat),
            child: Center(
              child: Text(
                cat,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        );
      },
    );
  }
}
