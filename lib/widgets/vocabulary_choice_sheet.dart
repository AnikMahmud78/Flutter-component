import 'package:flutter/material.dart';
import '../models/vocabulary_mapping_model.dart';

class VocabularyChoiceSheetScreen extends StatefulWidget {
  const VocabularyChoiceSheetScreen({super.key});

  @override
  State<VocabularyChoiceSheetScreen> createState() =>
      _VocabularyChoiceSheetScreenState();
}

class _VocabularyChoiceSheetScreenState
    extends State<VocabularyChoiceSheetScreen> {
  final TextEditingController _inputController = TextEditingController();
  final VocabularyMappingRecord _mappingRecord = VocabularyMappingRecord(
    sourceElementId: 'SRC-TXT-INPUT-01',
    targetElementId: 'TGT-VOCAB-SCHEMA-05',
    mappingRule: 'DAMA_DMBOK2_APPROVED_KEYWORDS_ONLY',
    approvedVocabulary: [
      'AUTHENTICATE_USER',
      'EXECUTE_INGESTION',
      'COMMIT_TRANSACTION',
      'PURGE_EXPIRED_CACHE',
      'ARCHIVE_AUDIT_LOG',
    ],
  );

  String _selectedKeyword = '';
  int? _hoveredOrSelectedIdx;
  bool _hasException = false;

  void _selectKeyword(String keyword, int index) {
    setState(() {
      _selectedKeyword = keyword;
      _hoveredOrSelectedIdx = index;
      _inputController.text = keyword;
      _hasException = false;
      _mappingRecord.mappingStatus = 'VALIDATED';
      _mappingRecord.mappingValidation =
          '100% Accuracy - Term "$keyword" matches DAMA-DMBOK2 standard.';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Keyword Selected: "$keyword". Poka-Yoke Passed.'),
        backgroundColor: Colors.teal.shade800,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleManualInputValidation(String value) {
    final isValid = _mappingRecord.validateVocabulary(value);
    setState(() {
      if (isValid) {
        _hasException = false;
        _selectedKeyword = value.trim();
        _mappingRecord.mappingStatus = 'VALIDATED';
        _mappingRecord.mappingValidation =
            '100% Accuracy - Manual entry matches standard.';
      } else {
        _hasException = true;
        _mappingRecord.mappingStatus = 'REJECTED';
        _mappingRecord.mappingValidation =
            'FORMAT EXCEPTION: Unapproved custom term "$value" rejected by Poka-Yoke filter.';
      }
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restricted Vocabulary Menu'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp outer margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DAMA-DMBOK2 ACCURACY BANNER
            Card.filled(
              color: _hasException
                  ? colorScheme.errorContainer
                  : Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: _hasException
                      ? colorScheme.error
                      : Colors.green.shade300,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      _hasException
                          ? Icons.warning_amber_rounded
                          : Icons.verified_user_rounded,
                      color: _hasException
                          ? colorScheme.error
                          : Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _hasException
                                ? 'Format Exception Active'
                                : 'Schema Accuracy: 100% (Good)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: _hasException
                                  ? colorScheme.onErrorContainer
                                  : Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _mappingRecord.mappingValidation,
                            style: TextStyle(
                              fontSize: 11,
                              color: _hasException
                                  ? colorScheme.onErrorContainer
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // INPUT FORM WITH HIGH-CONTRAST BORDER HIGHLIGHT
            Text(
              'Target System Term Field',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                // High-contrast primary border highlight
                border: Border.all(
                  color: _hasException
                      ? colorScheme.error
                      : colorScheme.primary,
                  width: 2.0,
                ),
              ),
              child: TextFormField(
                controller: _inputController,
                onChanged: _handleManualInputValidation,
                decoration: InputDecoration(
                  hintText: 'Select or type approved vocabulary...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                  suffixIcon: Icon(
                    _hasException ? Icons.cancel : Icons.check_circle,
                    color: _hasException ? colorScheme.error : Colors.green,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // PERSISTENT CHOICE MENU BOTTOM SHEET INLINE CONTAINER
            Text(
              'Approved Vocabulary Select List (Single-Column)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Selecting keywords triggers micro-scale animations. Fields enforce 48dp minimum specs.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20.0),
                  bottom: Radius.circular(12.0),
                ),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // SINGLE-COLUMN LIST ITEMS
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _mappingRecord.approvedVocabulary.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = _mappingRecord.approvedVocabulary[index];
                      final isSelected = _selectedKeyword == item;

                      return AnimatedScale(
                        scale: _hoveredOrSelectedIdx == index ? 1.02 : 1.0,
                        duration: const Duration(milliseconds: 150),
                        child: Material(
                          color: isSelected
                              ? colorScheme.primaryContainer
                              : colorScheme.surface,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: () => _selectKeyword(item, index),
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              // 48dp Touch Target Constraint
                              constraints: const BoxConstraints(
                                minHeight: 48.0,
                                minWidth: 48.0,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: isSelected
                                      ? colorScheme.primary
                                      : Colors.grey.shade300,
                                  width: isSelected ? 2.0 : 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      fontSize: 13,
                                      color: isSelected
                                          ? colorScheme.onPrimaryContainer
                                          : colorScheme.onSurface,
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.radio_button_checked_rounded,
                                      color: colorScheme.primary,
                                      size: 20,
                                    )
                                  else
                                    const Icon(
                                      Icons.radio_button_unchecked_rounded,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC MAPPING DATA FIELD TELEMETRY SUMMARY
            Text(
              'Atomic Mapping Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildTelemetryRow(
                      'Source Element ID',
                      _mappingRecord.sourceElementId,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Target Element ID',
                      _mappingRecord.targetElementId,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Mapping Rule',
                      _mappingRecord.mappingRule,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Mapping Status',
                      _mappingRecord.mappingStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Validation Outcome',
                      _mappingRecord.mappingValidation,
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

  Widget _buildTelemetryRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight
                  ? (_hasException ? Colors.red.shade800 : Colors.teal.shade800)
                  : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
