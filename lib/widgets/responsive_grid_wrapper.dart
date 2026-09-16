import 'package:flutter/material.dart';

class ResponsiveGridWrapper extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveGridWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 1;
    if (width >= 840) {
      crossAxisCount = 3;
    } else if (width >= 600) {
      crossAxisCount = 2;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 2.5,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
