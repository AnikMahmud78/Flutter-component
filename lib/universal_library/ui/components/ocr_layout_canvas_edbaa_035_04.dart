// EDBAA-035-04 — OCR Layout Canvas & Pixel Coordinate Mapper.
// Interactive scalable canvas that normalizes display coords to absolute image pixels for OCR engines, with live overlay chips and read-only totals.
import 'package:flutter/material.dart';

/// Absolute pixel rect fed to OCR engines.
class OcrPixelBoxEdbaa03504 {
  final String id;
  final double x;
  final double y;
  final double width;
  final double height;
  const OcrPixelBoxEdbaa03504({required this.id, required this.x, required this.y, required this.width, required this.height});
  OcrPixelBoxEdbaa03504 copyWith({double? x, double? y, double? width, double? height}) {
    return OcrPixelBoxEdbaa03504(id: id, x: x ?? this.x, y: y ?? this.y, width: width ?? this.width, height: height ?? this.height);
  }
  Map<String, num> toOcrParams() => {'x': x.round(), 'y': y.round(), 'w': width.round(), 'h': height.round(), 'x2': (x + width).round(), 'y2': (y + height).round()};
  Map<String, dynamic> toJson() => {'id': id, 'x': x, 'y': y, 'width': width, 'height': height};
}

/// Interactive layout canvas that scales across admin screens.
/// Highlights boxes with high-contrast outlines, live pixel chips, gray read-only totals.
class OcrLayoutCanvasEdbaa03504 extends StatefulWidget {
  final Size imagePixelSize;
  final List<OcrPixelBoxEdbaa03504> initialBoxes;
  final ValueChanged<List<OcrPixelBoxEdbaa03504>>? onBoxesChanged;
  const OcrLayoutCanvasEdbaa03504({super.key, required this.imagePixelSize, this.initialBoxes = const [], this.onBoxesChanged});
  @override
  State<OcrLayoutCanvasEdbaa03504> createState() => _OcrLayoutCanvasEdbaa03504State();
}

class _OcrLayoutCanvasEdbaa03504State extends State<OcrLayoutCanvasEdbaa03504> {
  late List<OcrPixelBoxEdbaa03504> _boxes;
  String? _selectedId;
  @override
  void initState() {
    super.initState();
    _boxes = List.of(widget.initialBoxes);
    if (_boxes.isEmpty) {
      _boxes = [OcrPixelBoxEdbaa03504(id: 'box-1', x: 40, y: 60, width: 320, height: 120)];
    }
  }
  void _emit() => widget.onBoxesChanged?.call(List.unmodifiable(_boxes));
  void _move(String id, Offset deltaDisplay, double scale) {
    final i = _boxes.indexWhere((e) => e.id == id);
    if (i < 0) return;
    final b = _boxes[i];
    final dx = deltaDisplay.dx / scale;
    final dy = deltaDisplay.dy / scale;
    final nx = (b.x + dx).clamp(0.0, widget.imagePixelSize.width - b.width);
    final ny = (b.y + dy).clamp(0.0, widget.imagePixelSize.height - b.height);
    setState(() => _boxes[i] = b.copyWith(x: nx, y: ny));
    _emit();
  }
  void _resize(String id, Offset deltaDisplay, double scale) {
    final i = _boxes.indexWhere((e) => e.id == id);
    if (i < 0) return;
    final b = _boxes[i];
    final dw = deltaDisplay.dx / scale;
    final dh = deltaDisplay.dy / scale;
    final nw = (b.width + dw).clamp(24.0, widget.imagePixelSize.width - b.x);
    final nh = (b.height + dh).clamp(24.0, widget.imagePixelSize.height - b.y);
    setState(() => _boxes[i] = b.copyWith(width: nw, height: nh));
    _emit();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalArea = _boxes.fold<double>(0, (p, b) => p + b.width * b.height);
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Expanded(child: Text('OCR Mapping Canvas', style: theme.textTheme.titleSmall)),
                Chip(label: Text('${widget.imagePixelSize.width.toInt()} x ${widget.imagePixelSize.height.toInt()} px', style: const TextStyle(fontSize: 11)), visualDensity: VisualDensity.compact),
              ],
            ),
          ),
          LayoutBuilder(builder: (context, constraints) {
            final maxW = constraints.maxWidth == double.infinity ? 600.0 : constraints.maxWidth;
            final aspect = widget.imagePixelSize.width / widget.imagePixelSize.height;
            final canvasW = maxW - 32;
            final canvasH = canvasW / aspect;
            final scale = canvasW / widget.imagePixelSize.width;
            return Center(
              child: Container(
                width: canvasW,
                height: canvasH,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLowest, border: Border.all(color: theme.colorScheme.outlineVariant), borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      CustomPaint(size: Size(canvasW, canvasH), painter: _GridPainter()),
                      for (final b in _boxes) _buildBox(b, scale),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _totalCell('BOXES', '${_boxes.length}'),
                _totalCell('TOTAL AREA', '${totalArea.toInt()} px2'),
                _totalCell('CANVAS W', '${widget.imagePixelSize.width.toInt()} px'),
                _totalCell('CANVAS H', '${widget.imagePixelSize.height.toInt()} px'),
                FilledButton.tonal(onPressed: () {
                  setState(() => _boxes.add(OcrPixelBoxEdbaa03504(id: 'box-${DateTime.now().millisecondsSinceEpoch}', x: 20, y: 20, width: 200, height: 80)));
                  _emit();
                }, child: const Text('Add box')),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _totalCell(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade400)),
      child: AbsorbPointer(
        absorbing: true,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.black54)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87)),
        ]),
      ),
    );
  }
  Widget _buildBox(OcrPixelBoxEdbaa03504 b, double scale) {
    final isSel = _selectedId == b.id;
    final left = b.x * scale;
    final top = b.y * scale;
    final w = b.width * scale;
    final h = b.height * scale;
    final borderColor = isSel ? Colors.yellowAccent : Colors.cyanAccent;
    return Positioned(
      left: left,
      top: top,
      width: w,
      height: h,
      child: GestureDetector(
        onTap: () => setState(() => _selectedId = b.id),
        onPanUpdate: (d) => _move(b.id, d.delta, scale),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3), borderRadius: BorderRadius.circular(2)),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: borderColor, width: 2), color: Colors.cyanAccent.withOpacity(0.12)),
            child: Stack(clipBehavior: Clip.none, children: [
              Positioned(top: -28, left: 0, child: _pixelChip(b)),
              Positioned(right: -12, bottom: -12, child: GestureDetector(onPanUpdate: (d) => _resize(b.id, d.delta, scale), child: _scaleHandle())),
            ]),
          ),
        ),
      ),
    );
  }
  Widget _pixelChip(OcrPixelBoxEdbaa03504 b) {
    final p = b.toOcrParams();
    return Material(
      color: Colors.black87,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Text('x:${p['x']} y:${p['y']} w:${p['w']} h:${p['h']}', style: const TextStyle(color: Colors.white, fontSize: 10, fontFeatures: [FontFeature.tabularFigures()])),
      ),
    );
  }
  Widget _scaleHandle() {
    return Container(width: 24, height: 24, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.open_in_full, size: 14, color: Colors.black));
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFF4F5F7);
    canvas.drawRect(Offset.zero & size, bg);
    final line = Paint()..color = const Color(0xFFE0E3E8)..strokeWidth = 1;
    const step = 24.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
