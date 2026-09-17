// lib/widgets/lineage_graph_visualizer.dart
import 'package:flutter/material.dart';

class LineageGraphVisualizer extends StatelessWidget {
  const LineageGraphVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('predecessor_id Lineage Graph Visualizer', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: CustomPaint(
            painter: LineageEdgePainter(color: theme.colorScheme.primary),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(label: Text('Parent: ED-9901')),
                Icon(Icons.arrow_forward),
                Chip(label: Text('Child: ED-9902')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LineageEdgePainter extends CustomPainter {
  final Color color;

  LineageEdgePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(80, size.height / 2)
      ..lineTo(size.width - 80, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
