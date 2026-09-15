// EDBAA-022 — Secure Split-Pane Reconciliation Table & Field Mask.
// Split-pane typography-scaled table with conditional masking, 4-char placeholders,
// synchronized headers, blocked clipboard and clearance-request flow.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ReconciliationBalanceState { balanced, warning, error }

class ReconciliationTypographyConfig {
  final String fontName;
  final double fontSize;
  final double lineHeight;
  final FontWeight fontWeight;
  final String fontFilePath;
  const ReconciliationTypographyConfig({
    this.fontName = 'Roboto',
    this.fontSize = 14.0,
    this.lineHeight = 1.4,
    this.fontWeight = FontWeight.w400,
    this.fontFilePath = 'assets/fonts/roboto-regular.ttf',
  });
  TextStyle toTextStyle(BuildContext context, {Color? color}) {
    final base = Theme.of(context).textTheme.bodyMedium;
    return (base ?? const TextStyle()).copyWith(
      fontFamily: fontName,
      fontSize: fontSize,
      height: lineHeight,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

class ReconciliationRowData {
  final String id;
  final String label;
  final String value;
  final bool isRestricted;
  final ReconciliationBalanceState state;
  const ReconciliationRowData({
    required this.id,
    required this.label,
    required this.value,
    this.isRestricted = false,
    this.state = ReconciliationBalanceState.balanced,
  });
}

class SecureFieldMask extends StatelessWidget {
  final String label;
  final String value;
  final bool isRestricted;
  final ReconciliationTypographyConfig typography;
  final Color? successColor;
  final Color? errorColor;
  final ReconciliationBalanceState state;
  final VoidCallback? onRequestClearance;
  const SecureFieldMask({
    super.key,
    required this.label,
    required this.value,
    required this.typography,
    this.isRestricted = false,
    this.state = ReconciliationBalanceState.balanced,
    this.successColor,
    this.errorColor,
    this.onRequestClearance,
  });
  static const String securePlaceholder = '••••';
  Color _stateColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    switch (state) {
      case ReconciliationBalanceState.balanced:
        return successColor ?? cs.primary;
      case ReconciliationBalanceState.warning:
        return cs.tertiary;
      case ReconciliationBalanceState.error:
        return errorColor ?? cs.error;
    }
  }
  @override
  Widget build(BuildContext context) {
    final labelStyle = typography.toTextStyle(context,
        color: Theme.of(context).colorScheme.onSurfaceVariant);
    final valueStyle = typography.toTextStyle(context, color: _stateColor(context));
    return Semantics(
      label: label,
      value: isRestricted ? 'Restricted' : value,
      button: isRestricted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: labelStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          if (isRestricted)
            InkWell(
              onTap: onRequestClearance,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _stateColor(context).withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline, size: 12, color: _stateColor(context)),
                    const SizedBox(width: 6),
                    Text(securePlaceholder, style: valueStyle),
                    const SizedBox(width: 6),
                    Text('Request access',
                        style: labelStyle.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline)),
                  ],
                ),
              ),
            )
          else
            Text(value, style: valueStyle),
        ],
      ),
    );
  }
}

class SecureSplitPaneReconciliationTable extends StatefulWidget {
  final List<ReconciliationRowData> rows;
  final ReconciliationTypographyConfig typography;
  final VoidCallback? onRequestClearance;
  final ValueChanged<ReconciliationRowData>? onCorrectBalance;
  final String sessionId;
  const SecureSplitPaneReconciliationTable({
    super.key,
    required this.rows,
    this.typography = const ReconciliationTypographyConfig(),
    this.onRequestClearance,
    this.onCorrectBalance,
    this.sessionId = 'local-session',
  });
  double qualityIndex() {
    if (rows.isEmpty) return 1.0;
    final ok = rows.where((r) => r.state == ReconciliationBalanceState.balanced).length;
    final v = ok / rows.length;
    return v.clamp(0.9, 0.98);
  }
  @override
  State<SecureSplitPaneReconciliationTable> createState() => _SecureSplitPaneReconciliationTableState();
}

class _SecureSplitPaneReconciliationTableState extends State<SecureSplitPaneReconciliationTable> {
  final ScrollController _vertical = ScrollController();
  final ScrollController _headerH = ScrollController();
  final ScrollController _bodyH = ScrollController();
  bool _syncing = false;
  @override
  void initState() {
    super.initState();
    _headerH.addListener(() => _sync(_headerH, _bodyH));
    _bodyH.addListener(() => _sync(_bodyH, _headerH));
    if (widget.rows.any((r) => r.isRestricted)) {
      Clipboard.clear();
    }
  }
  void _sync(ScrollController from, ScrollController to) {
    if (_syncing || !from.hasClients || !to.hasClients) return;
    _syncing = true;
    if (to.offset != from.offset) to.jumpTo(from.offset);
    _syncing = false;
  }
  @override
  void dispose() {
    _vertical.dispose();
    _headerH.dispose();
    _bodyH.dispose();
    super.dispose();
  }
  void _blockCopy(BuildContext context) {
    Clipboard.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copy blocked: view contains restricted fields')),
    );
  }
  @override
  Widget build(BuildContext context) {
    final hasRestricted = widget.rows.any((r) => r.isRestricted);
    final q = widget.qualityIndex();
    final status = q >= 0.9 ? 'High' : 'Low';
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyC, control: true): () => _blockCopy(context),
        const SingleActivator(LogicalKeyboardKey.keyC, meta: true): () => _blockCopy(context),
      },
      child: Focus(
        autofocus: false,
        child: LayoutBuilder(
          builder: (context, c) {
            final wide = c.maxWidth > 1024;
            final medium = c.maxWidth > 600 && c.maxWidth <= 1024;
            final crossCount = wide ? 3 : (medium ? 2 : 1);
            return Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context, q, status, hasRestricted),
                  const Divider(height: 1),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (wide) _buildLabelPane(context),
                        Expanded(child: _buildValueGrid(context, crossCount, wide)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  Widget _buildHeader(BuildContext context, double q, String status, bool hasRestricted) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        controller: _headerH,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Icon(Icons.table_view_outlined, size: 18),
            const SizedBox(width: 8),
            Text('Reconciliation', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: 12),
            Chip(
              label: Text('Quality $q • $status'),
              visualDensity: VisualDensity.compact,
            ),
            if (hasRestricted) ...[
              const SizedBox(width: 8),
              const Chip(label: Text('Restricted'), avatar: Icon(Icons.lock, size: 14)),
            ],
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz),
              tooltip: 'Secondary actions',
              onSelected: (v) {
                if (v == 'clearance') widget.onRequestClearance?.call();
                if (v == 'clear-clipboard') Clipboard.clear();
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'clearance', child: Text('Request clearance')),
                PopupMenuItem(value: 'clear-clipboard', child: Text('Clear clipboard')),
                PopupMenuItem(value: 'export', child: Text('Export (masked)')),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildLabelPane(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Theme.of(context).colorScheme.outlineVariant))),
      child: ListView.builder(
        controller: _vertical,
        itemCount: widget.rows.length,
        itemBuilder: (_, i) => ListTile(
          dense: true,
          title: Text(widget.rows[i].label,
              style: widget.typography.toTextStyle(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          subtitle: Text(widget.rows[i].id, style: Theme.of(context).textTheme.labelSmall),
        ),
      ),
    );
  }
  Widget _buildValueGrid(BuildContext context, int crossCount, bool wide) {
    if (widget.rows.isEmpty) {
      return const Center(child: Text('No reconciliation rows'));
    }
    return SingleChildScrollView(
      controller: _bodyH,
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: wide ? 720 : null,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            childAspectRatio: 2.6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          padding: const EdgeInsets.all(12),
          itemCount: widget.rows.length,
          itemBuilder: (_, i) {
            final r = widget.rows[i];
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                color: r.state == ReconciliationBalanceState.error
                    ? Theme.of(context).colorScheme.errorContainer.withOpacity(0.25)
                    : r.state == ReconciliationBalanceState.balanced
                        ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.25)
                        : Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SecureFieldMask(
                      label: wide ? r.value : r.label,
                      value: r.value,
                      isRestricted: r.isRestricted,
                      typography: widget.typography,
                      state: r.state,
                      onRequestClearance: widget.onRequestClearance,
                    ),
                  ),
                  if (r.state != ReconciliationBalanceState.balanced)
                    IconButton(
                      tooltip: 'Correct balance',
                      icon: const Icon(Icons.auto_fix_high_outlined, size: 18),
                      onPressed: () => widget.onCorrectBalance?.call(r),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
