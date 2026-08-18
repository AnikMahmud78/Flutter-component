// Location: lib/widgets/mini_sparkline_widget.dart
import 'package:flutter/material.dart';
import '../models/sparkline_telemetry_model.dart';

class MiniSparklineWidget extends StatefulWidget {
  final List<SparklineDataPoint> dataPoints;
  final double height;
  final double strokeWidth;

  const MiniSparklineWidget({
    super.key,
    required this.dataPoints,
    this.height = 48.0,
    this.strokeWidth = 2.0, // HABOT stroke weight requirement (2px)
  });

  @override
  State<MiniSparklineWidget> createState() => _MiniSparklineWidgetState();
}

class _MiniSparklineWidgetState extends State<MiniSparklineWidget> {
  int? _activeTouchIndex;
  Offset? _touchOffset;

  bool get _isPositiveTrend {
    if (widget.dataPoints.length < 2) return true;
    return widget.dataPoints.last.value >= widget.dataPoints.first.value;
  }

  Color get _trendColor => _isPositiveTrend
      ? const Color(0xFF21B373) // HABOT Success Indicator
      : const Color(0xFFE31B23); // HABOT Error Indicator

  void _handleTouch(Offset localPosition, Size size) {
    if (widget.dataPoints.isEmpty) return;
    final stepX = size.width / (widget.dataPoints.length - 1);
    int index = (localPosition.dx / stepX).round();
    index = index.clamp(0, widget.dataPoints.length - 1);

    setState(() {
      _activeTouchIndex = index;
      _touchOffset = localPosition;
    });
  }

  void _clearTouch() {
    setState(() {
      _activeTouchIndex = null;
      _touchOffset = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanDown: (details) => _handleTouch(details.localPosition, size),
            onPanUpdate: (details) => _handleTouch(details.localPosition, size),
            onPanEnd: (_) => _clearTouch(),
            onPanCancel: () => _clearTouch(),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // VECTOR PATH SPARKLINE CANVAS
                CustomPaint(
                  size: size,
                  painter: _SparklinePainter(
                    dataPoints: widget.dataPoints,
                    lineColor: _trendColor,
                    strokeWidth: widget.strokeWidth,
                    activeTouchIndex: _activeTouchIndex,
                  ),
                ),

                // FLOATING TOUCH POPOVER (POSITIONED SAFELY ABOVE THUMB)
                if (_activeTouchIndex != null && _touchOffset != null) ...[
                  Positioned(
                    left: (_touchOffset!.dx - 45).clamp(0.0, size.width - 90),
                    top: -38.0, // Floating safely above thumb
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF1E2A38,
                        ), // High-contrast navy surface
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.dataPoints[_activeTouchIndex!].label,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.dataPoints[_activeTouchIndex!].value
                                .toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<SparklineDataPoint> dataPoints;
  final Color lineColor;
  final double strokeWidth;
  final int? activeTouchIndex;

  _SparklinePainter({
    required this.dataPoints,
    required this.lineColor,
    required this.strokeWidth,
    this.activeTouchIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.length < 2) return;

    final values = dataPoints.map((dp) => dp.value).toList();
    final minY = values.reduce((a, b) => a < b ? a : b);
    final maxY = values.reduce((a, b) => a > b ? a : b);
    final rangeY = (maxY - minY) == 0 ? 1.0 : (maxY - minY);

    final stepX = size.width / (dataPoints.length - 1);
    final points = <Offset>[];

    for (int i = 0; i < dataPoints.length; i++) {
      final x = i * stepX;
      // Invert Y for canvas coordinate space (with 4px padding top/bottom)
      final normalizedY = (dataPoints[i].value - minY) / rangeY;
      final y = size.height - (normalizedY * (size.height - 8.0)) - 4.0;
      points.add(Offset(x, y));
    }

    // DRAW PATH
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, paint);

    // DRAW ACTIVE TOUCH TRACKER INDICATOR DOT
    if (activeTouchIndex != null && activeTouchIndex! < points.length) {
      final targetPoint = points[activeTouchIndex!];

      // Outer Glow
      canvas.drawCircle(
        targetPoint,
        6.0,
        Paint()..color = lineColor.withOpacity(0.3),
      );
      // Inner Solid Dot
      canvas.drawCircle(targetPoint, 3.5, Paint()..color = lineColor);
    }
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.activeTouchIndex != activeTouchIndex ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.dataPoints != dataPoints;
  }
}
