import 'package:flutter/material.dart';
import '../models/schema_template_model.dart';

class SchemaHeaderCardWidget extends StatefulWidget {
  const SchemaHeaderCardWidget({super.key});

  @override
  State<SchemaHeaderCardWidget> createState() => _SchemaHeaderCardWidgetState();
}

class _SchemaHeaderCardWidgetState extends State<SchemaHeaderCardWidget> {
  int _activeLineIndex = 0;
  bool _isValidating = false;

  final SchemaTemplateModel _schemaModel = SchemaTemplateModel(
    tableName: 'raw_ingestion_events_v1',
    catalogName: 'db_catalog_enterprise_prod',
    schemaVersion: 'v1.13.0-RC2',
    masterChecksumHash:
        'SHA256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
    isNormalizedPokaYokePassed: true,
    mobilePlatform: 'Android OS (ARM64)',
    osVersion: 'Android 14 (API 34)',
    deviceType: 'Pixel 8 Pro Viewport',
    screenDimensions: '412x915 dp',
    mobileConfiguration: 'Release / Production Build Target',
    columns: [
      SchemaColumnDefinition(
        lineNumber: 1,
        columnName: 'event_id',
        dataType: 'STRING (UUID)',
        isNullable: false,
        checksum: 'CRC32:8A92B1C4',
      ),
      SchemaColumnDefinition(
        lineNumber: 2,
        columnName: 'payload_timestamp',
        dataType: 'TIMESTAMP (UTC)',
        isNullable: false,
        checksum: 'CRC32:3F1092A1',
      ),
      SchemaColumnDefinition(
        lineNumber: 3,
        columnName: 'source_system_code',
        dataType: 'VARCHAR(64)',
        isNullable: true,
        checksum: 'CRC32:7C44E89B',
      ),
      SchemaColumnDefinition(
        lineNumber: 4,
        columnName: 'raw_payload_bytes',
        dataType: 'BYTES',
        isNullable: true,
        checksum: 'CRC32:1A0283FE',
      ),
    ],
  );

  void _nextSchemaLine() {
    setState(() {
      _activeLineIndex = (_activeLineIndex + 1) % _schemaModel.columns.length;
    });
  }

  void _previousSchemaLine() {
    setState(() {
      _activeLineIndex =
          (_activeLineIndex - 1 + _schemaModel.columns.length) %
          _schemaModel.columns.length;
    });
  }

  void _triggerSchemaValidation() {
    setState(() => _isValidating = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isValidating = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Poka-Yoke Linter Success: 100% Normalized schema columns verified in database catalog.',
            ),
            backgroundColor: Colors.teal.shade800,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final activeColumn = _schemaModel.columns[_activeLineIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog Schema Template'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        // Single-Column Vertical Configuration
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. NON-EDITABLE MATERIAL DESIGN 3 HEADER CARD
            // =========================================================
            Card.filled(
              color: colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(color: colorScheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.table_chart_rounded,
                              color: colorScheme.primary,
                              size: 22.0,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'CORE TABLE METADATA',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 3.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: Colors.green.shade300),
                          ),
                          child: Text(
                            'POKA-YOKE PASS',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12.0),

                    // Non-editable metadata text entries
                    Text(
                      _schemaModel.tableName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4.0),

                    Text(
                      'Catalog: ${_schemaModel.catalogName} • Version: ${_schemaModel.schemaVersion}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 12.0),
                    const Divider(height: 1.0),
                    const SizedBox(height: 12.0),

                    // REQUIREMENT: Monospace Checksum Box for Immediate Visual Variance
                    Text(
                      'Master Catalog Checksum Hash:',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade900,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _schemaModel.masterChecksumHash,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24.0),

            // =========================================================
            // 2. PROGRESSIVE DISPLAY TRANSITION (Schema Line Browser)
            // =========================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Schema Line Browser',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Line ${_activeLineIndex + 1} of ${_schemaModel.columns.length}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8.0),

            // AnimatedSwitcher for Smooth Line Change Transitions
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.05, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Card.outlined(
                key: ValueKey<int>(activeColumn.lineNumber),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Column #${activeColumn.lineNumber}: ${activeColumn.columnName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              activeColumn.dataType,
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nullable: ${activeColumn.isNullable ? "YES" : "NO (NOT NULL)"}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: activeColumn.isNullable
                                  ? Colors.grey.shade700
                                  : Colors.red.shade800,
                              fontWeight: activeColumn.isNullable
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                          // Column Checksum Tag (Distinct Typography)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade100,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              activeColumn.checksum,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8.0),

            // Previous / Next Line Selector Buttons (>=48dp Touch Targets)
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.0, // Minimum 48dp Touch Target
                    child: OutlinedButton.icon(
                      onPressed: _previousSchemaLine,
                      icon: const Icon(Icons.arrow_back_rounded, size: 18.0),
                      label: const Text('Previous Line'),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: SizedBox(
                    height: 48.0, // Minimum 48dp Touch Target
                    child: OutlinedButton.icon(
                      onPressed: _nextSchemaLine,
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18.0),
                      label: const Text('Next Line'),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24.0),

            // =========================================================
            // 3. INTERACTIVE VALIDATION TRIGGER (NATIVE 48DP SPECS)
            // =========================================================
            SizedBox(
              width: double.infinity,
              height: 48.0, // Native 48dp Minimum Spec
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _isValidating ? null : _triggerSchemaValidation,
                icon: _isValidating
                    ? SizedBox(
                        width: 18.0,
                        height: 18.0,
                        child: CircularProgressIndicator(
                          color: colorScheme.onPrimary,
                          strokeWidth: 2.0,
                        ),
                      )
                    : const Icon(Icons.fact_check_rounded),
                label: Text(
                  _isValidating
                      ? 'Executing Poka-Yoke Linter...'
                      : 'Validate Catalog Schema Template',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24.0),

            // =========================================================
            // 4. ATOMIC ENVIRONMENT TELEMETRY SUMMARY
            // =========================================================
            Text(
              'Mobile Environment Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildTelemetryRow(
                      'Mobile Platform',
                      _schemaModel.mobilePlatform,
                    ),
                    const Divider(height: 12.0),
                    _buildTelemetryRow('OS Version', _schemaModel.osVersion),
                    const Divider(height: 12.0),
                    _buildTelemetryRow('Device Type', _schemaModel.deviceType),
                    const Divider(height: 12.0),
                    _buildTelemetryRow(
                      'Screen Dimensions',
                      _schemaModel.screenDimensions,
                    ),
                    const Divider(height: 12.0),
                    _buildTelemetryRow(
                      'Mobile Configuration',
                      _schemaModel.mobileConfiguration,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
