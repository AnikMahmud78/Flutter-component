// DPNDL-004-A04 — Desktop 12-Column Grid Layout Framework.
// Implements Material 3 Expanded Layout 12-column grid specifications featuring
// strict 24dp screen margins, 24dp gutters, column spanning, and ultra-wide constraints.

import 'package:flutter/material.dart';

/// Grid alignment rules for the 12-column layout.
enum DesktopGridAlignment {
  start,
  center,
  end,
}

/// Layout validation status according to MD3 and boundary specifications.
enum LayoutValidationStatus {
  pass,
  fail,
}

/// Immutable data configuration capturing layout audit and telemetry telemetry fields.
@immutable
class DesktopGridTelemetryData {
  const DesktopGridTelemetryData({
    required this.layoutType,
    required this.totalColumns,
    required this.margin,
    required this.gutter,
    required this.maxWidth,
    required this.containerWidth,
    required this.columnWidth,
    required this.validationStatus,
    required this.timestamp,
  });

  final String layoutType;
  final int totalColumns;
  final double margin;
  final double gutter;
  final double maxWidth;
  final double containerWidth;
  final double columnWidth;
  final LayoutValidationStatus validationStatus;
  final DateTime timestamp;

  Map<String, dynamic> toMap() => {
        'layoutType': layoutType,
        'totalColumns': totalColumns,
        'margin': margin,
        'gutter': gutter,
        'maxWidth': maxWidth,
        'containerWidth': containerWidth,
        'columnWidth': columnWidth,
        'validationStatus': validationStatus == LayoutValidationStatus.pass ? 'Pass' : 'Fail',
        'timestamp': timestamp.toIso8601String(),
      };
}

/// Specification for a single item child positioned within the 12-column desktop grid.
@immutable
class DesktopGridItem {
  DesktopGridItem({
    required this.child,
    this.columnSpan = 12,
    this.columnOffset = 0,
    this.key,
  })  : assert(columnSpan >= 1 && columnSpan <= 12, 'columnSpan must be between 1 and 12.'),
        assert(columnOffset >= 0 && columnOffset < 12, 'columnOffset must be between 0 and 11.'),
        assert(
          columnSpan + columnOffset <= 12,
          'Sum of columnSpan ($columnSpan) and columnOffset ($columnOffset) cannot exceed 12.',
        );

  final Widget child;
  final int columnSpan;
  final int columnOffset;
  final Key? key;
}

/// Material Design 3 Expanded Layout 12-Column Desktop Grid Framework.
///
/// Enforces 24dp margins, 24dp gutters, 12-column snapping, and enterprise
/// container max-width limits to avoid distorted visualization charts on
/// ultra-wide monitors.
class Desktop12ColumnGrid extends StatelessWidget {
  const Desktop12ColumnGrid({
    super.key,
    required this.children,
    this.margin = 24.0,
    this.gutter = 24.0,
    this.maxContainerWidth = 1440.0,
    this.alignment = DesktopGridAlignment.center,
    this.rowSpacing = 24.0,
    this.onTelemetryLogged,
  });

  /// Explicit list of children with column spans.
  final List<DesktopGridItem> children;

  /// Strict screen outer padding margin (Material 3 expanded baseline = 24dp).
  final double margin;

  /// Structural gutter between adjacent columns (baseline = 24dp).
  final double gutter;

  /// Maximum constraint container width for ultra-wide desktop monitors.
  final double maxContainerWidth;

  /// Cross-axis horizontal alignment for the grid within expansive viewports.
  final DesktopGridAlignment alignment;

  /// Vertical gap between consecutive wrapped grid rows.
  final double rowSpacing;

  /// Optional callback returning runtime telemetry and validation metrics.
  final ValueChanged<DesktopGridTelemetryData>? onTelemetryLogged;

  static const int totalColumns = 12;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double availableWidth = constraints.maxWidth;
        final double effectiveWidth = availableWidth.clamp(0.0, maxContainerWidth);

        // Compute inner grid content width discounting outer margins
        final double usableWidth = (effectiveWidth - (margin * 2)).clamp(0.0, double.infinity);

        // 12 columns have 11 gutters
        final double totalGutterWidth = gutter * (totalColumns - 1);
        final double columnWidth = ((usableWidth - totalGutterWidth) / totalColumns).clamp(0.0, double.infinity);

        // Determine adherence to 8pt base grid and zero-overflow criteria
        final bool isGutterCompliant = gutter % 4 == 0;
        final bool isMarginCompliant = margin % 4 == 0;
        final bool isValid = usableWidth > 0 && isGutterCompliant && isMarginCompliant;

        if (onTelemetryLogged != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onTelemetryLogged!(
              DesktopGridTelemetryData(
                layoutType: '12-Column Desktop Grid (MD3 Expanded)',
                totalColumns: totalColumns,
                margin: margin,
                gutter: gutter,
                maxWidth: maxContainerWidth,
                containerWidth: effectiveWidth,
                columnWidth: columnWidth,
                validationStatus: isValid ? LayoutValidationStatus.pass : LayoutValidationStatus.fail,
                timestamp: DateTime.now(),
              ),
            );
          });
        }

        Alignment containerAlignment;
        switch (alignment) {
          case DesktopGridAlignment.start:
            containerAlignment = Alignment.centerLeft;
            break;
          case DesktopGridAlignment.end:
            containerAlignment = Alignment.centerRight;
            break;
          case DesktopGridAlignment.center:
            containerAlignment = Alignment.center;
            break;
        }

        return Align(
          alignment: containerAlignment,
          child: SizedBox(
            width: effectiveWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: _buildRows(context, columnWidth),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRows(BuildContext context, double columnWidth) {
    final List<Widget> rows = <Widget>[];
    List<Widget> currentRowChildren = <Widget>[];
    int accumulatedSpan = 0;

    for (int i = 0; i < children.length; i++) {
      final DesktopGridItem item = children[i];
      final int itemTotalSpan = item.columnOffset + item.columnSpan;

      // Wrap to next line if item exceeds the 12-column boundary
      if (accumulatedSpan + itemTotalSpan > totalColumns && currentRowChildren.isNotEmpty) {
        rows.add(_buildSingleRow(currentRowChildren));
        currentRowChildren = <Widget>[];
        accumulatedSpan = 0;
      }

      // Calculate calculated width based on spans and gutters
      final double itemWidth = (columnWidth * item.columnSpan) + (gutter * (item.columnSpan - 1));
      final double offsetWidth =
          item.columnOffset > 0 ? (columnWidth * item.columnOffset) + (gutter * item.columnOffset) : 0.0;

      if (offsetWidth > 0) {
        currentRowChildren.add(SizedBox(width: offsetWidth));
      }

      currentRowChildren.add(
        SizedBox(
          key: item.key,
          width: itemWidth,
          child: item.child,
        ),
      );

      accumulatedSpan += itemTotalSpan;

      // Append gutter between row elements if there is capacity
      if (accumulatedSpan < totalColumns) {
        currentRowChildren.add(SizedBox(width: gutter));
      }
    }

    if (currentRowChildren.isNotEmpty) {
      rows.add(_buildSingleRow(currentRowChildren));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int index = 0; index < rows.length; index++) ...<Widget>[
          rows[index],
          if (index < rows.length - 1) SizedBox(height: rowSpacing),
        ],
      ],
    );
  }

  Widget _buildSingleRow(List<Widget> rowChildren) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowChildren,
    );
  }
}
