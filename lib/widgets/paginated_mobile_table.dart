import 'package:flutter/material.dart';

/// Data Model representing BigQuery Dataset Rows
class BigQueryRecord {
  final String recordId;
  final String timestamp;
  final String eventName;
  final String deviceType;
  final String latencyMs;

  BigQueryRecord({
    required this.recordId,
    required this.timestamp,
    required this.eventName,
    required this.deviceType,
    required this.latencyMs,
  });
}

class PaginatedMobileTable extends StatefulWidget {
  const PaginatedMobileTable({super.key});

  @override
  State<PaginatedMobileTable> createState() => _PaginatedMobileTableState();
}

class _PaginatedMobileTableState extends State<PaginatedMobileTable> {
  // Requirement: Server-side chunk size of 20 rows
  final int _pageSize = 20;
  int _currentPage = 1;
  final int _totalRecords = 100; // Simulated BigQuery total dataset size
  bool _isLoading = false;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalHeaderController = ScrollController();
  final ScrollController _horizontalBodyController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Sync horizontal scrolling between header and body
    _horizontalBodyController.addListener(() {
      if (_horizontalHeaderController.hasClients) {
        _horizontalHeaderController.jumpTo(_horizontalBodyController.offset);
      }
    });
  }

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalHeaderController.dispose();
    _horizontalBodyController.dispose();
    super.dispose();
  }

  int get _totalPages => (_totalRecords / _pageSize).ceil();

  // Simulated BigQuery Data Fetch Trigger
  List<BigQueryRecord> _getChunkData() {
    final startIndex = (_currentPage - 1) * _pageSize;
    return List.generate(_pageSize, (index) {
      final id = startIndex + index + 1;
      return BigQueryRecord(
        recordId: 'BQ-${id.toString().padLeft(4, '0')}',
        timestamp: '2026-08-10 20:${(id % 60).toString().padLeft(2, '0')}:12',
        eventName: id % 2 == 0 ? 'checkout_submit' : 'payload_filter',
        deviceType: id % 3 == 0 ? 'iOS' : 'Android',
        latencyMs: '${45 + (id % 15)}ms',
      );
    });
  }

  void _changePage(int newPage) {
    if (newPage < 1 || newPage > _totalPages) return;
    setState(() {
      _isLoading = true;
      _currentPage = newPage;
    });

    // Simulate snappy BigQuery sub-second fetch response (<1s)
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _verticalController.animateTo(
          0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentChunk = _getChunkData();

    return Column(
      children: [
        // --- STICKY HEADER ROW ---
        Container(
          color: Colors.blueGrey.shade900,
          height: 48,
          child: Row(
            children: [
              // REQUIREMENT: Frozen First Column Header
              Container(
                width: 110,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: Colors.blueGrey.shade800,
                child: const Text(
                  'Record ID',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              // Horizontally Scrollable Header Cells
              Expanded(
                child: SingleChildScrollView(
                  controller: _horizontalHeaderController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: const [
                      _HeaderCell(title: 'Timestamp', width: 150),
                      _HeaderCell(title: 'Event Name', width: 140),
                      _HeaderCell(title: 'Device Type', width: 110),
                      _HeaderCell(title: 'Latency', width: 90),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // --- SCROLLABLE DATA BODY ---
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: _verticalController,
                  itemCount: currentChunk.length,
                  itemBuilder: (context, index) {
                    final item = currentChunk[index];
                    final isEven = index % 2 == 0;
                    final rowBgColor = isEven
                        ? Colors.grey.shade50
                        : Colors.white;

                    return Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: rowBgColor,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade300,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          // REQUIREMENT: Frozen First Column Cell
                          Container(
                            width: 110,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: isEven
                                ? Colors.grey.shade200
                                : Colors.grey.shade100,
                            child: Text(
                              item.recordId,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          // Horizontally Scrollable Data Cells
                          Expanded(
                            child: SingleChildScrollView(
                              controller: index == 0
                                  ? _horizontalBodyController
                                  : null,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _DataCell(text: item.timestamp, width: 150),
                                  _DataCell(text: item.eventName, width: 140),
                                  _DataCell(text: item.deviceType, width: 110),
                                  _DataCell(text: item.latencyMs, width: 90),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),

        // --- PAGINATION CONTROL FOOTER ---
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // REQUIREMENT: Pagination Status Indicator
              Text(
                'Page $_currentPage of $_totalPages ($_pageSize rows/chunk)',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _currentPage > 1
                        ? () => _changePage(_currentPage - 1)
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: _currentPage < _totalPages
                        ? () => _changePage(_currentPage + 1)
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String title;
  final double width;

  const _HeaderCell({required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final double width;

  const _DataCell({required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
      ),
    );
  }
}
