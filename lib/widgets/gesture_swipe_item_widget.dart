// Location: lib/widgets/gesture_swipe_item_widget.dart
import 'package:flutter/material.dart';
import '../models/gesture_list_model.dart';

class GestureSwipeItemWidget extends StatelessWidget {
  final GestureListItem item;
  final Function(DismissDirection) onDismissed;

  const GestureSwipeItemWidget({
    super.key,
    required this.item,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      // 40% Threshold Limit for Action Execution
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.4,
        DismissDirection.endToStart: 0.4,
      },
      onDismissed: onDismissed,

      // SWIPE RIGHT: ARCHIVE ACTION (Green #21B373)
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF21B373), // HABOT Success Indicator
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Row(
          children: [
            Icon(Icons.archive_rounded, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text(
              'ARCHIVE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),

      // SWIPE LEFT: DELETE ACTION (Red #E31B23)
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: const Color(0xFFE31B23), // HABOT Error Indicator
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'DELETE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.8,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.delete_outline_rounded, color: Colors.white, size: 24),
          ],
        ),
      ),

      // LIST ITEM FOREGROUND SURFACE
      child: Card.outlined(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56.0), // Spacing target
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  child: Text(
                    item.id.substring(item.id.length - 2),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  item.timestamp,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
