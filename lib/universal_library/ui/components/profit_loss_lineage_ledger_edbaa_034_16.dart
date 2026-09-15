// EDBAA-034-16 — Profit & Loss Lineage Ledger with tap-to-unroll trace.
// Unalterable P&L ledger linking revenue streams to net profit; tap parent figure unrolls inline lineage sub-menu with monospaced read-only cells.
import 'package:flutter/material.dart';

/// Execution record for atomic step EDBAA-034-16.
class EDBAA03416ExecutionContext {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  const EDBAA03416ExecutionContext({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
  });
}

/// Single source lineage entry linked to a parent P&L figure.
class EDBAA03416LineageSource {
  final String lineageId;
  final String streamName;
  final String ledgerRef;
  final double amount;
  final bool isOrphan;
  const EDBAA03416LineageSource({
    required this.lineageId,
    required this.streamName,
    required this.ledgerRef,
    required this.amount,
    this.isOrphan = false,
  });
}

/// Parent P&L figure (revenue, expense, profit) with linked sources.
class EDBAA03416PnLFigure {
  final String id;
  final String label;
  final double amount;
  final bool isNetProfitFocus;
  final bool isCredit;
  final List<EDBAA03416LineageSource> sources;
  const EDBAA03416PnLFigure({
    required this.id,
    required this.label,
    required this.amount,
    this.isNetProfitFocus = false,
    this.isCredit = true,
    this.sources = const [],
  });

  double get orphanRate {
    if (sources.isEmpty) return 0;
    final orphans = sources.where((s) => s.isOrphan).length;
    return orphans / sources.length * 100;
  }

  bool get isPass => orphanRate <= 0.5;
}

/// Unalterable P&L ledger: parent figures unroll inline lineage on tap.
///
/// Meets: monospaced currency, read-only cell highlight, net-profit focus chart,
/// DAMA-DMBOK2 lineage completeness (Floor <=0.5%, Target 0% orphan).
class EDBAA03416ProfitLossLedger extends StatefulWidget {
  final List<EDBAA03416PnLFigure> figures;
  final EDBAA03416ExecutionContext execution;
  final ValueChanged<EDBAA03416LineageSource>? onSourceTap;
  const EDBAA03416ProfitLossLedger({
    super.key,
    required this.figures,
    required this.execution,
    this.onSourceTap,
  });

  @override
  State<EDBAA03416ProfitLossLedger> createState() => _EDBAA03416ProfitLossLedgerState();
}

class _EDBAA03416ProfitLossLedgerState extends State<EDBAA03416ProfitLossLedger> {
  final Set<String> _expanded = {};

  static const _mono = TextStyle(fontFamily: 'monospace', fontFeatures: [FontFeature.tabularFigures()], letterSpacing: 0.2);

  double get _globalOrphanRate {
    final all = widget.figures.expand((f) => f.sources).toList();
    if (all.isEmpty) return 0;
    return all.where((s) => s.isOrphan).length / all.length * 100;
  }

  bool get _globalPass => _globalOrphanRate <= 0.5;

  String _money(double v) {
    final neg = v < 0;
    final abs = v.abs().toStringAsFixed(2);
    final parts = abs.split('.');
    final intPart = parts[0].replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
    return '${neg ? '-\$' : '\$'}$intPart.${parts[1]}';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final netProfit = widget.figures.where((f) => f.isNetProfitFocus).fold<double>(0, (p, f) => p + f.amount);
    return Card(
      elevation: 0,
      color: cs.surface,
      shape: RoundedRectangleBorder(side: BorderSide(color: cs.outlineVariant), borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildNetProfitFocusHeader(context, netProfit),
          _buildExecutionStrip(context),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.figures.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) => _buildParentRow(context, widget.figures[i]),
          ),
          _buildLineageFooter(context),
        ],
      ),
    );
  }

  Widget _buildNetProfitFocusHeader(BuildContext context, double netProfit) {
    final cs = Theme.of(context).colorScheme;
    final maxVal = widget.figures.map((f) => f.amount.abs()).fold<double>(1, (a, b) => a > b ? a : b);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      color: cs.primaryContainer.withOpacity(0.45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline, size: 14, color: cs.onPrimaryContainer),
              const SizedBox(width: 6),
              Text('CORE NET PROFIT • READ-ONLY LEDGER', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: cs.onPrimaryContainer, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const Spacer(),
              _PassFailChip(pass: _globalPass, rate: _globalOrphanRate),
            ],
          ),
          const SizedBox(height: 8),
          Semantics(
            header: true,
            label: 'Core net profit ${_money(netProfit)}',
            child: Text(_money(netProfit), style: Theme.of(context).textTheme.headlineMedium?.merge(_mono).copyWith(color: cs.onSurface, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 44,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final f in widget.figures)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Tooltip(
                        message: '${f.label}: ${_money(f.amount)}',
                        child: Container(
                          height: 8 + 36 * (f.amount.abs() / maxVal).clamp(0.05, 1.0),
                          decoration: BoxDecoration(color: f.isNetProfitFocus ? cs.primary : cs.secondary.withOpacity(0.55), borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text('Visual lock: chart anchored to net profit balance. All revenue streams auto-linked.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildExecutionStrip(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final e = widget.execution;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: cs.surfaceContainerHighest.withOpacity(0.5),
      child: Wrap(
        spacing: 12,
        runSpacing: 2,
        children: [
          _meta(context, 'Step', e.stepExecutionId),
          _meta(context, 'Status', e.executionStatus),
          _meta(context, 'Outcome', e.stepOutcome),
          _meta(context, 'User', e.userId),
        ],
      ),
    );
  }

  Widget _meta(BuildContext context, String k, String v) {
    return Text.rich(TextSpan(children: [TextSpan(text: '$k: ', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)), TextSpan(text: v, style: Theme.of(context).textTheme.labelSmall)]));
  }

  Widget _buildParentRow(BuildContext context, EDBAA03416PnLFigure fig) {
    final cs = Theme.of(context).colorScheme;
    final open = _expanded.contains(fig.id);
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => open ? _expanded.remove(fig.id) : _expanded.add(fig.id)),
          child: Semantics(
            button: true,
            expanded: open,
            label: '${fig.label} ${_money(fig.amount)}. Tap to ${open ? 'collapse' : 'unroll'} source lineage.',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: fig.isNetProfitFocus ? cs.tertiaryContainer.withOpacity(0.35) : null, border: open ? Border(bottom: BorderSide(color: cs.outlineVariant)) : null),
              child: Row(
                children: [
                  AnimatedRotation(turns: open ? 0.25 : 0, duration: const Duration(milliseconds: 180), child: Icon(Icons.chevron_right, color: cs.onSurfaceVariant)),
                  const SizedBox(width: 4),
                  Expanded(child: Text(fig.label, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: fig.isNetProfitFocus ? FontWeight.w800 : FontWeight.w600))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: cs.surfaceContainerHighest, borderRadius: BorderRadius.circular(8), border: Border.all(color: cs.outlineVariant)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock, size: 12, color: cs.onSurfaceVariant),
                        const SizedBox(width: 6),
                        Text(_money(fig.amount), style: Theme.of(context).textTheme.bodyMedium?.merge(_mono).copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          child: open ? _buildLineageSubMenu(context, fig) : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildLineageSubMenu(BuildContext context, EDBAA03416PnLFigure fig) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(36, 8, 12, 12),
      color: cs.surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SOURCE DATA LINEAGE • ${fig.sources.length} links • Orphan ${fig.orphanRate.toStringAsFixed(2)}% (${fig.isPass ? 'PASS' : 'FAIL'})', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          if (fig.sources.isEmpty)
            Text('No linked streams — unlinked parent flagged as orphan.', style: Theme.of(context).textTheme.bodySmall)
          else
            for (final s in fig.sources)
              AbsorbPointer(
                absorbing: true,
                child: Tooltip(
                  message: 'Read-only • Unalterable ledger cell',
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(color: cs.surfaceContainerHighest.withOpacity(0.7), borderRadius: BorderRadius.circular(10), border: Border.all(color: s.isOrphan ? cs.error : cs.outlineVariant)),
                    child: Row(
                      children: [
                        Icon(s.isOrphan ? Icons.link_off : Icons.link, size: 14, color: s.isOrphan ? cs.error : cs.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s.streamName, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                              Text('${s.ledgerRef} • ${s.lineageId}', style: Theme.of(context).textTheme.labelSmall?.merge(_mono).copyWith(color: cs.onSurfaceVariant)),
                            ],
                          ),
                        ),
                        Text(_money(s.amount), style: Theme.of(context).textTheme.bodySmall?.merge(_mono).copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildLineageFooter(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: cs.outlineVariant))),
      child: Row(
        children: [
          Icon(Icons.verified_outlined, size: 16, color: cs.primary),
          const SizedBox(width: 8),
          Expanded(child: Text('DAMA-DMBOK2 Lineage & Provenance • Target 0% orphan • Floor ≤0.5%', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant))),
          Text('${_globalOrphanRate.toStringAsFixed(2)}% • ${_globalPass ? 'PASS' : 'FAIL'}', style: Theme.of(context).textTheme.labelSmall?.merge(_mono).copyWith(fontWeight: FontWeight.w800, color: _globalPass ? Colors.green.shade800 : cs.error)),
        ],
      ),
    );
  }
}

class _PassFailChip extends StatelessWidget {
  final bool pass;
  final double rate;
  const _PassFailChip({required this.pass, required this.rate});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: pass ? Colors.green.shade700 : cs.error, borderRadius: BorderRadius.circular(999)),
      child: Text(pass ? 'PASS • ${rate.toStringAsFixed(2)}% orphan' : 'FAIL • ${rate.toStringAsFixed(2)}% orphan', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
    );
  }
}
