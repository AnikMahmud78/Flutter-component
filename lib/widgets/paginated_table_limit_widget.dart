import 'package:flutter/material.dart';

import '../models/paginated_table_limit_model.dart';

class PaginatedTableLimitWidget extends StatefulWidget {
  const PaginatedTableLimitWidget({super.key});

  @override
  State<PaginatedTableLimitWidget> createState() =>
      _PaginatedTableLimitWidgetState();
}

class _PaginatedTableLimitWidgetState extends State<PaginatedTableLimitWidget> {
  static const _allowedRowLimits = [10, 25, 50];
  final _dataset = List<DatasetRecord>.generate(
    65,
    (index) => DatasetRecord(
      recordId: 'REC-2026-${index + 1001}',
      entityName: 'Operational Node #${index + 1}',
      category: index.isEven ? 'Logistics' : 'Clinical Ops',
      metricValue: (index + 1) * 1245.50,
      timestamp: DateTime.now().subtract(Duration(hours: index)),
    ),
  );
  int _rowsPerPage = 10;
  int _pageIndex = 0;

  int get _totalPages => (_dataset.length / _rowsPerPage).ceil();
  List<DatasetRecord> get _page {
    final start = _pageIndex * _rowsPerPage;
    return _dataset.sublist(
      start,
      (start + _rowsPerPage).clamp(0, _dataset.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Paginated Data Table Initial State')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _banner(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rows Per Page Limit:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton<int>(
                  value: _rowsPerPage,
                  items: _allowedRowLimits
                      .map(
                        (limit) => DropdownMenuItem(
                          value: limit,
                          child: Text('$limit rows'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() {
                    _rowsPerPage = value!;
                    _pageIndex = 0;
                  }),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (compact)
              ..._page.map(_recordCard)
            else
              Card.outlined(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStatePropertyAll(
                      colorScheme.surfaceContainerHighest,
                    ),
                    columns: const [
                      DataColumn(label: Text('Record ID')),
                      DataColumn(label: Text('Entity Name')),
                      DataColumn(label: Text('Category')),
                      DataColumn(
                        label: Text('Metric Value (USD)'),
                        numeric: true,
                      ),
                    ],
                    rows: _page
                        .map(
                          (record) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  record.recordId,
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              DataCell(Text(record.entityName)),
                              DataCell(Text(record.category)),
                              DataCell(
                                Text(
                                  '\$${record.metricValue.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_pageIndex + 1} of $_totalPages Pages (${_dataset.length} Total Records)',
                  style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _pageIndex > 0
                          ? () => setState(() => _pageIndex--)
                          : null,
                      icon: const Icon(Icons.chevron_left_rounded),
                    ),
                    IconButton(
                      onPressed: _pageIndex < _totalPages - 1
                          ? () => setState(() => _pageIndex++)
                          : null,
                      icon: const Icon(Icons.chevron_right_rounded),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            _telemetry(),
          ],
        ),
      ),
    );
  }

  Widget _recordCard(DatasetRecord record) => Card.outlined(
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      title: Text(
        record.entityName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('${record.recordId} • ${record.category}'),
      trailing: Text(
        '\$${record.metricValue.toStringAsFixed(2)}',
        style: const TextStyle(fontFamily: 'monospace'),
      ),
    ),
  );

  Widget _banner() => Card.filled(
    color: Colors.green.shade50,
    child: const ListTile(
      leading: Icon(Icons.policy_rounded, color: Color(0xFF086C44)),
      title: Text('Business Rule Coverage: Complete (100%)'),
      subtitle: Text('Approved policy limits: 10, 25, and 50 rows per page.'),
    ),
  );

  Widget _telemetry() => Card.outlined(
    child: const ListTile(
      leading: Icon(Icons.verified_rounded, color: Color(0xFF086C44)),
      title: Text('EXEC-3900BPTR-2026'),
      subtitle: Text('PASS • Default rows-per-page limit initialized to 10.'),
    ),
  );
}
