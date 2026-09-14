// CUITC-018 — Dubai VAT Return Form 201 Tabbed View Component.
// Implements Dubai VAT Return Form 201 mobile sections using accessible Material 3 tabbed navigation,
// visible completion progress indicators, inline non-blocking validation, and tenant execution telemetry.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Execution audit record tracking multi-tenant submission metadata.
class VatFormExecutionMetadata {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String tenantId;

  const VatFormExecutionMetadata({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.tenantId,
  });

  Map<String, dynamic> toJson() => {
        'step_execution_id': stepExecutionId,
        'execution_status': executionStatus,
        'execution_timestamp': executionTimestamp.toIso8601String(),
        'step_outcome': stepOutcome,
        'user_id': userId,
        'tenant_id': tenantId,
      };
}

/// Emirate breakdown entry for Standard Rated Supplies (Box 1).
class EmirateSupplyItem {
  final String emirateName;
  final TextEditingController amountController;
  final TextEditingController vatController;
  String? errorMessage;

  EmirateSupplyItem({
    required this.emirateName,
    String initialAmount = '',
    String initialVat = '',
  })  : amountController = TextEditingController(text: initialAmount),
        vatController = TextEditingController(text: initialVat);

  void dispose() {
    amountController.dispose();
    vatController.dispose();
  }
}

/// Complete State representation of Dubai VAT Return Form 201.
class Vat201FormData {
  String trnNumber = '';
  String taxPeriod = '';
  bool confirmTenantSeparation = false;
  final List<EmirateSupplyItem> salesByEmirates;

  final TextEditingController touristRefundController = TextEditingController();
  final TextEditingController reverseChargeSuppliesController = TextEditingController();
  final TextEditingController zeroRatedSuppliesController = TextEditingController();
  final TextEditingController exemptSuppliesController = TextEditingController();

  final TextEditingController standardExpensesController = TextEditingController();
  final TextEditingController standardExpensesVatController = TextEditingController();
  final TextEditingController reverseChargeExpensesController = TextEditingController();
  final TextEditingController reverseChargeExpensesVatController = TextEditingController();

  Vat201FormData() : salesByEmirates = [
          EmirateSupplyItem(emirateName: 'Abu Dhabi'),
          EmirateSupplyItem(emirateName: 'Dubai'),
          EmirateSupplyItem(emirateName: 'Sharjah'),
          EmirateSupplyItem(emirateName: 'Ajman'),
          EmirateSupplyItem(emirateName: 'Umm Al Quwain'),
          EmirateSupplyItem(emirateName: 'Ras Al Khaimah'),
          EmirateSupplyItem(emirateName: 'Fujairah'),
        ];

  void dispose() {
    for (final item in salesByEmirates) {
      item.dispose();
    }
    touristRefundController.dispose();
    reverseChargeSuppliesController.dispose();
    zeroRatedSuppliesController.dispose();
    exemptSuppliesController.dispose();
    standardExpensesController.dispose();
    standardExpensesVatController.dispose();
    reverseChargeExpensesController.dispose();
    reverseChargeExpensesVatController.dispose();
  }
}

/// Primary Dubai VAT Form 201 Widget adhering to M3 and atomic isolation requirements.
class DubaiVatReturnForm201Widget extends StatefulWidget {
  final String userId;
  final String tenantId;
  final ValueChanged<VatFormExecutionMetadata>? onAuditLogged;
  final ValueChanged<Map<String, dynamic>>? onFormSubmitted;

  const DubaiVatReturnForm201Widget({
    super.key,
    required this.userId,
    required this.tenantId,
    this.onAuditLogged,
    this.onFormSubmitted,
  });

  @override
  State<DubaiVatReturnForm201Widget> createState() => _DubaiVatReturnForm201WidgetState();
}

class _DubaiVatReturnForm201WidgetState extends State<DubaiVatReturnForm201Widget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Vat201FormData _formData;
  final Map<String, String?> _errors = {};
  int _currentTabIndex = 0;

  static const List<String> _tabTitles = [
    'Entity & Period',
    'VAT on Sales',
    'VAT on Expenses',
    'Net VAT Summary',
  ];

  @override
  void initState() {
    super.initState();
    _formData = Vat201FormData();
    _tabController = TabController(length: _tabTitles.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging || _tabController.index != _currentTabIndex) {
        setState(() {
          _currentTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _formData.dispose();
    super.dispose();
  }

  double _calculateCompletionProgress() {
    int totalWeight = 4;
    int completed = 0;

    if (_formData.trnNumber.trim().length >= 15 && _formData.confirmTenantSeparation) {
      completed++;
    }

    bool hasSales = _formData.salesByEmirates.any((e) => e.amountController.text.isNotEmpty);
    if (hasSales) completed++;

    bool hasExpenses = _formData.standardExpensesController.text.isNotEmpty;
    if (hasExpenses) completed++;

    if (completed >= 3 && _errors.isEmpty) completed++;

    return (completed / totalWeight).clamp(0.0, 1.0);
  }

  double _parseValue(String text) {
    return double.tryParse(text.replaceAll(',', '')) ?? 0.0;
  }

  double _calculateTotalOutputVat() {
    double emiratesVat = 0.0;
    for (var item in _formData.salesByEmirates) {
      emiratesVat += _parseValue(item.vatController.text);
    }
    double touristRefund = _parseValue(_formData.touristRefundController.text);
    double rcmVat = _parseValue(_formData.reverseChargeSuppliesController.text) * 0.05;
    return (emiratesVat - touristRefund + rcmVat).clamp(0.0, double.infinity);
  }

  double _calculateTotalRecoverableVat() {
    double standardVat = _parseValue(_formData.standardExpensesVatController.text);
    double rcmVat = _parseValue(_formData.reverseChargeExpensesVatController.text);
    return standardVat + rcmVat;
  }

  double _calculateNetVatPayable() {
    return _calculateTotalOutputVat() - _calculateTotalRecoverableVat();
  }

  void _validateField(String key, String value) {
    setState(() {
      if (key == 'trn') {
        if (value.trim().isEmpty) {
          _errors['trn'] = 'Tax registration number (TRN) is required.';
        } else if (value.trim().length != 15 || int.tryParse(value.trim()) == null) {
          _errors['trn'] = 'TRN must be exactly 15 numeric digits.';
        } else {
          _errors.remove('trn');
        }
      }
    });
  }

  void _submitForm() {
    _validateField('trn', _formData.trnNumber);
    if (!_formData.confirmTenantSeparation) {
      setState(() {
        _errors['tenant_consent'] = 'You must confirm isolated tenant data verification.';
      });
    } else {
      _errors.remove('tenant_consent');
    }

    final bool isValid = _errors.isEmpty && _formData.trnNumber.isNotEmpty;
    final metadata = VatFormExecutionMetadata(
      stepExecutionId: 'EXEC-${DateTime.now().millisecondsSinceEpoch}',
      executionStatus: isValid ? 'SUCCESS' : 'FAILED_VALIDATION',
      executionTimestamp: DateTime.now(),
      stepOutcome: isValid ? 'Good' : 'Poor',
      userId: widget.userId,
      tenantId: widget.tenantId,
    );

    widget.onAuditLogged?.call(metadata);

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please resolve validation errors before submitting VAT 201.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final payload = {
      'metadata': metadata.toJson(),
      'trn': _formData.trnNumber,
      'tax_period': _formData.taxPeriod,
      'total_output_vat': _calculateTotalOutputVat(),
      'total_recoverable_vat': _calculateTotalRecoverableVat(),
      'net_vat_due': _calculateNetVatPayable(),
    };

    widget.onFormSubmitted?.call(payload);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('VAT Return Form 201 successfully prepared for BigQuery dispatch.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final progress = _calculateCompletionProgress();

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Dubai VAT Form 201'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: colorScheme.surfaceContainerHighest,
                color: colorScheme.primary,
                minHeight: 4,
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                indicatorColor: colorScheme.primary,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                tabs: _tabTitles
                    .map(
                      (title) => Tab(
                        height: 48.0,
                        child: Text(
                          title,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEntityPeriodSection(theme, colorScheme),
          _buildSalesOutputsSection(theme, colorScheme),
          _buildExpensesInputsSection(theme, colorScheme),
          _buildSummarySection(theme, colorScheme),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
          ),
          child: Row(
            children: [
              if (_currentTabIndex > 0)
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () => _tabController.animateTo(_currentTabIndex - 1),
                    child: const Text('Previous Section'),
                  ),
                ),
              if (_currentTabIndex > 0) const SizedBox(width: 12.0),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    if (_currentTabIndex < _tabTitles.length - 1) {
                      _tabController.animateTo(_currentTabIndex + 1);
                    } else {
                      _submitForm();
                    }
                  },
                  child: Text(
                    _currentTabIndex == _tabTitles.length - 1
                        ? 'Validate & Submit'
                        : 'Next Section',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInlineError(String message, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        message,
        style: textTheme.bodySmall?.copyWith(
          color: colorScheme.onErrorContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEntityPeriodSection(ThemeData theme, ColorScheme colorScheme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'General Information & Multi-Tenant Context',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Isolated Tenant: ${widget.tenantId}',
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
          ),
          const SizedBox(height: 16.0),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(15)],
            decoration: InputDecoration(
              labelText: 'Tax Registration Number (TRN)',
              hintText: '100XXXXXXXXX003',
              border: const OutlineInputBorder(),
              suffixIcon: const Icon(Icons.shield_outlined),
              errorText: null,
            ),
            onChanged: (val) {
              _formData.trnNumber = val;
              _validateField('trn', val);
            },
          ),
          if (_errors.containsKey('trn'))
            _buildInlineError(_errors['trn']!, colorScheme, theme.textTheme),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Tax Period',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: '2025-Q1', child: Text('Q1 2025 (Jan - Mar)')),
              DropdownMenuItem(value: '2025-Q2', child: Text('Q2 2025 (Apr - Jun)')),
              DropdownMenuItem(value: '2025-Q3', child: Text('Q3 2025 (Jul - Sep)')),
              DropdownMenuItem(value: '2025-Q4', child: Text('Q4 2025 (Oct - Dec)')),
            ],
            onChanged: (val) {
              setState(() {
                _formData.taxPeriod = val ?? '';
              });
            },
          ),
          const SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'Confirm localized multi-tenant isolation compliance',
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                'Ensures row-level database filters protect operational history from cross-organization visibility.',
                style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              value: _formData.confirmTenantSeparation,
              onChanged: (bool? value) {
                setState(() {
                  _formData.confirmTenantSeparation = value ?? false;
                  if (_formData.confirmTenantSeparation) {
                    _errors.remove('tenant_consent');
                  }
                });
              },
            ),
          ),
          if (_errors.containsKey('tenant_consent'))
            _buildInlineError(_errors['tenant_consent']!, colorScheme, theme.textTheme),
        ],
      ),
    );
  }

  Widget _buildSalesOutputsSection(ThemeData theme, ColorScheme colorScheme) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Box 1: Standard Rated Supplies by Emirate',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Enter supply amounts subject to 5% VAT across the 7 Emirates.',
          style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.outline),
        ),
        const SizedBox(height: 16.0),
        ..._formData.salesByEmirates.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.emirateName,
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: item.amountController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Amount (AED)',
                              isDense: true,
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (val) {
                              final amount = double.tryParse(val) ?? 0.0;
                              item.vatController.text = (amount * 0.05).toStringAsFixed(2);
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: item.vatController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'VAT (5%)',
                              isDense: true,
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 8.0),
        TextField(
          controller: _formData.touristRefundController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Box 2: Tourist Tax Refunds Provided (AED)',
            border: OutlineInputBorder(),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildExpensesInputsSection(ThemeData theme, ColorScheme colorScheme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VAT on Expenses and All Other Inputs',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Box 9: Standard Rated Expenses',
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _formData.standardExpensesController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Expense Amount (AED)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) {
                    final amt = double.tryParse(val) ?? 0.0;
                    _formData.standardExpensesVatController.text = (amt * 0.05).toStringAsFixed(2);
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _formData.standardExpensesVatController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Input VAT (AED)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Text(
            'Box 10: Supplies Subject to Reverse Charge Provisions',
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _formData.reverseChargeExpensesController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'RCM Expense (AED)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) {
                    final amt = double.tryParse(val) ?? 0.0;
                    _formData.reverseChargeExpensesVatController.text = (amt * 0.05).toStringAsFixed(2);
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _formData.reverseChargeExpensesVatController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Recoverable VAT',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(ThemeData theme, ColorScheme colorScheme) {
    final totalOutputVat = _calculateTotalOutputVat();
    final totalRecoverableVat = _calculateTotalRecoverableVat();
    final netVatPayable = _calculateNetVatPayable();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Net VAT Due & Calculation Summary',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          _buildSummaryRow(theme, 'Total Value of Output Tax Due', totalOutputVat, colorScheme.primary),
          const Divider(),
          _buildSummaryRow(theme, 'Total Value of Recoverable Tax', totalRecoverableVat, colorScheme.secondary),
          const Divider(),
          const SizedBox(height: 8.0),
          Card(
            color: colorScheme.surfaceContainerHighest,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Net VAT Due / (Refund):',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'AED ${netVatPayable.toStringAsFixed(2)}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: netVatPayable >= 0 ? colorScheme.error : colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Text(
            'Security & Six Sigma DMAIC Benchmark',
            style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Defect Resolution Floor: 90% | Optimal: 99% | Context: DAMA-DMBOK2 & BigQuery Schema Isolation.',
            style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.outline),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(ThemeData theme, String label, double amount, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            'AED ${amount.toStringAsFixed(2)}',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
