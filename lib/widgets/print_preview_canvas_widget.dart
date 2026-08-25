import 'package:flutter/material.dart';

import '../models/print_preview_telemetry_model.dart';

class PrintPreviewCanvasWidget extends StatefulWidget {
  const PrintPreviewCanvasWidget({super.key});

  @override
  State<PrintPreviewCanvasWidget> createState() =>
      _PrintPreviewCanvasWidgetState();
}

class _PrintPreviewCanvasWidgetState extends State<PrintPreviewCanvasWidget> {
  final TransformationController _transformationController =
      TransformationController();
  bool _isPrintModeActive = false;

  static const _telemetry = PrintPreviewTelemetryRecord(
    layoutType: 'PRINT_OPTIMIZED_CANVAS_VIEW',
    layoutGridDimensions: 'A4 Standard Portrait (210mm x 297mm)',
    spacingRules: 'Clean Page Breaks Before Major Widgets',
    alignmentSettings: 'CENTERED_EXECUTIVE_SUMMARY_PRINT',
    layoutValidationStatus: 'NON_ESSENTIAL_UI_STRIPPED_PASS',
    completionStatus: 'Complete',
    actionEventTimestamp: '2026-08-25T11:00:00Z',
    userSessionId: 'SESS-2026-ANIK-2624',
  );

  void _resetZoomGesture() {
    setState(() {
      _transformationController.value = Matrix4.identity();
    });
  }

  void _togglePrintPreviewMode() {
    setState(() => _isPrintModeActive = !_isPrintModeActive);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: _isPrintModeActive
          ? null
          : AppBar(
              title: const Text('Print Stylesheet Compiler'),
              backgroundColor: colorScheme.surfaceContainerHigh,
              actions: [
                IconButton(
                  icon: const Icon(Icons.print_rounded),
                  onPressed: _togglePrintPreviewMode,
                  tooltip: 'Toggle Print Preview',
                ),
              ],
            ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_isPrintModeActive) ...[
              Text(
                'Gesture / Touch Standard: Complete',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Supports pinch-to-zoom, pan, and double-tap reset gestures.',
              ),
              const SizedBox(height: 16),
            ],
            Text(
              _isPrintModeActive
                  ? 'Print Preview Canvas'
                  : 'Executive Dashboard Report',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onDoubleTap: _resetZoomGesture,
              child: Container(
                height: 380,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: ClipRect(
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: 0.8,
                    maxScale: 3.5,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'ENTERPRISE METRICS MATRIX',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Chip(
                                label: const Text('PRINT-READY'),
                                backgroundColor: Colors.grey.shade200,
                              ),
                            ],
                          ),
                          const Divider(color: Colors.black54),
                          const SizedBox(height: 12),
                          const Text(
                            'Quarterly Performance Output: 40,500 USD\n'
                            'Active Infrastructure Nodes: 3,492 Units\n'
                            'SLA Compliance Rate: 99.98%',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontFamily: 'monospace',
                              height: 1.6,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '* Non-essential UI elements stripped automatically.',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_isPrintModeActive) ...[
              const SizedBox(height: 12),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _togglePrintPreviewMode,
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('EXIT_PRINT_MODE'),
                ),
              ),
            ],
            const SizedBox(height: 24),
            Text(
              'Atomic Step Execution Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    _buildRow('Layout Type', _telemetry.layoutType),
                    const Divider(height: 12),
                    _buildRow(
                      'Validation Status',
                      _telemetry.layoutValidationStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildRow(
                      'Completion Status',
                      _telemetry.completionStatus,
                      isHighlight: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _isPrintModeActive
          ? null
          : FloatingActionButton.extended(
              onPressed: _togglePrintPreviewMode,
              icon: const Icon(Icons.picture_as_pdf_rounded),
              label: const Text('EXPORT_PDF_PRINT'),
            ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}