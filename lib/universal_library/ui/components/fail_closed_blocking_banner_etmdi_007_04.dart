// ETMDI-007-04 — Fail-Closed Blocking Banner mounted below header.
// Mounts contextual alert cards directly under top header layouts with fail-closed defaults and SRE alert-coverage observability.
import 'package:flutter/material.dart';

/// Qualitative completion rating aligned to SRE observability standard.
/// Best = Good (100%). Reference: Google SRE Handbook — Monitoring Distributed Systems.
enum BannerCompletionRating { good, average, poor }

/// Visual tone for blocking banner. Fail-closed uses critical by default.
enum BlockingBannerTone { critical, warning, info }

/// Layout spec for atomic row 4098: Layout Type, Grid, Spacing, Alignment, Validation.
@immutable
class BlockingBannerLayoutSpec {
  final String layoutType;
  final int gridColumns;
  final double horizontalSpacing;
  final double verticalSpacing;
  final AlignmentGeometry alignment;
  final bool isValidated;

  const BlockingBannerLayoutSpec({
    this.layoutType = 'full-width-below-header',
    this.gridColumns = 12,
    this.horizontalSpacing = 16.0,
    this.verticalSpacing = 8.0,
    this.alignment = Alignment.topCenter,
    this.isValidated = true,
  });

  String get validationStatus => isValidated ? 'valid' : 'invalid';

  Map<String, Object> toDataFields() => <String, Object>{
    'Layout Type': layoutType,
    'Layout Grid Dimensions': '12-col x fluid / $gridColumns cols',
    'Spacing Rules': 'h:$horizontalSpacing v:$verticalSpacing',
    'Alignment Settings': alignment.toString(),
    'Layout Validation Status': validationStatus,
  };
}

/// Data model collected by system for observability / alert coverage.
@immutable
class FailClosedBannerData {
  final String id;
  final String title;
  final String message;
  final BlockingBannerTone tone;
  final DateTime timestamp;
  final String userSessionId;
  final BannerCompletionRating rating;

  const FailClosedBannerData({
    required this.id,
    required this.title,
    required this.message,
    this.tone = BlockingBannerTone.critical,
    required this.timestamp,
    required this.userSessionId,
    this.rating = BannerCompletionRating.good,
  });

  double get coverageScore {
    switch (rating) {
      case BannerCompletionRating.good:
        return 1.0;
      case BannerCompletionRating.average:
        return 0.9;
      case BannerCompletionRating.poor:
        return 0.0;
    }
  }

  String get completionStatus {
    switch (rating) {
      case BannerCompletionRating.good:
        return 'Good';
      case BannerCompletionRating.average:
        return 'Average';
      case BannerCompletionRating.poor:
        return 'Poor';
    }
  }
}

/// Fail-closed blocking banner mounted contextually right below top header.
///
/// Fail-closed rule: if [isHealthy] is null, unknown, or [forceBlock] is true,
/// the banner is SHOWN (blocked). It only hides on explicit healthy + validated layout.
class FailClosedBlockingBanner extends StatelessWidget {
  final FailClosedBannerData? banner;
  final bool? isHealthy;
  final bool forceBlock;
  final BlockingBannerLayoutSpec layoutSpec;
  final VoidCallback? onPrimaryAction;
  final String primaryActionLabel;
  final VoidCallback? onDismiss;
  final bool allowDismiss;
  final ValueChanged<Map<String, Object>>? onObservabilityEvent;

  const FailClosedBlockingBanner({
    super.key,
    required this.banner,
    required this.isHealthy,
    this.forceBlock = false,
    this.layoutSpec = const BlockingBannerLayoutSpec(),
    this.onPrimaryAction,
    this.primaryActionLabel = 'Review status',
    this.onDismiss,
    this.allowDismiss = false,
    this.onObservabilityEvent,
  });

  bool get shouldBlock {
    if (forceBlock) return true;
    if (isHealthy == null) return true;
    if (isHealthy == false) return true;
    if (!layoutSpec.isValidated) return true;
    if (banner == null) return true;
    return false;
  }

  FailClosedBannerData _effectiveBanner() {
    if (banner != null) return banner!;
    return FailClosedBannerData(
      id: 'fail-closed-fallback',
      title: 'Action required — status unavailable',
      message: 'We could not verify system status. Access is blocked to keep you safe.',
      tone: BlockingBannerTone.critical,
      timestamp: DateTime.now().toUtc(),
      userSessionId: 'unknown-session',
      rating: BannerCompletionRating.poor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool blocked = shouldBlock;
    final data = _effectiveBanner();

    if (!blocked) return const SizedBox.shrink();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onObservabilityEvent?.call(<String, Object>{
        'Observability / Alert Coverage': data.coverageScore,
        'Completion Status': data.completionStatus,
        'Action/Event Timestamp': data.timestamp.toIso8601String(),
        'User/Session ID': data.userSessionId,
        ...layoutSpec.toDataFields(),
      });
    });

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bg = _backgroundFor(data.tone, colorScheme);
    final fg = _foregroundFor(data.tone, colorScheme);

    return Semantics(
      liveRegion: true,
      header: false,
      label: 'Blocking alert: ${data.title}',
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          left: layoutSpec.horizontalSpacing,
          right: layoutSpec.horizontalSpacing,
          top: layoutSpec.verticalSpacing,
          bottom: layoutSpec.verticalSpacing,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: fg.withOpacity(0.35)),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(_iconFor(data.tone), color: fg, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(data.title, style: theme.textTheme.titleSmall?.copyWith(color: fg, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(data.message, style: theme.textTheme.bodySmall?.copyWith(color: fg)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: onPrimaryAction,
                            child: Text(primaryActionLabel),
                          ),
                          if (allowDismiss)
                            TextButton(onPressed: onDismiss, child: const Text('Dismiss')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _backgroundFor(BlockingBannerTone tone, ColorScheme s) {
    switch (tone) {
      case BlockingBannerTone.critical:
        return s.errorContainer;
      case BlockingBannerTone.warning:
        return s.tertiaryContainer;
      case BlockingBannerTone.info:
        return s.secondaryContainer;
    }
  }

  Color _foregroundFor(BlockingBannerTone tone, ColorScheme s) {
    switch (tone) {
      case BlockingBannerTone.critical:
        return s.onErrorContainer;
      case BlockingBannerTone.warning:
        return s.onTertiaryContainer;
      case BlockingBannerTone.info:
        return s.onSecondaryContainer;
    }
  }

  IconData _iconFor(BlockingBannerTone tone) {
    switch (tone) {
      case BlockingBannerTone.critical:
        return Icons.block_flipped;
      case BlockingBannerTone.warning:
        return Icons.warning_amber_rounded;
      case BlockingBannerTone.info:
        return Icons.info_outline;
    }
  }
}

/// Slot helper that guarantees banner sits right below the top header layout.
/// Use inside Scaffold body: [header] then banner then [child].
class FailClosedHeaderBannerSlot extends StatelessWidget {
  final Widget header;
  final FailClosedBlockingBanner banner;
  final Widget child;

  const FailClosedHeaderBannerSlot({
    super.key,
    required this.header,
    required this.banner,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        banner,
        Expanded(child: child),
      ],
    );
  }
}

/// Helper to evaluate Floor >=90% / Optimal 1.0 / Ceiling 1.0 coverage.
class AlertCoverageEvaluator {
  static const double floor = 0.9;
  static const double optimal = 1.0;
  static const double ceiling = 1.0;

  static bool meetsFloor(double coverage) => coverage >= floor;
  static BannerCompletionRating ratingFor(double coverage) {
    if (coverage >= 1.0) return BannerCompletionRating.good;
    if (coverage >= floor) return BannerCompletionRating.average;
    return BannerCompletionRating.poor;
  }
}
