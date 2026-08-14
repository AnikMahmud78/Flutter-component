import 'package:flutter/material.dart';
import '../models/document_metadata_model.dart';

class AtomicVariableNormalizerWidget extends StatefulWidget {
  const AtomicVariableNormalizerWidget({super.key});

  @override
  State<AtomicVariableNormalizerWidget> createState() =>
      _AtomicVariableNormalizerWidgetState();
}

class _AtomicVariableNormalizerWidgetState
    extends State<AtomicVariableNormalizerWidget> {
  final _formKey = GlobalKey<FormState>();

  // Legacy composite string sample for scanning & deconstruction
  final TextEditingController _compositeScanController = TextEditingController(
    text:
        'Architecture Blueprint v4.2 | https://docs.internal.net/arch/v42.pdf | 2026-08-14T09:27:00Z | WCAG_2_1_AA_PASS | LOG_ENTRY_ID_2470',
  );

  // Atomic field controllers
  late TextEditingController _titleController;
  late TextEditingController _urlController;
  late TextEditingController _dateController;
  late TextEditingController _statusController;
  late TextEditingController _logController;

  bool _isPokaYokePassed = true;
  bool _isNormalizing = false;

  @override
  void initState() {
    super.initState();
    final initialModel = DocumentMetadataModel.parseCompositeString(
      _compositeScanController.text,
    )!;
    _titleController = TextEditingController(text: initialModel.documentTitle);
    _urlController = TextEditingController(text: initialModel.documentUrl);
    _dateController = TextEditingController(text: initialModel.lastUpdatedDate);
    _statusController = TextEditingController(
      text: initialModel.accessibilityStatus,
    );
    _logController = TextEditingController(
      text: initialModel.documentAccessLog,
    );
  }

  @override
  void dispose() {
    _compositeScanController.dispose();
    _titleController.dispose();
    _urlController.dispose();
    _dateController.dispose();
    _statusController.dispose();
    _logController.dispose();
    super.dispose();
  }

  void _scanAndDeconstructCompositeString() {
    final parsed = DocumentMetadataModel.parseCompositeString(
      _compositeScanController.text,
    );
    if (parsed != null) {
      setState(() {
        _titleController.text = parsed.documentTitle;
        _urlController.text = parsed.documentUrl;
        _dateController.text = parsed.lastUpdatedDate;
        _statusController.text = parsed.accessibilityStatus;
        _logController.text = parsed.documentAccessLog;
        _isPokaYokePassed = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'POKA-YOKE PASS: Composite string deconstructed into 5 atomic variables.',
          ),
          backgroundColor: Colors.teal.shade800,
        ),
      );
    } else {
      setState(() => _isPokaYokePassed = false);
    }
  }

  void _validateAndSubmitAtomicMetadata() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isNormalizing = true);

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() => _isNormalizing = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'DAMA-DMBOK2 SUCCESS: 100% Atomic metadata schema committed to database repository.',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atomic Variable Normalizer'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        // Single-Column Vertical Configuration (16dp outer padding)
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. DAMA-DMBOK2 METADATA COMPLETENESS BANNER
            // =========================================================
            Card.filled(
              color: _isPokaYokePassed
                  ? Colors.green.shade50
                  : colorScheme.errorContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: _isPokaYokePassed
                      ? Colors.green.shade300
                      : colorScheme.error,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      _isPokaYokePassed
                          ? Icons.task_alt_rounded
                          : Icons.gpp_bad_rounded,
                      color: _isPokaYokePassed
                          ? Colors.green.shade800
                          : colorScheme.error,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isPokaYokePassed
                                ? 'Metadata Completeness: 100% (Complete)'
                                : 'POKA-YOKE BLOCK: Composite String Detected',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: _isPokaYokePassed
                                  ? Colors.green.shade900
                                  : colorScheme.onErrorContainer,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _isPokaYokePassed
                                ? 'Compliant with DAMA-DMBOK2 Metadata Management Standard.'
                                : 'Build rejected: Composite column packing is prohibited.',
                            style: TextStyle(
                              fontSize: 11,
                              color: _isPokaYokePassed
                                  ? Colors.black87
                                  : colorScheme.onErrorContainer,
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

            // =========================================================
            // 2. LEGACY COMPOSITE STRING SCANNING CONTROL
            // =========================================================
            Text(
              'Scan Multi-Variable Composite Source',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            TextFormField(
              controller: _compositeScanController,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
              decoration: InputDecoration(
                labelText: 'Raw Composite Layout String',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey.shade100,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cleaning_services_rounded),
                  onPressed: _scanAndDeconstructCompositeString,
                  tooltip: 'Deconstruct to Atomic Variables',
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 3. SINGLE-COLUMN ATOMIC VARIABLE INPUT FORM
            // =========================================================
            Text(
              'Atomic Variable Configuration Form',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Isolated fields match phone proportions. Monospaced font ensures line clarity.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // ATOMIC FIELD 1: Document Title
                  _buildAtomicInputField(
                    label: 'Document Title',
                    controller: _titleController,
                    isMonospace: false,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Document Title is required.';
                      }
                      if (DocumentMetadataModel.containsCompositeDelimiter(
                        val,
                      )) {
                        return 'Poka-Yoke Error: Title cannot contain composite delimiters (| ; ::).';
                      }
                      return null;
                    },
                  ),

                  // ATOMIC FIELD 2: Document URL (Monospaced + URL Validator)
                  _buildAtomicInputField(
                    label: 'Document URL',
                    controller: _urlController,
                    isMonospace: true,
                    validator: (val) {
                      if (val == null || !val.startsWith('https://')) {
                        return 'Syntax Error: Document URL must begin with "https://".';
                      }
                      if (DocumentMetadataModel.containsCompositeDelimiter(
                        val,
                      )) {
                        return 'Poka-Yoke Error: URL contains illegal composite characters.';
                      }
                      return null;
                    },
                  ),

                  // ATOMIC FIELD 3: Last Updated Date (Monospaced + ISO Date Validator)
                  _buildAtomicInputField(
                    label: 'Last Updated Date (ISO 8601)',
                    controller: _dateController,
                    isMonospace: true,
                    validator: (val) {
                      if (val == null ||
                          !val.contains('T') ||
                          !val.endsWith('Z')) {
                        return 'Syntax Error: Invalid ISO 8601 format (expected YYYY-MM-DDThh:mm:ssZ).';
                      }
                      return null;
                    },
                  ),

                  // ATOMIC FIELD 4: Accessibility Status (Monospaced)
                  _buildAtomicInputField(
                    label: 'Accessibility Status',
                    controller: _statusController,
                    isMonospace: true,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Accessibility Status is required.';
                      }
                      return null;
                    },
                  ),

                  // ATOMIC FIELD 5: Document Access Log (Monospaced)
                  _buildAtomicInputField(
                    label: 'Document Access Log',
                    controller: _logController,
                    isMonospace: true,
                    maxLines: 2,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Document Access Log is required.';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  // SUBMIT ACTION BUTTON (>= 48DP TOUCH TARGET NATIVELY)
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 48.0,
                      minHeight: 48.0, // Native 48dp Touch Target
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: _isNormalizing
                            ? null
                            : _validateAndSubmitAtomicMetadata,
                        icon: _isNormalizing
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.commit_rounded),
                        label: const Text(
                          'COMMIT_ATOMIC_METADATA_SCHEMA',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper building single-column atomic input fields with monospaced options and responsive syntax errors
  Widget _buildAtomicInputField({
    required String label,
    required TextEditingController controller,
    required bool isMonospace,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Standard spatial padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 6),
          // 48dp Touch Target Constraint
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0, minWidth: 48.0),
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              validator: validator,
              style: TextStyle(
                fontFamily: isMonospace ? 'monospace' : null,
                fontWeight: isMonospace ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                // Responsive Visual Syntax Error Styling
                errorStyle: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
