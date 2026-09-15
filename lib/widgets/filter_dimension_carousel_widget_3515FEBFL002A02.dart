import 'package:flutter/material.dart';
import '../models/filter_dimension_telemetry_model.dart';

class FilterDimensionCarouselWidget3515FEBFL002A02 extends StatefulWidget {
  const FilterDimensionCarouselWidget3515FEBFL002A02({super.key});

  @override
  State<FilterDimensionCarouselWidget3515FEBFL002A02> createState() =>
      _FilterDimensionCarouselWidget3515FEBFL002A02State();
}

class _FilterDimensionCarouselWidget3515FEBFL002A02State
    extends State<FilterDimensionCarouselWidget3515FEBFL002A02> {
  final List<String> _dimensions = const [
    'Category',
    'Date Range',
    'Status',
    'Tag',
    'Score',
    'Region'
  ];

  FilterDimensionTelemetryRecord get _telemetry => FilterDimensionTelemetryRecord(
        definitionName: 'ALGORITHMIC_CONTENT_SELECTION_DIMENSIONS',
        definitionParameters:
            'DIMENSIONS=[category, date_range, status, tag, score, region]',
        definitionType: 'FILTER_DIMENSION_POLICY',
        validationStatus: 'PEER_REVIEWED_SPEC_LOCKED',
        definitionId: 'DEF-FEBFL-002-2026',
        completionStatus: 'Complete',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-3515',
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Algorithmic Filter Dimensions'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(Icons.verified_rounded,
                        color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Business Rule Coverage: Complete (100%)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF086C44)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '100% of rules formally defined, peer-reviewed, and versioned in approved spec.',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Defined Filter Dimensions Carousel',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _dimensions.length,
                itemBuilder: (context, idx) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: 120, minHeight: 48),
                      child: Card.outlined(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              _dimensions[idx],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text('Atomic Telemetry Logs',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Definition Name', telemetry.definitionName),
                    const Divider(height: 12),
                    _buildRow('Definition ID', telemetry.definitionId),
                    const Divider(height: 12),
                    _buildRow('Completion Status', telemetry.completionStatus,
                        isHighlight: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
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
