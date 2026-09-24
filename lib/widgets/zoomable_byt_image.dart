import 'package:flutter/material.dart';
import '../models/byt_image_model.dart';

class ZoomableBytImage extends StatelessWidget {
  final BytImageModel model;

  const ZoomableBytImage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: InteractiveViewer(
        minScale: model.minScale,
        maxScale: model.maxScale,
        child: Image.network(
          model.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 250,
            color: Colors.grey[300],
            child: const Center(child: Text('Cropped Byt Image Placeholder')),
          ),
        ),
      ),
    );
  }
}
