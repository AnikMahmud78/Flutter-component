import 'package:flutter/material.dart';
import '../models/aggregated_benchmark.dart';

class AggregatedChartBlock extends StatefulWidget {
  final List<AggregatedBenchmark> benchmarks;

  const AggregatedChartBlock({super.key, required this.benchmarks});

  @override
  State<AggregatedChartBlock> createState() => _AggregatedChartBlockState();
}

class _AggregatedChartBlockState extends State<AggregatedChartBlock> {
  late String _selectedMetricId;

  @override
  void initState() {
    super.initState();
    _selectedMetricId = widget.benchmarks.first.id;
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = widget.benchmarks.firstWhere(
      (item) => item.id == _selectedMetricId,
      orElse: () => widget.benchmarks.first,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- HEADER & METRIC SELECTOR TOOLBAR ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.bar_chart_rounded, color: Colors.blueAccent),
                  SizedBox(width: 8),
                  Text(
                    'Corporate Benchmarks',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Kimball Star-Schema Index',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- SELECTOR TOOLBAR WITH 48x48dp MINIMUM TOUCH AREA ---
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.benchmarks.map((item) {
                final isSelected = item.id == _selectedMetricId;

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setState(() => _selectedMetricId = item.id),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        // REQUIREMENT: Minimum touch area parameters (48dp x 48dp)
                        constraints: const BoxConstraints(
                          minWidth: 48.0,
                          minHeight: 48.0,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade800
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue.shade900
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          item.metricName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),

          // --- VISUALIZATION BLOCK WITH ADAPTIVE PROGRESS BAR ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedItem.metricName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${selectedItem.currentValue.toStringAsFixed(1)} / ${selectedItem.targetValue.toStringAsFixed(1)} ${selectedItem.unit}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Adaptive Visual Progress Bar
                Stack(
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: selectedItem.progressRatio,
                      child: Container(
                        height: 16,
                        decoration: BoxDecoration(
                          color: selectedItem.statusColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Achieved: ${selectedItem.progressPercentage}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectedItem.statusColor,
                      ),
                    ),
                    Text(
                      selectedItem.progressRatio >= 1.0
                          ? 'TARGET MET'
                          : 'IN PROGRESS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
