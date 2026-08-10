import 'package:flutter/material.dart';
import '../tokens/z_index_tokens.dart';

class ZIndexLayerDemo extends StatefulWidget {
  const ZIndexLayerDemo({super.key});

  @override
  State<ZIndexLayerDemo> createState() => _ZIndexLayerDemoState();
}

class _ZIndexLayerDemoState extends State<ZIndexLayerDemo> {
  bool _showOverlay = false;
  bool _showModal = false;
  bool _showShaktiAlert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ==========================================
          // LEVEL 0: BASE CANVAS CONTENT (z-index: 0)
          // ==========================================
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 70,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Z-Index Elevation Stack Test',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Toggle layers below to verify that higher z-index priority elements render on top without layout obscuration.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // Layer Toggle Buttons
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            setState(() => _showOverlay = !_showOverlay),
                        child: Text(
                          _showOverlay
                              ? 'Hide Dropdown (L2)'
                              : 'Show Dropdown (L2)',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            setState(() => _showModal = !_showModal),
                        child: Text(
                          _showModal ? 'Hide Modal (L3)' : 'Show Modal (L3)',
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade100,
                        ),
                        onPressed: () => setState(
                          () => _showShaktiAlert = !_showShaktiAlert,
                        ),
                        child: Text(
                          _showShaktiAlert
                              ? 'Hide Shakti Alert (L4)'
                              : 'Trigger Shakti Alert (L4)',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  // Dummy background content cards
                  ...List.generate(
                    10,
                    (index) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text('Base Level Content Item #${index + 1}'),
                        subtitle: Text('Z-Index: ${ZIndexTokens.base}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // LEVEL 1: STICKY HEADER (z-index: 100)
          // ==========================================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 56,
            child: Material(
              elevation: 4,
              color: Colors.blueGrey.shade900,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sticky Header (L1)',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Chip(
                      label: Text('Z: ${ZIndexTokens.stickyHeader}'),
                      backgroundColor: Colors.blueGrey.shade700,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ==========================================
          // LEVEL 2: OVERLAY / DROPDOWN (z-index: 200)
          // ==========================================
          if (_showOverlay)
            Positioned(
              top: 110,
              left: 16,
              width: 220,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.blue.shade50,
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Dropdown (L2)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Z: ${ZIndexTokens.overlay}',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      const ListTile(
                        dense: true,
                        title: Text('Option 1: Filter Alpha'),
                      ),
                      const ListTile(
                        dense: true,
                        title: Text('Option 2: Filter Beta'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // ==========================================
          // LEVEL 3: MODAL DIALOG (z-index: 300)
          // ==========================================
          if (_showModal)
            Positioned.fill(
              child: Container(
                color: Colors.black54, // Modal backdrop
                alignment: Alignment.center,
                child: Material(
                  elevation: 16,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Confirmation Modal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Chip(
                              label: Text('Z: ${ZIndexTokens.modal}'),
                              backgroundColor: Colors.purple.shade100,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'This modal layer obscures level 0-2 elements.',
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => setState(() => _showModal = false),
                          child: const Text('Close Modal'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // ==========================================
          // LEVEL 4: SHAKTI ALERT TOAST (z-index: 400)
          // ==========================================
          if (_showShaktiAlert)
            Positioned(
              top: 12,
              left: 16,
              right: 16,
              child: Material(
                elevation: 24,
                borderRadius: BorderRadius.circular(8),
                color: Colors.red.shade900,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'SHAKTI CRITICAL ALERT (L4)',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'Payload breach detected. Immediate action required.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Z: ${ZIndexTokens.shaktiAlert}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () =>
                            setState(() => _showShaktiAlert = false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
