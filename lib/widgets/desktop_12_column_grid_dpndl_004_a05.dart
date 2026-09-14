// DPNDL-004-A05 — Configure 12-Column Desktop Grid Layout.
// Enforces Material Design 3 expanded layout specifications with strict 24dp outer padding,
// 24dp structural gutters, configurable 1-12 column spanning, and ultra-wide monitor max constraints.

import 'package:flutter/material.dart';

/// Telemetry record capturing grid execution status and responsive alignment metrics.
@immutable
class DesktopGridTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final double calculatedAvailableWidth;
  final double calculatedColumnWidth;
  final bool isWithinFloorOptimalCeiling;

  const DesktopGridTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.calculatedAvailableWidth,
    required this.calculatedColumnWidth,
    required this.isWithinFloorOptimalCeiling,
  });

  Map<String, dynamic> toMap() => {
        'stepExecutionId': stepExecutionId,
        'executionStatus': executionStatus,
        'executionTimestamp': executionTimestamp.toIso8601String(),
        'stepOutcome': stepOutcome,
        'userId': userId,
        'calculatedAvailableWidth': calculatedAvailableWidth,
        'calculatedColumnWidth': calculatedColumnWidth,
        'isWithinFloorOptimalCeiling': isWithinFloorOptimalCeiling,
      };
}

/// Child specification defining span (1 to 12 columns) and optional row span for layout items.
@immutable
class DesktopGridItem {
  final int columnSpan;
  final Widget child;
  final Key? key;
  final double? minHeight;

  DesktopGridItem({
    required this.columnSpan,
    required this.child,
    this.key,
    this.minHeight,
  }) : assert(
          columnSpan >= 1 && columnSpan <= 12,
          'DesktopGridItem columnSpan must be between 1 and 12 (inclusive). Received: $columnSpan',
        );
}

/// A production-grade 12-column Material Design 3 layout wrapper frame.
/// Strictly enforces 24dp outer margins, 24dp structural gutters, and snap-to-grid column math.
class Desktop12ColumnGrid extends StatefulWidget {
  /// Outer screen margin padding. Strictly defaulted to 24dp per MD3 / DPNDL-004-A05.
  final EdgeInsetsGeometry outerPadding;

  /// Structural gutter spacing between columns. Strictly defaulted to 24dp.
  final double gutterSpacing;

  /// Maximum container width constraint for ultra-wide enterprise monitors.
  final double maxContainerWidth;

  /// List of items to distribute across the 12-column mathematical grid.
  final List<DesktopGridItem> items;

  /// Execution tracking user identifier.
  final String userId;

  /// Execution tracking step reference.
  final String stepExecutionId;

  /// Callback invoked when telemetry data is collected during layout pass.
  final void Function(DesktopGridTelemetry telemetry)? onTelemetryLogged;

  const Desktop12ColumnGrid({
    super.key,
    required this.items,
    this.outerPadding = const EdgeInsets.all(24.0),
    this.gutterSpacing = 24.0,
    this.maxContainerWidth = 1600.0,
    this.userId = 'system_user',
    this.stepExecutionId = 'EXEC-DPNDL-004-A05',
    this.onTelemetryLogged,
  });

  @override
  State<Desktop12ColumnGrid> createState() => _Desktop12ColumnGridState();
}

class _Desktop12ColumnGridState extends State<Desktop12ColumnGrid> {
  static const int _totalColumns = 12;
  bool _hasLoggedTelemetry = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Constrain width for ultra-wide screens to prevent cognitive overload
        final double screenWidth = constraints.maxWidth;
        final double clampedWidth = screenWidth.clamp(0.0, widget.maxContainerWidth);

        final EdgeInsets resolvedPadding = widget.outerPadding.resolve(Directionality.of(context));
        final double totalHorizontalPadding = resolvedPadding.left + resolvedPadding.right;
        final double contentWidth = (clampedWidth - totalHorizontalPadding).clamp(0.0, double.infinity);

        final double totalGutters = (_totalColumns - 1) * widget.gutterSpacing;
        final double columnWidth = ((contentWidth - totalGutters) / _totalColumns).clamp(0.0, double.infinity);

        // Poka-yoke verification: 8dp baseline grid compliance check
        final bool adheresTo8ptGrid = (widget.gutterSpacing % 8.0 == 0) && (resolvedPadding.left % 8.0 == 0);

        if (!_hasLoggedTelemetry) {
          _hasLoggedTelemetry = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final DesktopGridTelemetry telemetry = DesktopGridTelemetry(
              stepExecutionId: widget.stepExecutionId,
              executionStatus: 'COMPLETED',
              executionTimestamp: DateTime.now().toUtc(),
              stepOutcome: adheresTo8ptGrid ? 'Pass' : 'Warning: Non-8pt grid dimensions',
              userId: widget.userId,
              calculatedAvailableWidth: contentWidth,
              calculatedColumnWidth: columnWidth,
              isWithinFloorOptimalCeiling: adheresTo8ptGrid,
            );
            widget.onTelemetryLogged?.call(telemetry);
          });
        }

        // Layout items into rows of 12 columns
        final List<Widget> rows = _buildGridRows(contentWidth, columnWidth);

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: widget.maxContainerWidth),
            child: Padding(
              padding: widget.outerPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: rows,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildGridRows(double contentWidth, double columnWidth) {
    final List<Widget> rowWidgets = <Widget>[];
    List<Widget> currentRowChildren = <Widget>[];
    int accumulatedColumns = 0;

    for (int i = 0; i < widget.items.length; i++) {
      final DesktopGridItem item = widget.items[i];
      final int span = item.columnSpan;

      if (accumulatedColumns + span > _totalColumns && currentRowChildren.isNotEmpty) {
        // Flush current row
        rowWidgets.add(
          Row(
            key: ValueKey<String>('grid_row_${rowWidgets.length}'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.from(currentRowChildren),
          ),
        );
        rowWidgets.add(SizedBox(height: widget.gutterSpacing));
        currentRowChildren = <Widget>[];
        accumulatedColumns = 0;
      }

      final double itemWidth = (span * columnWidth) + ((span - 1) * widget.gutterSpacing);

      currentRowChildren.add(
        SizedBox(
          key: item.key,
          width: itemWidth,
          height: item.minHeight,
          child: item.child,
        ),
      );

      accumulatedColumns += span;

      // Add horizontal gutter between columns if not at row end
      if (accumulatedColumns < _totalColumns && i < widget.items.length - 1) {
        currentRowChildren.add(SizedBox(width: widget.gutterSpacing));
      }
    }

    if (currentRowChildren.isNotEmpty) {
      rowWidgets.add(
        Row(
          key: ValueKey<String>('grid_row_${rowWidgets.length}'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: currentRowChildren,
        ),
      );
    }

    return rowWidgets;
  }
}
